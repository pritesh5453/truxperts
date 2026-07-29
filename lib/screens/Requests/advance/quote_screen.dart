import 'package:flutter/material.dart';
import 'package:truxperts/screens/Requests/advance/payment_screen.dart';
import 'package:truxperts/utils/appcolors.dart';

class QuoteDetailsScreen extends StatelessWidget {
  const QuoteDetailsScreen({Key? key}) : super(key: key);

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
          'Quote Details',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Studio Header Profile
            _buildProfileHeader(),
            const SizedBox(height: 16),

            // 2. Price & Validity Banner
            _buildPriceValidityBanner(),
            const SizedBox(height: 16),

            // 3. Package Inclusions Card
            _buildPackageInclusions(),
            const SizedBox(height: 16),

            // 4. Package Descriptions & Payment Terms Card
            _buildPackageDescriptionAndTerms(),
            const SizedBox(height: 20),

            // 5. How It Works Section
            _buildHowItWorks(),
            const SizedBox(height: 16),

            // 6. Secure Booking Banner
            _buildSecureBookingBanner(),
            const SizedBox(height: 20),

            // 7. Confirm Booking Card (Now part of the scroll)
            _buildConfirmBooking(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // --- 1. Profile Header ---
  Widget _buildProfileHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Click Magic Studios',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.check_circle, color: AppColors.blueAccent, size: 18),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Text(
                  '5.0',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(Icons.star, color: AppColors.star, size: 14),
                const SizedBox(width: 4),
                const Text(
                  '(128 Reviews)',
                  style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                ),
                const Text(
                  '  •  7 Years in Business',
                  style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // --- 2. Price & Validity Banner ---
  Widget _buildPriceValidityBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.instantBannerBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Package Price',
                style: TextStyle(fontSize: 11, color: AppColors.textGrey, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              const Text(
                '₹55,000',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: const [
                  Icon(Icons.check, color: AppColors.success, size: 12),
                  SizedBox(width: 2),
                  Text(
                    'Includes all taxes',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.success,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'Valid Till',
                style: TextStyle(fontSize: 11, color: AppColors.textGrey, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4),
              Text(
                '12 Jul 2025',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(height: 2),
              Text(
                '(03 Days Left)',
                style: TextStyle(fontSize: 10, color: AppColors.textGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 3. Package Inclusions ---
  Widget _buildPackageInclusions() {
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
          const Text(
            'Package Inclusions',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: const [
                    _InclusionItem(icon: Icons.calendar_today_outlined, label: 'Full Day Coverage'),
                    SizedBox(height: 12),
                    _InclusionItem(icon: Icons.video_camera_back_outlined, label: 'Cinematic Video (5-7 mins)'),
                    SizedBox(height: 12),
                    _InclusionItem(icon: Icons.photo_library_outlined, label: 'Photo Album (40 pages)'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: const [
                    _InclusionItem(icon: Icons.flight_outlined, label: 'Drone Shoot'),
                    SizedBox(height: 12),
                    _InclusionItem(icon: Icons.image_outlined, label: 'All Edited Photos (600+)'),
                    SizedBox(height: 12),
                    _InclusionItem(icon: Icons.people_outline, label: '2 Photographers + 1 Assistant'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 4. Package Descriptions & Payment Terms ---
  Widget _buildPackageDescriptionAndTerms() {
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
          const Text(
            'Package Descriptions',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'We will cover your special day from getting ready to the last ceremony with high quality candid & traditional photography. You will get all edited photos, cinematic video and premium album.',
            style: TextStyle(fontSize: 12, color: AppColors.textGrey, height: 1.4),
          ),
          const SizedBox(height: 16),
          const Text(
            'Payment Terms',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '• Advance (upon booking): ₹10,000 (Refundable)\n• Remaining Amount: On event date',
            style: TextStyle(fontSize: 12, color: AppColors.textDark, height: 1.5),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.advanceBannerBg,
                side: const BorderSide(color: AppColors.lightPurple),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'Contact Professional',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryPurple,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // --- 5. How It Works ---
  Widget _buildHowItWorks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How It Works',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStepItem(Icons.description_outlined, 'Select Quote'),
            _buildArrow(),
            _buildStepItem(Icons.account_balance_wallet_outlined, 'Pay Advance'),
            _buildArrow(),
            _buildStepItem(Icons.event_available_outlined, 'Booking\nConfirmed'),
            _buildArrow(),
            _buildStepItem(Icons.assignment_outlined, 'Event Day'),
            _buildArrow(),
            _buildStepItem(Icons.check_circle_outline, 'Complete'),
          ],
        ),
      ],
    );
  }

  Widget _buildStepItem(IconData icon, String title) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: AppColors.advanceBannerBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primaryPurple, size: 18),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10, color: AppColors.textDark, height: 1.1),
        )
      ],
    );
  }

  Widget _buildArrow() {
    return const Icon(
      Icons.arrow_forward_ios,
      size: 10,
      color: AppColors.primaryPurple,
    );
  }

  // --- 6. Secure Booking Banner ---
  Widget _buildSecureBookingBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.advanceBannerBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: const [
          Icon(Icons.shield_outlined, color: AppColors.primaryPurple, size: 22),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Booking',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
                SizedBox(height: 2),
                Text(
                  'Your payment is safe with us. You\'ll only be charged after confirming the booking.',
                  style: TextStyle(fontSize: 10, color: AppColors.textGrey, height: 1.3),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- 7. Confirm Booking (Inline, not sticky) ---
  Widget _buildConfirmBooking(context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Confirm Booking',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),

          // Selected Professional & Price Row
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.scaffoldLightBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Click Magic Studios',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.check_circle, color: AppColors.blueAccent, size: 14),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: const [
                          Text(
                            '5.0',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(Icons.star, color: AppColors.star, size: 12),
                          SizedBox(width: 2),
                          Text(
                            '(128 Reviews)',
                            style: TextStyle(fontSize: 10, color: AppColors.textGrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      'Package Price',
                      style: TextStyle(fontSize: 10, color: AppColors.textGrey),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '₹55,000',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Advance Payable Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Advance Payable (Refundable)',
                style: TextStyle(fontSize: 12, color: AppColors.textDark),
              ),
              Text(
                '₹10,000',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Information Note Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.advanceBannerBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Icon(Icons.info_outline, color: AppColors.primaryPurple, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'You won\'t be charged now. Payment will be made after you confirm the booking.',
                    style: TextStyle(fontSize: 10, color: AppColors.primaryPurple),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Main Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                print("Button Pressed");
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const PaymentScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Proceed to Book',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),

          // Cancel Text Button
          Center(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryPurple,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper Widget for Inclusion Grid Items
class _InclusionItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InclusionItem({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.advanceBannerBg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: AppColors.primaryPurple, size: 16),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.textDark, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}