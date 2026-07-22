import 'package:flutter/material.dart';
import 'package:truxperts/utils/common_appbar.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final VoidCallback? onBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.backgroundColor,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return CommonAppBar();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}