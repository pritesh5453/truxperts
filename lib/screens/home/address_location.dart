import 'package:flutter/material.dart';
import 'package:truxperts/screens/home/add_address_sheet.dart';
import 'package:truxperts/utils/appcolors.dart';

class LocationSelectorSheet {
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // height control karne ke liye zaroori
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) => const _LocationSheetContent(),
    );
  }
}

class _LocationSheetContent extends StatelessWidget {
  const _LocationSheetContent();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: screenHeight * 0.7, // 70% screen occupy karega
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

                    _ActionTile(
                      icon: Icons.my_location_rounded,
                      iconColor: AppColors.primaryPurple,
                      iconBg: AppColors.lightPurple,
                      title: 'Use current location',
                      subtitle:
                          'Row, Shivaji Nagar, Satpur Colony,\nNashik, Maharashtra, India',
                      onTap: () {},
                    ),
                    Divider(color: AppColors.cardBorder, height: 28),

                    _ActionTile(
                      icon: Icons.add_rounded,
                      iconColor: AppColors.navy,
                      iconBg: AppColors.lightBlue,
                      title: 'Add Address',
                      onTap: () {
                        Navigator.pop(context); // pehli sheet band karo
                        AddAddressSheet.show(context); // nayi sheet kholo
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

                    _SavedAddressCard(
                      label: 'Home',
                      distance: '0 m',
                      address:
                          'Shivaji Nagar, Satpur Colony,\nNashik',
                      phone: '+91-9876543210',
                    ),
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

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
            child: Icon(icon, color: iconColor, size: 22),
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