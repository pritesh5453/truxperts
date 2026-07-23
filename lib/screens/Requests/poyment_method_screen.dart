import 'package:flutter/material.dart';
import 'package:truxperts/screens/Requests/payment_success_screen.dart';
import 'package:truxperts/utils/appcolors.dart';

enum PaymentMethod { cash, upi, card }

class ServicePaymentScreen extends StatefulWidget {
  const ServicePaymentScreen({super.key});

  @override
  State<ServicePaymentScreen> createState() => _ServicePaymentScreenState();
}

class _ServicePaymentScreenState extends State<ServicePaymentScreen> {
  PaymentMethod _selectedMethod = PaymentMethod.upi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            _buildServiceCard(),
            const SizedBox(height: 16),
            _buildVendorCard(),
            const SizedBox(height: 16),
            _buildAmountCard(),
            const SizedBox(height: 16),
            _buildPaymentMethodCard(),
          ],
        ),
      ),
      bottomNavigationBar: _buildProceedButton(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.cardBg,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      title: const Text(
        'TruXperts',
        style: TextStyle(
          color: AppColors.textDark,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications_none_rounded,
                  color: AppColors.textDark, size: 26),
              Positioned(
                right: -1,
                top: -1,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.badgeNotifBg,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppColors.cardBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.cardBorder),
    );
  }

  Widget _buildServiceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.iconElectricianBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.bolt_rounded,
              color: AppColors.iconElectricianFg,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Electrical Wiring Repair',
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.badgeAssignedBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Completed',
                    style: TextStyle(
                      color: AppColors.badgeAssignedText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.chipUnselected,
            backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/men/32.jpg',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'Amit Electricals',
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.verified_rounded,
                        color: AppColors.blueAccent, size: 16),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Icon(Icons.star_rounded, color: AppColors.star, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '4.7 (128 Reviews)',
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Service Amount',
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '₹ 1,200',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Amount set by vendor',
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Choose Payment Method',
              style: TextStyle(
                color: AppColors.textDark,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _buildPaymentOption(
            method: PaymentMethod.cash,
            label: 'Cash',
            icon: Icons.payments_outlined,
            iconBg: AppColors.badgeAssignedBg,
            iconFg: AppColors.badgeAssignedText,
          ),
          const Divider(height: 1, color: AppColors.borderLight),
          _buildPaymentOption(
            method: PaymentMethod.upi,
            label: 'UPI',
            icon: Icons.qr_code_rounded,
            iconBg: AppColors.iconCateringBg,
            iconFg: AppColors.iconCateringFg,
          ),
          const Divider(height: 1, color: AppColors.borderLight),
          _buildPaymentOption(
            method: PaymentMethod.card,
            label: 'Card',
            icon: Icons.credit_card_rounded,
            iconBg: AppColors.iconPlumberBg,
            iconFg: AppColors.iconPlumberFg,
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required PaymentMethod method,
    required String label,
    required IconData icon,
    required Color iconBg,
    required Color iconFg,
  }) {
    final bool isSelected = _selectedMethod == method;
    return InkWell(
      onTap: () => setState(() => _selectedMethod = method),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconFg, size: 18),
            ),
            const SizedBox(width: 12),
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
            Radio<PaymentMethod>(
              value: method,
              groupValue: _selectedMethod,
              activeColor: AppColors.primaryPurple,
              onChanged: (value) {
                if (value != null) setState(() => _selectedMethod = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProceedButton() {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {
           Navigator.push(context, 
           MaterialPageRoute(builder: (context) => const PaymentSuccessScreen()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryPurple,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            'Proceed to Pay',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}