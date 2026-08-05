import 'package:flutter/material.dart';
import 'package:truxperts/Model_n_svc/Profile/profile_model.dart';
import 'package:truxperts/Model_n_svc/Profile/profile_svc.dart';
import 'package:truxperts/Auth/login_screen.dart';
import 'package:truxperts/Customer/screen/cust_profile/edit_profile_screen.dart';
import 'package:truxperts/Customer/screen/cust_profile/transaction_history_screen.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';
import 'package:truxperts/utils/sharedPreference/apppreference.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({Key? key}) : super(key: key);

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  final ProfileService _profileService = ProfileService();
  UserProfile? _userProfile;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // 1. Get user ID from preferences
      final userData = await AppPreferences.getUser();
      if (userData == null || !userData.containsKey('id')) {
        // No user logged in → redirect to login
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
        return;
      }
      final userId = userData['id'] as int;

      // 2. Fetch profile from API
      final apiResponse = await _profileService.getProfile(userId: userId);
      if (apiResponse.success && apiResponse.data != null) {
        setState(() {
          _userProfile = apiResponse.data!;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = apiResponse.message;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load profile: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red, size: 48),
                          const SizedBox(height: 16),
                          Text(
                            _errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.navy,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Customer Hero Profile Card (now with real data)
                        _buildCustomerHeroCard(context),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              _buildSectionHeader('My Requests Summary'),
                              const SizedBox(height: 12),
                              _buildRequestSummaryGrid(),
                              const SizedBox(height: 24),
                              _buildSectionHeader('Account Settings'),
                              const SizedBox(height: 12),
                              _buildAccountOptionsList(context),
                              const SizedBox(height: 24),
                              _buildLogoutButton(context),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  // --- 1. Customer Main Profile Card (real data) ---
  Widget _buildCustomerHeroCard(BuildContext context) {
    final name = _userProfile?.fullName ?? 'User';
    final mobile = _userProfile?.mobileNumber ?? 'N/A';
    final email = _userProfile?.email ?? 'N/A';
    final userId = _userProfile?.id ?? 0;

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
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  mobile,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 22),
            onPressed: () {
              // Pass userId to dialog
              showEditProfileDialog(context, userId,);
            },
          ),
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
              // Help & Support Navigation
            },
          ),
          _buildDivider(),
          _buildMenuRow(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy & Terms',
            subtitle: 'Legal agreements',
            onTap: () {
              // Privacy Policy Navigation
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

  // --- 4. Log Out Button ---
  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () async {
          // Clear session and navigate to login
          await AppPreferences.clearSession();
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              ),
            );
          }
        },
        icon: const Icon(
          Icons.logout,
          size: 18,
          color: AppColors.navy,
        ),
        label: const Text(
          'Log Out Account',
          style: TextStyle(
            color: AppColors.navy,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xffFEEBC8)),
          backgroundColor: AppColors.navy.withOpacity(0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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