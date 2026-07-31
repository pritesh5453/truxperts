import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:truxperts/Customer/screen/notification/notification_screen.dart';
import 'package:truxperts/utils/appcolors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final int notificationCount;
  final VoidCallback? onNotificationTap;
  final bool showBackButton;

  const CommonAppBar({
    Key? key,
    this.onBackPressed,
    this.notificationCount = 5,
    this.onNotificationTap,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.bg,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xff1A1A2E)),
              onPressed: onBackPressed ?? () => Navigator.pop(context),
            )
          : null,
      centerTitle: true,
      title: Column(
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: 'Tru',
                  style: TextStyle(color: Color(0xff1C2D5A)),
                ),
                TextSpan(
                  text: 'Xperts',
                  style: TextStyle(color: Color(0xffE65F2B)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            "— Trusted Professionals, One Tap Away. —",
            style: TextStyle(
              fontSize: 8,
              color: Color(0xff6C757D),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(LucideIcons.bell, color: Color(0xff1A1A2E)),
              onPressed: onNotificationTap ??
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotificationsScreen(),
                      ),
                    );
                  },
            ),
            if (notificationCount > 0)
              Positioned(
                top: 10,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$notificationCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}