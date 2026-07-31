import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';

/// Simple reusable "coming soon" static screen used for every tab
/// that isn't wired up to real data yet.
class _StaticPlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const _StaticPlaceholderScreen({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: AppColors.primaryBlue),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Coming soon',
              style: TextStyle(fontSize: 12, color: AppColors.textGrey),
            ),
          ],
        ),
      ),
    );
  }
}

class LeadsScreen extends StatelessWidget {
  const LeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StaticPlaceholderScreen(
      title: 'Leads',
      icon: Icons.people_outline,
    );
  }
}

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StaticPlaceholderScreen(
      title: 'Bookings',
      icon: Icons.event_available_outlined,
    );
  }
}

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StaticPlaceholderScreen(
      title: 'Earnings',
      icon: Icons.account_balance_wallet_outlined,
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StaticPlaceholderScreen(
      title: 'Profile',
      icon: Icons.person_outline,
    );
  }
}