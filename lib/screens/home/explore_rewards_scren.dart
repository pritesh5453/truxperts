import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';

// Tumhari AppColors class directly import/use ho rahi hai
class ExploreRewardsScreen extends StatelessWidget {
  const ExploreRewardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: CommonAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Points Balance Hero Card
            _buildPointsBalanceCard(),

            const SizedBox(height: 20),

            // 2. Daily Rewards / Scratch Cards Section
            _buildSectionHeader('Unlocked Rewards', 'View All'),
            const SizedBox(height: 12),
            _buildRewardsCarousel(),

            const SizedBox(height: 24),

            // 3. Milestone Level Progress Card
            _buildMilestoneCard(),

            const SizedBox(height: 24),

            // 4. Exclusive Vouchers List
            _buildSectionHeader('Available Coupons & Vouchers', null),
            const SizedBox(height: 12),
            _buildVoucherList(),
          ],
        ),
      ),
    );
  }

  // --- 1. Points Balance Card ---
  Widget _buildPointsBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.stars_rounded,
              size: 140,
              color: Colors.white.withOpacity(0.05),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.orange, width: 1),
                    ),
                    child: const Text(
                      'Gold Tier Member',
                      style: TextStyle(
                        color: AppColors.orangeLight,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(Icons.info_outline, color: AppColors.textSecondary, size: 18),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Total Reward Coins',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Icon(Icons.monetization_on, color: AppColors.star, size: 28),
                  SizedBox(width: 8),
                  Text(
                    '2,450',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.white12, thickness: 1),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '₹100 Coin Value = 1000 Pts',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: const [
                        Text(
                          'Redeem History',
                          style: TextStyle(
                            color: AppColors.orangeLight,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, color: AppColors.orangeLight, size: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 2. Rewards Scratch / Unlock Carousel ---
  Widget _buildRewardsCarousel() {
    final List<Map<String, dynamic>> rewards = [
      {
        'title': '₹150 Cashback',
        'subtitle': 'On Electrician Service',
        'icon': Icons.bolt,
        'bg': AppColors.iconElectricianBg,
        'fg': AppColors.iconElectricianFg,
        'unlocked': true,
      },
      {
        'title': '20% OFF',
        'subtitle': 'Plumbing Services',
        'icon': Icons.plumbing,
        'bg': AppColors.iconPlumberBg,
        'fg': AppColors.iconPlumberFg,
        'unlocked': true,
      },
      {
        'title': 'Mystery Gift',
        'subtitle': 'Scratch to reveal',
        'icon': Icons.card_giftcard,
        'bg': AppColors.badgePendingBg,
        'fg': AppColors.badgePendingText,
        'unlocked': false,
      },
    ];

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          final item = rewards[index];
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: item['bg'],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item['icon'], color: item['fg'], size: 20),
                    ),
                    if (!item['unlocked'])
                      const Icon(Icons.lock, size: 16, color: AppColors.textGrey)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item['subtitle'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textGrey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- 3. Level Progress Card ---
  Widget _buildMilestoneCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.advanceBannerBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryPurple.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.lightPurple,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.workspace_premium, color: AppColors.primaryPurple, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Next Milestone: Platinum Tier',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Earn 550 more points to unlock free delivery',
                      style: TextStyle(fontSize: 11, color: AppColors.textGrey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 2450 / 3000,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryPurple),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('2,450 Pts', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              Text('Goal: 3,000 Pts', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
            ],
          ),
        ],
      ),
    );
  }

  // --- 4. Coupon Cards List ---
  Widget _buildVoucherList() {
    final List<Map<String, String>> vouchers = [
      {
        'code': 'HOMEFEST50',
        'title': 'Flat ₹50 OFF on Home Cleaning',
        'desc': 'Valid on bookings above ₹499',
        'expiry': 'Expiring in 2 days',
      },
      {
        'code': 'EXPERT20',
        'title': '20% OFF Paint & Interior Work',
        'desc': 'Maximum discount up to ₹300',
        'expiry': 'Valid till end of month',
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vouchers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = vouchers[index];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.iconCleaningBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.local_offer, color: AppColors.iconCleaningFg, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item['desc']!,
                      style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['expiry']!,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: item['code']!));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Coupon code ${item['code']} copied!'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.smartSearchBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.blueAccent.withOpacity(0.3)),
                  ),
                  child: Text(
                    item['code']!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blueAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Helper Section Header ---
  Widget _buildSectionHeader(String title, String? actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        if (actionText != null)
          InkWell(
            onTap: () {},
            child: Text(
              actionText,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.orange,
              ),
            ),
          ),
      ],
    );
  }
}