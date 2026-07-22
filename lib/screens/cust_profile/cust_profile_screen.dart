import 'package:flutter/material.dart';
import 'package:truxperts/screens/cust_profile/manage_address_screen.dart';
import 'package:truxperts/screens/cust_profile/transaction_history_screen.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Customer Hero Profile Card
              _buildCustomerHeroCard(),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    
                    // 2. Request Status Summary Tracker
                    _buildSectionHeader('My Requests Summary'),
                    const SizedBox(height: 12),
                    _buildRequestSummaryGrid(),
                    const SizedBox(height: 24),
                    
                    // 3. Account & Settings Options
                    _buildSectionHeader('Account Settings'),
                    const SizedBox(height: 12),
                    _buildAccountOptionsList(context),
                    const SizedBox(height: 24),
                    
                    // 4. Log Out Button Container
                    _buildLogoutButton(),
                    const SizedBox(height: 40),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // --- 1. Customer Main Profile Card ---
  Widget _buildCustomerHeroCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xff0F1E36), Color(0xff1C355E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white24,
            ),
            child: const Icon(Icons.account_circle, color: Colors.white, size: 55),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Rahul Sharma',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  '+91 98765 43210',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                SizedBox(height: 4),
                Text(
                  'rahul.sharma@email.com',
                  style: TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 20),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  // --- 2. Request Status Badges Matrix ---
  Widget _buildRequestSummaryGrid() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffEDF2F7)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildSummaryTile(Icons.assignment_outlined, '12', 'All Requests', const Color(0xff6338E2)),
              const SizedBox(width: 12),
              _buildSummaryTile(Icons.pending_actions, '4', 'Pending', const Color(0xffFF9F00)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildSummaryTile(Icons.build_circle_outlined, '2', 'In Progress', const Color(0xff2F80ED)),
              const SizedBox(width: 12),
              _buildSummaryTile(Icons.check_circle_outline, '6', 'Completed', const Color(0xff27AE60)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryTile(IconData icon, String count, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xffEDF2F7)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(count, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff1A1A2E))),
                Text(label, style: const TextStyle(fontSize: 11, color: Color(0xff718096))),
              ],
            )
          ],
        ),
      ),
    );
  }

  // --- 3. Settings & Options Rows ---
  // --- 3. Settings & Options Rows ---
  Widget _buildAccountOptionsList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffEDF2F7)),
      ),
      child: Column(
        children: [
          _buildMenuRow(
            icon: Icons.location_on_outlined,
            title: 'Manage Addresses',
            subtitle: 'Save home, office locations',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageAddressesScreen(),
                ),
              );
            },
          ),
          _buildDivider(),
          _buildMenuRow(
            icon: Icons.description_outlined,
            title: 'Transaction History',
            subtitle: 'Download PDF invoices',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransactionHistoryScreen(),
                ),
              );
            },
          ),
          _buildDivider(),
          _buildMenuRow(
            icon: Icons.headset_mic_outlined,
            title: 'Help & Customer Support',
            subtitle: '24/7 active resolution room',
            onTap: () {
              // Help & Support Screen Navigation
            },
          ),
          _buildDivider(),
          _buildMenuRow(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy & Terms',
            subtitle: 'Legal agreements',
            onTap: () {
              // Privacy Policy Screen Navigation
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xff1C2D5A), size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xffA0AEC0),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Color(0xffA0AEC0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, indent: 54, color: Color(0xffEDF2F7));
  }

  // --- 4. Log Out Interactive Action Layout ---
  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.logout, size: 18, color: AppColors.navy),
        label: const Text(
          'Log Out Account', 
          style: TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xffFEEBC8)),
          backgroundColor: AppColors.navy.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title, 
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xff1A1A2E)),
    );
  }
}