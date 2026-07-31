import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' hide Location; // ✅ Location class conflict resolved
import 'package:truxperts/screens/home/add_address_sheet.dart';
import 'package:truxperts/utils/appcolors.dart';

class LocationSelectorSheet {
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

  // Reverse geocoding – lat/lng se address nikaalo
  Future<String> _getAddressFromLatLng(double lat, double lng) async {
    try {
      // geocoding v5.0.0+ uses the Geocoding class instance API
      final Geocoding geocoding = Geocoding();
      List<Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String address = '';
        if (place.street != null && place.street!.isNotEmpty) {
          address += place.street!;
        }
        if (place.locality != null && place.locality!.isNotEmpty) {
          address += (address.isNotEmpty ? ', ' : '') + place.locality!;
        }
        if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
          address += (address.isNotEmpty ? ', ' : '') + place.administrativeArea!;
        }
        if (place.country != null && place.country!.isNotEmpty) {
          address += (address.isNotEmpty ? ', ' : '') + place.country!;
        }
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
          setState(() {
            _isLoading = false;
            _locationStatus = '⚠️ Please enable location services';
          });
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          setState(() {
            _isLoading = false;
            _locationStatus = '⚠️ Location permission denied';
          });
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
          SnackBar(
            content: Text('📍 $address'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );

        print('✅ Latitude: $lat, Longitude: $lng');
        print('✅ Address: $address');
      } else {
        setState(() {
          _isLoading = false;
          _locationStatus = '⚠️ Could not fetch location';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _locationStatus = '❌ Error: ${e.toString()}';
      });
      print('❌ Location error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: screenHeight * 0.7,
        decoration: const BoxDecoration(
          color: AppColors.scaffoldBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            // Drag handle
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.chipUnselected,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
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
                        Text(
                          'Select a location',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Search field
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
                                hintStyle:
                                    TextStyle(color: AppColors.hintText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Current Location Tile
                    _ActionTile(
                      icon: Icons.my_location_rounded,
                      iconColor: AppColors.primaryPurple,
                      iconBg: AppColors.lightPurple,
                      title: 'Use current location',
                      subtitle: _isLoading
                          ? 'Fetching location...'
                          : _locationStatus.isNotEmpty
                              ? _locationStatus
                              : 'Tap to get your current location',
                      onTap: _getCurrentLocation,
                      isLoading: _isLoading,
                    ),
                    Divider(color: AppColors.cardBorder, height: 28),

                    // Add Address Tile
                    _ActionTile(
                      icon: Icons.add_rounded,
                      iconColor: AppColors.navy,
                      iconBg: AppColors.lightBlue,
                      title: 'Add Address',
                      onTap: () {
                        Navigator.pop(context);
                        AddAddressSheet.show(context);
                      },
                    ),
                    Divider(color: AppColors.cardBorder, height: 28),

                    const SizedBox(height: 24),
                    Text(
                      'SAVED ADDRESSES',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                        color: AppColors.textGrey,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ✅ Current location card – dynamically shows fetched address
                    if (_currentAddress.isNotEmpty)
                      _SavedAddressCard(
                        label: 'Current Location',
                        distance: '0 m',
                        address: _currentAddress,
                        phone: 'Current location',
                      ),

                    // ✅ Hardcoded Home card (you can remove this if not needed)
                    
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
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.primaryPurple,
                    ),
                  )
                : Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.navy,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.35,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (!isLoading)
            Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _SavedAddressCard extends StatelessWidget {
  final String label;
  final String distance;
  final String address;
  final String phone;

  const _SavedAddressCard({
    required this.label,
    required this.distance,
    required this.address,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Icon(Icons.home_rounded,
                    color: AppColors.textSecondary, size: 20),
              ),
              const SizedBox(height: 4),
              Text(
                distance,
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 13, color: AppColors.textDark),
                    children: [
                      const TextSpan(text: 'Phone number: '),
                      TextSpan(
                        text: phone,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _RoundIconBtn(icon: Icons.more_horiz),
                    const SizedBox(width: 10),
                    _RoundIconBtn(icon: Icons.share_outlined),
                    const SizedBox(width: 10),
                    _RoundIconBtn(icon: Icons.camera_alt_outlined),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundIconBtn extends StatelessWidget {
  final IconData icon;
  const _RoundIconBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.chipUnselected,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 16, color: AppColors.primaryPurple),
    );
  }
}