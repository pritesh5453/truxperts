import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({
    super.key,
    this.amount = 1200,
    this.starRating = 5,
  });

  final int amount;
  final int starRating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            children: [
              const SizedBox(height: 8),
              _buildIllustration(),
              const SizedBox(height: 24),
              const Text(
                'Thank You!',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Payment completed and review submitted successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              _buildSummaryCard(),
              const Spacer(),
              _buildBackToHomeButton(context),
              const SizedBox(height: 16),
              _buildDownloadInvoiceButton(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.bg,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
    );
  }

  Widget _buildIllustration() {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 4,
            right: 20,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.lightPurple,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: AppColors.lightBlue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              color: AppColors.lightPurple,
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(
              Icons.assignment_outlined,
              color: AppColors.primaryPurple,
              size: 60,
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          _buildRow(
            icon: Icons.credit_card_rounded,
            iconBg: AppColors.iconPlumberBg,
            iconFg: AppColors.iconPlumberFg,
            label: 'Payment',
            valueWidget: Text(
              '₹ $amount',
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            badgeText: 'Paid',
          ),
          const Divider(height: 1, color: AppColors.borderLight),
          _buildRow(
            icon: Icons.star_rounded,
            iconBg: AppColors.badgePendingBg,
            iconFg: AppColors.star,
            label: 'Review',
            valueWidget: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                (index) => Icon(
                  index < starRating ? Icons.star_rounded : Icons.star_border_rounded,
                  color: AppColors.star,
                  size: 14,
                ),
              ),
            ),
            badgeText: 'Submitted',
          ),
          const Divider(height: 1, color: AppColors.borderLight),
          _buildRow(
            icon: Icons.description_outlined,
            iconBg: AppColors.iconElectricianBg,
            iconFg: AppColors.iconElectricianFg,
            label: 'Invoice',
            valueWidget: const SizedBox.shrink(),
            badgeText: 'Generated',
          ),
        ],
      ),
    );
  }

  Widget _buildRow({
    required IconData icon,
    required Color iconBg,
    required Color iconFg,
    required String label,
    required Widget valueWidget,
    required String badgeText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconFg, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          valueWidget,
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.badgeAssignedBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badgeText,
              style: const TextStyle(
                color: AppColors.badgeAssignedText,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackToHomeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navy,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'Back to Home',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildDownloadInvoiceButton() {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.download_rounded, color: AppColors.navy, size: 18),
      label: const Text(
        'Download Invoice',
        style: TextStyle(
          color: AppColors.navy,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}