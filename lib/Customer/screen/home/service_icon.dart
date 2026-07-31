import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';

class ServiceIconTile extends StatelessWidget {
  final String icon;
  final String label;
  final Color iconBg;
  final Color iconColor;
  final bool selected;
  final VoidCallback? onTap;

  const ServiceIconTile({
    super.key,
    required this.icon,
    required this.label,
    required this.iconBg,
    required this.iconColor,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: selected ? AppColors.navy : AppColors.fieldBorder,
              ),
              image: DecorationImage(
                image: AssetImage(icon),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
