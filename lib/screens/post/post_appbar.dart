import 'package:flutter/material.dart';

class PostAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF001A4E)),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Column(
        children: [
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Tru',
                  style: TextStyle(
                      color: Color(0xFF001A4E),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'X',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'perts',
                  style: TextStyle(
                      color: Color(0xFF001A4E),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Text(
            "— Trusted Professionals, One Tap Away —",
            style: TextStyle(color: Colors.grey, fontSize: 8),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}