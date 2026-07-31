import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';

/// ------------------------------------------------------------
/// Kahin se bhi ye call karo bottom sheet kholne ke liye:
///
///   onTap: () => AddAddressSheet.show(context),
///
/// ------------------------------------------------------------
class AddAddressSheet {
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) => const _AddAddressContent(),
    );
  }
}

class _AddAddressContent extends StatefulWidget {
  const _AddAddressContent();

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

  String _selectedType = 'Home';

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
    super.dispose();
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      // TODO: yaha apna save logic / API call daal dena
      // Example object:
      final addressData = {
        'type': _selectedType,
        'flat': _flatCtrl.text,
        'area': _areaCtrl.text,
        'landmark': _landmarkCtrl.text,
        'city': _cityCtrl.text,
        'state': _stateCtrl.text,
        'pincode': _pincodeCtrl.text,
        'name': _nameCtrl.text,
        'phone': _phoneCtrl.text,
      };
      debugPrint(addressData.toString());

      Navigator.pop(context);
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
        height: screenHeight * 0.85, // form thoda lamba hai isliye 85%
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
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.chipUnselected,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 12, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Address',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.chipUnselected,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close,
                          size: 18, color: AppColors.textSecondary),
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
                      // Mini map placeholder / pinned location
                      Container(
                        height: 110,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.lightPurple,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(Icons.map_outlined,
                                size: 32, color: AppColors.navy),
                            Positioned(
                              bottom: 10,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.location_on,
                                      size: 14, color: AppColors.primaryPurple),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Pin exact location on map',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.navy,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      _sectionLabel('SAVE ADDRESS AS'),
                      const SizedBox(height: 10),
                      _AddressTypeChips(
                        selected: _selectedType,
                        onSelect: (v) => setState(() => _selectedType = v),
                      ),
                      const SizedBox(height: 20),

                      _sectionLabel('ADDRESS DETAILS'),
                      const SizedBox(height: 10),

                      _buildField(
                        controller: _flatCtrl,
                        label: 'Flat / House No. / Floor',
                        hint: 'e.g. Flat no 208',
                        icon: Icons.home_outlined,
                      ),
                      const SizedBox(height: 12),
                      _buildField(
                        controller: _areaCtrl,
                        label: 'Building / Area / Colony',
                        hint: 'e.g. Shivaji Nagar, Satpur Colony',
                        icon: Icons.location_city_outlined,
                      ),
                      const SizedBox(height: 12),
                      _buildField(
                        controller: _landmarkCtrl,
                        label: 'Landmark (optional)',
                        hint: 'e.g. Near XYZ School',
                        icon: Icons.flag_outlined,
                        required: false,
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: _buildField(
                              controller: _cityCtrl,
                              label: 'City',
                              hint: 'Nashik',
                              icon: Icons.location_city_outlined,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildField(
                              controller: _stateCtrl,
                              label: 'State',
                              hint: 'Maharashtra',
                              icon: Icons.map_outlined,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildField(
                        controller: _pincodeCtrl,
                        label: 'Pincode',
                        hint: 'e.g. 422001',
                        icon: Icons.pin_drop_outlined,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                      ),

                      const SizedBox(height: 20),
                      _sectionLabel('RECEIVER DETAILS'),
                      const SizedBox(height: 10),

                      _buildField(
                        controller: _nameCtrl,
                        label: 'Full Name',
                        hint: 'e.g. Rohan Sharma',
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 12),
                      _buildField(
                        controller: _phoneCtrl,
                        label: 'Phone Number',
                        hint: 'e.g. 9876543210',
                        icon: Icons.call_outlined,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                      ),

                      const SizedBox(height: 26),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _saveAddress,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.navy,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Save Address',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
        color: AppColors.textGrey,
      ),
    );
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
        Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: maxLength,
          validator: (value) {
            if (required && (value == null || value.trim().isEmpty)) {
              return 'Required';
            }
            return null;
          },
          style: TextStyle(fontSize: 13.5, color: AppColors.textPrimary),
          decoration: InputDecoration(
            counterText: '',
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.hintText, fontSize: 13),
            prefixIcon: Icon(icon, size: 18, color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.fieldFill,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.fieldBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.fieldBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primaryPurple, width: 1.4),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
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
                color: isSelected
                    ? AppColors.lightPurple
                    : AppColors.chipUnselected,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.navy
                      : Colors.transparent,
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 15,
                    color: isSelected
                        ? AppColors.navy
                        : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.navy
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}