import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';

// Assuming AppColors is defined in app_colors.dart
// import 'app_colors.dart';

class TruXpertsRewardsScreen extends StatelessWidget {
  const TruXpertsRewardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: CommonAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title Header Section
            Center(
              child: Column(
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                      children: [
                        TextSpan(
                          text: 'Tru',
                          style: TextStyle(color: AppColors.navy),
                        ),
                        TextSpan(
                          text: 'Xperts',
                          style: TextStyle(color: AppColors.orange),
                        ),
                        TextSpan(
                          text: ' Rewards',
                          style: TextStyle(color: AppColors.textDark),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Earn Points',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '  •  ',
                        style: TextStyle(color: AppColors.orange, fontSize: 14),
                      ),
                      Text(
                        'Unlock Rewards',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '  •  ',
                        style: TextStyle(color: AppColors.orange, fontSize: 14),
                      ),
                      Text(
                        'Save More',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Points Banner
            _buildPointsBanner(),
            const SizedBox(height: 24),

            // How to Earn Points Section
            _buildSectionHeader(
              Icons.star_outline_rounded,
              'How to Earn Points?',
              iconColor: AppColors.primaryPurple,
            ),
            const SizedBox(height: 12),
            _buildEarnPointsGrid(),
            const SizedBox(height: 24),

            // Redeem Your Points Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionHeader(
                  Icons.card_giftcard_rounded,
                  'Redeem Your Points',
                  iconColor: AppColors.primaryPurple,
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Text(
                        'How it works?',
                        style: TextStyle(
                          color: AppColors.primaryPurple,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.primaryPurple,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildRedeemCards(),
            const SizedBox(height: 24),

            // How to Use Points Section
            _buildSectionHeader(
              Icons.info_outline_rounded,
              'How to Use Points?',
              iconColor: AppColors.primaryPurple,
            ),
            const SizedBox(height: 12),
            _buildUsePointsFlow(),
            const SizedBox(height: 24),

            // Information & Example Split Cards
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildImportantInfoCard()),
                const SizedBox(width: 12),
                Expanded(child: _buildExampleCard()),
              ],
            ),
            const SizedBox(height: 24),

            // Why Earn Rewards Section
            _buildSectionHeader(
              Icons.diamond_outlined,
              'Why Earn Rewards?',
              iconColor: AppColors.primaryPurple,
            ),
            const SizedBox(height: 12),
            _buildWhyEarnGrid(),
            const SizedBox(height: 16),

            // Bottom Trust Banner
            _buildTrustBanner(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // --- Widget Components ---

  Widget _buildSectionHeader(
    IconData icon,
    String title, {
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildPointsBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.advanceBannerBg.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightPurple, width: 1),
      ),
      child: Row(
        children: [
          // Gift Box Graphic Substitute
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  'assets/images/rewards.png',
                fit: BoxFit.cover,
                ),
              ),
             
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'TruXperts Rewards is our way of thanking you! Earn points on your activities and redeem them for discount coupons on your next booking.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Column(
              children: const [
                Text(
                  'Your Points',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.stars_rounded, color: AppColors.star, size: 20),
                    SizedBox(width: 4),
                    Text(
                      '250',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryPurple,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  'Points',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarnPointsGrid() {
    final items = [
      {
        'icon': Icons.person_add_alt_1_outlined,
        'title': 'New Account\nRegistration',
        'pts': '+50',
        'bg': AppColors.iconPhotographerBg,
        'fg': AppColors.iconPhotographerFg,
      },
      {
        'icon': Icons.badge_outlined,
        'title': 'Complete\nProfile',
        'pts': '+50',
        'bg': AppColors.iconTutorBg,
        'fg': AppColors.iconTutorFg,
      },
      {
        'icon': Icons.phonelink_ring_rounded,
        'title': 'Verify Mobile\nNumber',
        'pts': '+20',
        'bg': AppColors.iconCleaningBg,
        'fg': AppColors.iconCleaningFg,
      },
      {
        'icon': Icons.location_on_outlined,
        'title': 'Verify\nLocation',
        'pts': '+20',
        'bg': AppColors.iconCateringBg,
        'fg': AppColors.iconCateringFg,
      },
      {
        'icon': Icons.description_outlined,
        'title': 'Post a\nRequest',
        'pts': '+10',
        'bg': AppColors.iconTutorBg,
        'fg': AppColors.iconTutorFg,
      },
      {
        'icon': Icons.check_circle_outline_rounded,
        'title': 'Complete\na Service',
        'pts': '+50',
        'bg': AppColors.iconCleaningBg,
        'fg': AppColors.iconCleaningFg,
      },
      {
        'icon': Icons.star_outline_rounded,
        'title': 'Rate & Review\nVembor',
        'pts': '+20',
        'bg': AppColors.iconCateringBg,
        'fg': AppColors.iconCateringFg,
      },
      {
        'icon': Icons.camera_alt_outlined,
        'title': 'Upload Service\nPhotos',
        'pts': '+15',
        'bg': AppColors.iconWeddingBg,
        'fg': AppColors.iconWeddingFg,
      },
      {
        'icon': Icons.group_outlined,
        'title': 'Refer a\nFriend',
        'pts': '+100',
        'bg': AppColors.iconPhotographerBg,
        'fg': AppColors.iconPhotographerFg,
      },
      {
        'icon': Icons.cake_outlined,
        'title': 'Birthday\nBonus',
        'pts': '+50',
        'bg': AppColors.iconWeddingBg,
        'fg': AppColors.iconWeddingFg,
      },
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.68,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: item['bg'] as Color,
                child: Icon(
                  item['icon'] as IconData,
                  color: item['fg'] as Color,
                  size: 16,
                ),
              ),
              Text(
                item['title'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                  height: 1.1,
                ),
              ),
              Text(
                item['pts'] as String,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryPurple,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRedeemCards() {
    final redeemList = [
      {
        'pts': '100 Points',
        'value': '₹25 OFF',
        'bg': AppColors.iconCleaningBg,
        'btnColor': AppColors.green,
        'isGold': false,
      },
      {
        'pts': '250 Points',
        'value': '₹75 OFF',
        'bg': AppColors.badgePendingBg,
        'btnColor': AppColors.orange,
        'isGold': false,
      },
      {
        'pts': '500 Points',
        'value': '₹150 OFF',
        'bg': AppColors.lightPurple,
        'btnColor': AppColors.primaryPurple,
        'isGold': false,
      },
      {
        'pts': '1000 Points',
        'value': '₹400 OFF',
        'bg': AppColors.iconMedicineBg,
        'btnColor': AppColors.iconMedicineFg,
        'isGold': false,
      },
      {
        'pts': '2000 Points',
        'value': 'Gold Member\n+ ₹1000 OFF',
        'bg': AppColors.lightBlue,
        'btnColor': AppColors.blueAccent,
        'isGold': true,
      },
    ];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: redeemList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = redeemList[index];
          final isGold = item['isGold'] as bool;

          return Container(
            width: 100,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            decoration: BoxDecoration(
              color: (item['bg'] as Color).withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['pts'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isGold ? AppColors.blueAccent : AppColors.textDark,
                  ),
                ),
                isGold
                    ? Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.workspace_premium,
                          color: AppColors.blueAccent,
                          size: 28,
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: item['btnColor'] as Color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item['value'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                Text(
                  isGold ? item['value'] as String : 'Coupon',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    color: isGold
                        ? AppColors.blueAccent
                        : AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUsePointsFlow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStepItem(
            Icons.shopping_bag_outlined,
            'Book a\nService',
            AppColors.iconPainterBg,
            AppColors.iconPainterFg,
          ),
          const Icon(
            Icons.arrow_forward_rounded,
            size: 16,
            color: AppColors.textSecondary,
          ),
          _buildStepItem(
            Icons.stars_rounded,
            'Earn Points on\nCompleted Service',
            AppColors.badgePendingBg,
            AppColors.orange,
          ),
          const Icon(
            Icons.arrow_forward_rounded,
            size: 16,
            color: AppColors.textSecondary,
          ),
          _buildStepItem(
            Icons.local_offer_outlined,
            'Redeem Points for\nDiscount Coupon',
            AppColors.iconCleaningBg,
            AppColors.green,
          ),
          const Icon(
            Icons.arrow_forward_rounded,
            size: 16,
            color: AppColors.textSecondary,
          ),
          _buildStepItem(
            Icons.percent_rounded,
            'Apply Coupon &\nGet Discount',
            AppColors.lightBlue,
            AppColors.blueAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(IconData icon, String label, Color bg, Color fg) {
    return Column(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: bg,
          child: Icon(icon, color: fg, size: 18),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildImportantInfoCard() {
    final points = [
      'Points can only be used for discounts.',
      'Points cannot be converted into cash.',
      'Points cannot be transferred to another account.',
      'Points are valid for 12 months from the date of earning.',
      'Only one reward coupon can be used per booking.',
      'Reward points are credited only after successful service completion.',
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.shield_outlined,
                color: AppColors.primaryPurple,
                size: 16,
              ),
              SizedBox(width: 6),
              Text(
                'Important Information',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...points.map(
            (pt) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '✓ ',
                    style: TextStyle(
                      color: AppColors.primaryPurple,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      pt,
                      style: const TextStyle(
                        fontSize: 8.5,
                        color: AppColors.textSecondary,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.receipt_long_outlined,
                color: AppColors.primaryPurple,
                size: 16,
              ),
              SizedBox(width: 6),
              Text(
                'Example',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.scaffoldLightBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildExampleRow('Service Amount', '₹1,200', isBold: true),
                const SizedBox(height: 4),
                _buildExampleRow('Available Points', '500'),
                const SizedBox(height: 4),
                _buildExampleRow(
                  'Redeem Points',
                  '-500',
                  valueColor: Colors.red,
                ),
                const SizedBox(height: 4),
                _buildExampleRow('Discount', '-₹150', valueColor: Colors.red),
                const Divider(
                  height: 12,
                  thickness: 0.8,
                  color: AppColors.borderLight,
                ),
                _buildExampleRow(
                  'Final Amount',
                  '₹1,050',
                  isBold: true,
                  valueColor: AppColors.primaryPurple,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleRow(
    String title,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 9.5,
            color: isBold ? AppColors.textDark : AppColors.textSecondary,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 9.5,
            color: valueColor ?? AppColors.textDark,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildWhyEarnGrid() {
    final benefits = [
      {
        'icon': Icons.local_offer_outlined,
        'title': 'Discount\nCoupons',
        'bg': AppColors.iconCleaningBg,
        'fg': AppColors.green,
      },
      {
        'icon': Icons.account_balance_wallet_outlined,
        'title': 'Save More on\nBookings',
        'bg': AppColors.badgePendingBg,
        'fg': AppColors.orange,
      },
      {
        'icon': Icons.card_giftcard,
        'title': 'Exclusive\nOffers',
        'bg': AppColors.lightPurple,
        'fg': AppColors.primaryPurple,
      },
      {
        'icon': Icons.workspace_premium_outlined,
        'title': 'Priority\nBookings',
        'bg': AppColors.lightBlue,
        'fg': AppColors.blueAccent,
      },
      {
        'icon': Icons.cake_outlined,
        'title': 'Birthday\nGift',
        'bg': AppColors.iconMedicineBg,
        'fg': AppColors.iconMedicineFg,
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: benefits
          .map(
            (b) => Column(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: b['bg'] as Color,
                  child: Icon(
                    b['icon'] as IconData,
                    color: b['fg'] as Color,
                    size: 18,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  b['title'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _buildTrustBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.lightPurple.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: AppColors.primaryPurple,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 14, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Your trust and satisfaction drive our rewards program.',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryPurple,
                  ),
                ),
                Text(
                  'Thank you for choosing TruXperts. Keep earning and saving more!',
                  style: TextStyle(
                    fontSize: 8.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
