import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:truxperts/Model_n_svc/address/address_model.dart';
import 'package:truxperts/Model_n_svc/address/address_svc.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/sharedPreference/apppreference.dart';
import 'package:dio/dio.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

/// Add or Edit Address Sheet
class AddAddressSheet {
  static Future<void> show(
    BuildContext context, {
    Address? address,
    VoidCallback? onSaved,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) => _AddAddressContent(
        existingAddress: address,
        onSaved: onSaved,
      ),
    );
  }
}

class _AddAddressContent extends StatefulWidget {
  final Address? existingAddress;
  final VoidCallback? onSaved;

  const _AddAddressContent({this.existingAddress, this.onSaved});

  @override
  State<_AddAddressContent> createState() => _AddAddressContentState();
}

class _AddAddressContentState extends State<_AddAddressContent> {
  final _formKey = GlobalKey<FormState>();

  final _flatCtrl = TextEditingController();
  final _areaCtrl = TextEditingController();
  final _landmarkCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _stateCtrl = TextEditingController();
  final _pincodeCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _latCtrl = TextEditingController();
  final _lngCtrl = TextEditingController();

  String _selectedType = 'Home';
  bool _isDefault = false;
  bool _isLoading = false;
  bool _isFetchingLocation = false;

  late AddressService _addressService;
  int? _customerId;

  @override
  void initState() {
    super.initState();
    _addressService = AddressService(Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl)));
    _loadCustomerId();
    _prefillFields();
  }

  Future<void> _loadCustomerId() async {
    final userData = await AppPreferences.getUser();
    final id = userData?['id'] as int?;
    if (id != null) {
      setState(() => _customerId = id);
    }
  }

  void _prefillFields() {
    final addr = widget.existingAddress;
    if (addr != null) {
      _flatCtrl.text = addr.houseNo;
      _areaCtrl.text = addr.buildingArea;
      _landmarkCtrl.text = addr.landmark;
      _cityCtrl.text = addr.city;
      _stateCtrl.text = addr.state;
      _pincodeCtrl.text = addr.pincode;
      _nameCtrl.text = addr.receiverName;
      _phoneCtrl.text = addr.receiverPhone;
      _selectedType = addr.addressType;
      _isDefault = addr.isDefault == 1;
      _latCtrl.text = addr.latitude?.toString() ?? '';
      _lngCtrl.text = addr.longitude?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _flatCtrl.dispose();
    _areaCtrl.dispose();
    _landmarkCtrl.dispose();
    _cityCtrl.dispose();
    _stateCtrl.dispose();
    _pincodeCtrl.dispose();
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _latCtrl.dispose();
    _lngCtrl.dispose();
    super.dispose();
  }

  // ==================== FETCH LOCATION ====================
  Future<void> _fetchCurrentLocation() async {
    setState(() => _isFetchingLocation = true);

    try {
      Location location = Location();

      // Check service
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          _showSnackbar('Please enable location services', Colors.red);
          setState(() => _isFetchingLocation = false);
          return;
        }
      }

      // Check permission
      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          _showSnackbar('Location permission denied', Colors.red);
          setState(() => _isFetchingLocation = false);
          return;
        }
      }

      // Get location
      LocationData locationData = await location.getLocation();
      final lat = locationData.latitude;
      final lng = locationData.longitude;

      if (lat != null && lng != null) {
        setState(() {
          _latCtrl.text = lat.toStringAsFixed(7);
          _lngCtrl.text = lng.toStringAsFixed(7);
        });
        _showSnackbar('📍 Location fetched: $lat, $lng', Colors.green);
      } else {
        _showSnackbar('Could not fetch location', Colors.red);
      }
    } catch (e) {
      _showSnackbar('Error: ${e.toString()}', Colors.red);
    } finally {
      setState(() => _isFetchingLocation = false);
    }
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  // ==================== SAVE ADDRESS ====================
  // Only the _saveAddress method is updated for better error handling
