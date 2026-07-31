import 'package:flutter/material.dart';
import 'package:truxperts/Customer/screen/advance/booking_confirm.dart';
import 'package:truxperts/utils/appcolors.dart';

class BookingStatusScreen extends StatelessWidget {
  const BookingStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldLightBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Booking Status',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // 1. Top Illustration / Hourglass Icon
            _buildIllustrationHeader(),
            const SizedBox(height: 16),

            // 2. Status Title & Subtitle
            const Text(
              'Waiting for\nProfessional Confirmation',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your booking request has been sent.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textGrey,
              ),
            ),
            const SizedBox(height: 14),

            // 3. Advance Paid Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.badgeAssignedBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '₹10,000 Advance Paid',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.success,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: AppColors.success,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 4. Main Booking Details Card
            _buildBookingDetailsCard(),
            const SizedBox(height: 24),

            // 5. View Booking Details Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => const BookingConfirmedScreen()));
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: AppColors.primaryPurple),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'View Booking Details',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryPurple,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Top Illustration ---
  Widget _buildIllustrationHeader() {
    return Center(
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          color: AppColors.lightPurple.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.hourglass_top_rounded,
            size: 56,
            color: AppColors.primaryPurple,
          ),
        ),
      ),
    );
  }

  // --- Main Card Component ---
  Widget _buildBookingDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Professional Profile & Chat Button
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Click Magic Studios',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.check_circle, color: AppColors.blueAccent, size: 16),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Wedding Photography',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 14,
                  color: AppColors.primaryPurple,
                ),
                label: const Text(
                  'Chat',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryPurple,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.lightPurple.withOpacity(0.4),
                  side: const BorderSide(color: AppColors.lightPurple),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.cardBorder),
          const SizedBox(height: 16),

          // Pricing Breakdown
          _buildAmountRow('Package Amount', '₹55,000'),
          const SizedBox(height: 10),
          _buildAmountRow('Advance Paid', '₹10,000'),
          const SizedBox(height: 10),
          _buildAmountRow('Remaining Amount', '₹45,000'),
          const SizedBox(height: 16),

          // Request Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Request Status',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.badgePendingBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Waiting for Confirmation',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.badgePendingText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Information Note Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.advanceBannerBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'The professional will confirm or decline your request within 24 hours.',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textDark,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // What happens next section
          const Text(
            'What happens next?',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),

          // Step 1: If Professional Accepts
          _buildOutcomeCard(
            icon: Icons.check_circle,
            iconColor: AppColors.green,
            title: 'If Professional Accepts',
            subtitle: 'Your booking will be confirmed and you will be notified.',
          ),
          const SizedBox(height: 10),

          // Step 2: If Professional Declines
          _buildOutcomeCard(
            icon: Icons.cancel,
            iconColor: Colors.redAccent,
            title: 'If Professional Declines / No Response',
            subtitle: 'Your advance payment will be refunded within 24 hours.',
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildOutcomeCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.scaffoldLightBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textGrey,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}