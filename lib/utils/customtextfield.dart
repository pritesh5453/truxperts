import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';

/// A rounded, outlined text field with a leading icon, matching the
/// input style used throughout the Login / Sign Up screens.
class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final Widget? trailing;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.fieldBorder, width: 1.2),
      ),
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14.5, color: AppColors.textPrimary),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.hintText, fontSize: 14.5),
          prefixIcon: Icon(icon, size: 20, color: AppColors.textSecondary),
          suffixIcon: suffixIcon,
          suffix: trailing,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}