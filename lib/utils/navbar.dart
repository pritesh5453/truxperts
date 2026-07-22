import 'package:flutter/material.dart';
import 'package:truxperts/screens/Requests/my_requests_screen.dart';
import 'package:truxperts/screens/chat/chat_listScreen.dart';
import 'package:truxperts/screens/cust_profile/cust_profile_screen.dart';
import 'package:truxperts/screens/home/homescreen.dart';
import 'package:truxperts/screens/post/post_requestScreen.dart';
import 'package:truxperts/utils/appcolors.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 0;

  // Only 4 screens (PostRequestScreen is now a separate route)
  final List<Widget> _screens = [
    const HomeScreen(),
    const ChatListScreen(),
    const MyRequestsScreen(),
    const CustomerProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
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
              Positioned.fill(
                child: Row(
                  children: [
                    // Home (index 0)
                    Expanded(
                      child: _buildNavItem(
                        0,
                        Icons.home_outlined,
                        Icons.home,
                        'Home',
                      ),
                    ),
                    // Chats (index 1)
                    Expanded(
                      child: _buildNavItem(
                        1,
                        Icons.chat_bubble_outline,
                        Icons.chat_bubble,
                        'Chats',
                      ),
                    ),
                    // Space for floating button
                    const SizedBox(width: 70),
                    // My Requests (index 2)
                    Expanded(
                      child: _buildNavItem(
                        2,
                        Icons.request_quote_outlined,
                        Icons.request_quote,
                        'My Requests',
                      ),
                    ),
                    // Profile (index 3)
                    Expanded(
                      child: _buildNavItem(
                        3,
                        Icons.person_outline,
                        Icons.person,
                        'Profile',
                      ),
                    ),
                  ],
                ),
              ),
              // Floating Post Button
              Positioned(
                top: -22,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      // Push PostRequestScreen as a new full-screen route
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PostRequestScreen(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.navy,
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
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
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

  Widget _buildNavItem(
    int index,
    IconData icon,
    IconData activeIcon,
    String label,
  ) {
    final bool isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () => _onItemTapped(index),
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              size: 24,
              color: isSelected ? AppColors.navy : Colors.grey.shade600,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? AppColors.navy : Colors.grey.shade600,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}