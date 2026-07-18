import 'package:flutter/material.dart';
import 'package:truxperts/screens/Requests/my_requests_screen.dart';
import 'package:truxperts/screens/chat/chat_listScreen.dart';
import 'package:truxperts/screens/cust_profile/cust_profile_screen.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/screens/home/homescreen.dart';
import 'package:truxperts/screens/post/post_requestScreen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 0;

  // ----- YAHAN SAARE SCREENS KA LIST HAI -----
  final List<Widget> _screens = [
    const HomeScreen(),     // 0 - Home
    const ChatListScreen(),  // 1 - Chats
    const PostRequestScreen(),   // 2 - Post
    const MyRequestsScreen(), // 3 - Favorites
    const CustomerProfileScreen(), // 4 - Profile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---- INDEXED STACK - SIRF SELECTED SCREEN DIKHEGI ----
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      // ---- CUSTOM NAVBAR (tumhara purana wala hi) ----
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 4 items (Home, Chats, Favorites, Profile)
              Positioned.fill(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
                    _buildNavItem(1, Icons.chat_bubble_outline, Icons.chat_bubble, 'Chats'),
                    const SizedBox(width: 40),
                    _buildNavItem(3, Icons.request_quote_outlined, Icons.request_quote, 'My Requests'),
                    _buildNavItem(4, Icons.person_outline, Icons.person, 'Profile'),
                  ],
                ),
              ),

              // Raised Post Button
              Positioned(
                top: -22,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () => _onItemTapped(2), // Index 2 = Post
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.navy, // Ya Colors.blue.shade700
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.blueAccent,
                                blurRadius: 14,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Post',
                          style: TextStyle(
                            fontSize: 11,
                            color: _selectedIndex == 2
                                ? AppColors.navy
                                : Colors.grey.shade600,
                            fontWeight: _selectedIndex == 2
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---- Helper: Individual Nav Item ----
  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            size: 24,
            color: isSelected ? AppColors.navy : Colors.grey.shade600,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isSelected ? AppColors.navy : Colors.grey.shade600,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// ----- DUMMY SCREEN (BAAD MEIN BADAL DENAA) -----
class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Center(
        child: Text(
          '$title Screen',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}