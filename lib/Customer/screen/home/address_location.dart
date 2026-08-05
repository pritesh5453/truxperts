import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:truxperts/Customer/screen/home/add_address_sheet.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/Model_n_svc/address/address_model.dart';
import 'package:truxperts/Model_n_svc/address/address_svc.dart';
import 'package:truxperts/utils/sharedPreference/apppreference.dart';
import 'package:dio/dio.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

class LocationSelectorSheet {
  // ✅ New method that returns selected Address
  static Future<Address?> showWithResult(BuildContext context) {
    return showModalBottomSheet<Address>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) => const _LocationSheetContent(),
    );
  }

  // Keep old method for backward compatibility
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) => const _LocationSheetContent(),
    );
  }
}

class _LocationSheetContent extends StatefulWidget {
  const _LocationSheetContent();

  @override
  State<_LocationSheetContent> createState() => _LocationSheetContentState();
}

class _LocationSheetContentState extends State<_LocationSheetContent> {
  bool _isLoading = false;
  String _locationStatus = '';
  String _currentAddress = '';
  double? _currentLat;
  double? _currentLng;

  List<Address> _addresses = [];
  bool _loadingAddresses = false;
  int? _customerId;

  late AddressService _addressService;

  @override
  void initState() {
    super.initState();
    _addressService = AddressService(Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl)));
    _loadCustomerId();
  }

  Future<void> _loadCustomerId() async {
    final userData = await AppPreferences.getUser();
    final id = userData?['id'] as int?;
    if (id != null) {
      setState(() => _customerId = id);
      _fetchAddresses();
    }
  }

  Future<void> _fetchAddresses() async {
    if (_customerId == null) return;
    setState(() => _loadingAddresses = true);
    try {
      final addresses = await _addressService.getAddresses(_customerId!);
      setState(() => _addresses = addresses);
    } catch (e) {
      print('❌ Fetch addresses error: $e');
    } finally {
      setState(() => _loadingAddresses = false);
    }
  }

  Future<String> _getAddressFromLatLng(double lat, double lng) async {
    try {
      final geocoding = Geocoding();
      List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address = '';
        if (place.street != null && place.street!.isNotEmpty) address += place.street!;
        if (place.locality != null && place.locality!.isNotEmpty) address += (address.isNotEmpty ? ', ' : '') + place.locality!;
        if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) address += (address.isNotEmpty ? ', ' : '') + place.administrativeArea!;
        if (place.country != null && place.country!.isNotEmpty) address += (address.isNotEmpty ? ', ' : '') + place.country!;
        return address.isNotEmpty ? address : 'Unknown location';
      }
      return 'Address not found';
    } catch (e) {
      print('❌ Reverse geocoding error: $e');
      return 'Unable to fetch address';
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _locationStatus = 'Fetching location...';
      _currentAddress = '';
    });

    try {
      Location location = Location();
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          setState(() { _isLoading = false; _locationStatus = '⚠️ Please enable location services'; });
          return;
        }
      }
      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          setState(() { _isLoading = false; _locationStatus = '⚠️ Location permission denied'; });
          return;
        }
      }
      LocationData locationData = await location.getLocation();
      final lat = locationData.latitude;
      final lng = locationData.longitude;
      if (lat != null && lng != null) {
        _currentLat = lat;
        _currentLng = lng;
        String address = await _getAddressFromLatLng(lat, lng);
        _currentAddress = address;
        setState(() {
          _isLoading = false;
          _locationStatus = '📍 $address';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('📍 $address'), backgroundColor: Colors.green, duration: const Duration(seconds: 3)),
        );
      } else {
        setState(() { _isLoading = false; _locationStatus = '⚠️ Could not fetch location'; });
      }
    } catch (e) {
      setState(() { _isLoading = false; _locationStatus = '❌ Error: ${e.toString()}'; });
    }
  }

  Future<void> _deleteAddress(Address address) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Address'),
        content: Text('Are you sure you want to delete "${address.fullAddress}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
    if (confirm == true) {
      try {
        await _addressService.deleteAddress(address.id!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Address deleted'), backgroundColor: Colors.green),
        );
        _fetchAddresses();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _editAddress(Address address) {
    AddAddressSheet.show(context, address: address, onSaved: _fetchAddresses);
  }

  void _selectAddress(Address address) {
    Navigator.pop(context, address);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: screenHeight * 0.7,
        decoration: const BoxDecoration(
          color: AppColors.scaffoldBg,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Container(width: 40, height: 4, decoration: BoxDecoration(
                color: AppColors.chipUnselected, borderRadius: BorderRadius.circular(4),
              )),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('Select a location', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColors.fieldFill,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.fieldBorder),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: AppColors.primaryPurple),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search for area, street name...',
                                hintStyle: TextStyle(color: AppColors.hintText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    _ActionTile(
                      icon: Icons.my_location_rounded,
                      iconColor: AppColors.primaryPurple,
                      iconBg: AppColors.lightPurple,
                      title: 'Use current location',
                      subtitle: _isLoading ? 'Fetching...' : (_locationStatus.isNotEmpty ? _locationStatus : 'Tap to get your current location'),
                      onTap: _getCurrentLocation,
                      isLoading: _isLoading,
                    ),
                    Divider(color: AppColors.cardBorder, height: 28),

                    _ActionTile(
                      icon: Icons.add_rounded,
                      iconColor: AppColors.navy,
                      iconBg: AppColors.lightBlue,
                      title: 'Add Address',
                      onTap: () {
                        AddAddressSheet.show(context, onSaved: _fetchAddresses);
                      },
                    ),
                    Divider(color: AppColors.cardBorder, height: 28),

                    const SizedBox(height: 8),
                    Text(
                      'SAVED ADDRESSES',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.6, color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 12),

                    if (_loadingAddresses)
                      const Center(child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      ))
                    else if (_addresses.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(child: Text('No saved addresses', style: TextStyle(color: AppColors.textSecondary))),
                      )
                    else
                      ..._addresses.map((addr) => _buildAddressCard(addr)),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(Address address) {
    final isDefault = address.isDefault == 1;
    return GestureDetector(
      onTap: () => _selectAddress(address),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.chipUnselected,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    address.addressType.toLowerCase() == 'home' ? Icons.home_rounded :
                    address.addressType.toLowerCase() == 'work' ? Icons.work_rounded :
                    Icons.location_on_rounded,
                    color: AppColors.textSecondary, size: 20,
                  ),
                ),
                if (isDefault) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Default',
                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.primaryPurple),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.addressType,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address.fullAddress.isNotEmpty ? address.fullAddress : '${address.houseNo}, ${address.buildingArea}, ${address.city}',
                    style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.35),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                      children: [
                        const TextSpan(text: 'Phone: '),
                        TextSpan(text: address.receiverPhone, style: const TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _RoundIconBtn(
                        icon: Icons.edit_outlined,
                        onTap: () => _editAddress(address),
                      ),
                      const SizedBox(width: 10),
                      _RoundIconBtn(
                        icon: Icons.delete_outline,
                        onTap: () => _deleteAddress(address),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ========== Helper Widgets ==========
class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool isLoading;

  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: isLoading
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.5, color: AppColors.primaryPurple))
                : Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w600, color: AppColors.navy)),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle!, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.35)),
                ],
              ],
            ),
          ),
          if (!isLoading) Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _RoundIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const _RoundIconBtn({required this.icon, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.chipUnselected,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: color ?? AppColors.primaryPurple),
      ),
    );
  }
}