Future<void> _saveAddress() async {
  if (!_formKey.currentState!.validate()) return;
  if (_customerId == null) {
    _showSnackbar('Please login again', Colors.red);
    return;
  }

  setState(() => _isLoading = true);

  final data = {
    'customer_id': _customerId!,
    'address_type': _selectedType,
    'house_no': _flatCtrl.text.trim(),
    'building_area': _areaCtrl.text.trim(),
    'landmark': _landmarkCtrl.text.trim(),
    'city': _cityCtrl.text.trim(),
    'state': _stateCtrl.text.trim(),
    'pincode': _pincodeCtrl.text.trim(),
    'receiver_name': _nameCtrl.text.trim(),
    'receiver_phone': _phoneCtrl.text.trim(),
    'latitude': double.tryParse(_latCtrl.text.trim()) ?? 0.0,
    'longitude': double.tryParse(_lngCtrl.text.trim()) ?? 0.0,
    'is_default': _isDefault ? 1 : 0,
  };

  // ✅ Debug: print data to verify
  print('📤 Sending address data: $data');

  try {
    if (widget.existingAddress != null) {
      await _addressService.updateAddress(widget.existingAddress!.id!, data);
      _showSnackbar('Address updated successfully', Colors.green);
    } else {
      final newId = await _addressService.addAddress(data);
      _showSnackbar('Address added successfully (ID: $newId)', Colors.green);
    }
    widget.onSaved?.call();
    Navigator.pop(context);
  } catch (e) {
    // ✅ Now this will only run if there's a genuine error
    print('❌ Save address error: $e');
    _showSnackbar('Error: ${e.toString()}', Colors.red);
  } finally {
    setState(() => _isLoading = false);
  }
}
  // ==================== BUILD ====================
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isEdit = widget.existingAddress != null;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: screenHeight * 0.85,
        decoration: const BoxDecoration(
          color: AppColors.scaffoldBg,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Drag handle
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: Container(width: 40, height: 4, decoration: BoxDecoration(
                color: AppColors.chipUnselected, borderRadius: BorderRadius.circular(4),
              )),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 12, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEdit ? 'Edit Address' : 'Add Address',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: AppColors.chipUnselected, shape: BoxShape.circle),
                      child: Icon(Icons.close, size: 18, color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: AppColors.cardBorder, height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ========== MAP PLACEHOLDER + LOCATION FETCH ==========
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.lightPurple,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.location_on, size: 16, color: AppColors.primaryPurple),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Tap to pick location on map',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.navy),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            // ✅ Fetch Location Button
                            InkWell(
                              onTap: _isFetchingLocation ? null : _fetchCurrentLocation,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.navy,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: _isFetchingLocation
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.my_location, color: Colors.white, size: 14),
                                          SizedBox(width: 4),
                                          Text(
                                            'Fetch',
                                            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      _sectionLabel('SAVE ADDRESS AS'),
                      const SizedBox(height: 8),
                      _AddressTypeChips(
                        selected: _selectedType,
                        onSelect: (v) => setState(() => _selectedType = v),
                      ),
                      const SizedBox(height: 16),

                      _sectionLabel('ADDRESS DETAILS'),
                      const SizedBox(height: 8),
                      _buildField(controller: _flatCtrl, label: 'Flat / House No.', hint: 'e.g. Flat no 208', icon: Icons.home_outlined),
                      const SizedBox(height: 12),
                      _buildField(controller: _areaCtrl, label: 'Building / Area', hint: 'e.g. Shivaji Nagar', icon: Icons.location_city_outlined),
                      const SizedBox(height: 12),
                      _buildField(controller: _landmarkCtrl, label: 'Landmark (optional)', hint: 'Near XYZ School', icon: Icons.flag_outlined, required: false),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: _buildField(controller: _cityCtrl, label: 'City', hint: 'Nashik', icon: Icons.location_city_outlined)),
                          const SizedBox(width: 12),
                          Expanded(child: _buildField(controller: _stateCtrl, label: 'State', hint: 'Maharashtra', icon: Icons.map_outlined)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildField(controller: _pincodeCtrl, label: 'Pincode', hint: '422001', icon: Icons.pin_drop_outlined, keyboardType: TextInputType.number, maxLength: 6),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: _buildField(controller: _latCtrl, label: 'Latitude', hint: '19.9975', icon: Icons.gps_fixed, keyboardType: const TextInputType.numberWithOptions(decimal: true))),
                          const SizedBox(width: 12),
                          Expanded(child: _buildField(controller: _lngCtrl, label: 'Longitude', hint: '73.7890', icon: Icons.gps_fixed, keyboardType: const TextInputType.numberWithOptions(decimal: true))),
                        ],
                      ),

                      const SizedBox(height: 16),
                      _sectionLabel('RECEIVER DETAILS'),
                      const SizedBox(height: 8),
                      _buildField(controller: _nameCtrl, label: 'Full Name', hint: 'Rohan Sharma', icon: Icons.person_outline),
                      const SizedBox(height: 12),
                      _buildField(controller: _phoneCtrl, label: 'Phone Number', hint: '9876543210', icon: Icons.call_outlined, keyboardType: TextInputType.phone, maxLength: 10),

                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Switch(
                            value: _isDefault,
                            onChanged: (val) => setState(() => _isDefault = val),
                            activeColor: AppColors.primaryPurple,
                          ),
                          const SizedBox(width: 8),
                          Text('Set as default address', style: TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                        ],
                      ),

                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _saveAddress,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.navy,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                              : Text(isEdit ? 'Update Address' : 'Save Address',
                                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== HELPERS ====================
  Widget _sectionLabel(String text) {
    return Text(text, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, letterSpacing: 0.6, color: AppColors.textGrey));
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    bool required = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: maxLength,
          validator: (value) {
            if (required && (value == null || value.trim().isEmpty)) return 'Required';
            return null;
          },
          style: const TextStyle(fontSize: 13.5, color: AppColors.textPrimary),
          decoration: InputDecoration(
            counterText: '',
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.hintText, fontSize: 13),
            prefixIcon: Icon(icon, size: 18, color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.fieldFill,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.fieldBorder)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.fieldBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.primaryPurple, width: 1.4)),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent)),
          ),
        ),
      ],
    );
  }
}

class _AddressTypeChips extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;

  const _AddressTypeChips({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final types = [
      {'label': 'Home', 'icon': Icons.home_rounded},
      {'label': 'Work', 'icon': Icons.work_rounded},
      {'label': 'Other', 'icon': Icons.location_on_rounded},
    ];
    return Row(
      children: types.map((t) {
        final label = t['label'] as String;
        final icon = t['icon'] as IconData;
        final isSelected = selected == label;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () => onSelect(label),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.lightPurple : AppColors.chipUnselected,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? AppColors.navy : Colors.transparent, width: 1.2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 15, color: isSelected ? AppColors.navy : AppColors.textSecondary),
                  const SizedBox(width: 6),
                  Text(label, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: isSelected ? AppColors.navy : AppColors.textSecondary)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
