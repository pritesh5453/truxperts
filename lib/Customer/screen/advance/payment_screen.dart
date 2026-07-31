import 'package:flutter/material.dart';
import 'package:truxperts/Customer/screen/advance/booking_status_screen.dart';
import 'package:truxperts/utils/appcolors.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

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
          'Payment',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Booking Summary Card
            _buildBookingSummaryCard(),
            const SizedBox(height: 20),

            // 2. Pay Advance Amount & Payment Options Card
            _buildPayAdvanceCard(),
            const SizedBox(height: 16),

            // 3. Security Trust Badges Row
            _buildTrustBadgesRow(),
            const SizedBox(height: 24),

            // 4. Pay Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => const BookingStatusScreen()));
                },
                icon: const Icon(Icons.lock_outline, size: 18, color: Colors.white),
                label: const Text(
                  'Pay ₹10,000',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // 5. Cancel Button
            Center(
              child: TextButton(
                onPressed: () => Navigator.maybePop(context),
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
            const SizedBox(height: 16),

            // 6. Terms & Privacy Disclaimer
            const Center(
              child: Text(
                'By proceeding, you agree to TruXperts\nTerms & Conditions & Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textGrey,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- 1. Booking Summary Card ---
  Widget _buildBookingSummaryCard() {
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
            'Booking Summary',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.iconPhotographerBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.iconPhotographerFg,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Wedding Photography',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'by Click Magic Studios',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          _buildSummaryRow('Package Amount', '₹55,000', isBold: true),
          const SizedBox(height: 8),
          _buildSummaryRow('Advance Payment (10%)', '₹10,000', isBold: true),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: AppColors.cardBorder, height: 1),
          ),
          _buildSummaryRow('Remaining Amount', '₹45,000', isBold: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  // --- 2. Pay Advance Card & Options ---
  Widget _buildPayAdvanceCard() {
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
            'Pay Advance Amount',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '₹10,000',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.lock, size: 12, color: AppColors.success),
              SizedBox(width: 4),
              Text(
                'Secure Payment',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'UPI / Cards / Netbanking',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 10),

          // Payment Options List
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Column(
              children: [
                _buildPaymentOptionItem(
                  iconWidget: const Icon(Icons.account_balance_wallet_outlined, color: AppColors.textDark, size: 20),
                  title: 'UPI',
                  showDivider: true,
                ),
                _buildPaymentOptionItem(
                  iconWidget: const Icon(Icons.credit_card_outlined, color: AppColors.primaryPurple, size: 20),
                  title: 'Credit / Debit Card',
                  showDivider: true,
                ),
                _buildPaymentOptionItem(
                  iconWidget: const Icon(Icons.account_balance_outlined, color: AppColors.primaryPurple, size: 20),
                  title: 'Net Banking',
                  showDivider: true,
                ),
                _buildPaymentOptionItem(
                  iconWidget: const Icon(Icons.account_balance_wallet_sharp, color: AppColors.primaryPurple, size: 20),
                  title: 'Wallets',
                  showDivider: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptionItem({
    required Widget iconWidget,
    required String title,
    required bool showDivider,
  }) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          leading: iconWidget,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.primaryPurple),
          onTap: () {},
        ),
        if (showDivider)
          const Divider(height: 1, color: AppColors.cardBorder, indent: 14, endIndent: 14),
      ],
    );
  }

  // --- 3. Trust Badges Row ---
  Widget _buildTrustBadgesRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.scaffoldLightBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBadgeItem(Icons.verified_user_outlined, '100% Secure\nPayments'),
          _buildBadgeItem(Icons.shield_outlined, 'PCI DSS\nCertified'),
          _buildBadgeItem(Icons.account_balance_outlined, 'RBI Compliant\nGateway'),
        ],
      ),
    );
  }

  Widget _buildBadgeItem(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.success),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 9,
            color: AppColors.textDark,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}