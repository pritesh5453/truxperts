import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';

/// -----------------------------------------------------------------------
/// Simple model for a service item shown in the grid
/// -----------------------------------------------------------------------
class ServiceItem {
  final String label;
  final IconData icon;
  final Color bg;
  final Color fg;

  const ServiceItem({
    required this.label,
    required this.icon,
    required this.bg,
    required this.fg,
  });
}

/// -----------------------------------------------------------------------
/// ChooseServiceScreen2 (Advance Booking)
/// -----------------------------------------------------------------------
class ChooseServiceScreen2 extends StatelessWidget {
  const ChooseServiceScreen2({super.key});

  static const List<ServiceItem> advanceBooking = [
    ServiceItem(
        label: 'Photographer',
        icon: Icons.camera_alt,
        bg: AppColors.iconPhotographerBg,
        fg: AppColors.iconPhotographerFg),
    ServiceItem(
        label: 'Wedding Planner',
        icon: Icons.favorite,
        bg: AppColors.iconWeddingBg,
        fg: AppColors.iconWeddingFg),
    ServiceItem(
        label: 'Decorator',
        icon: Icons.celebration,
        bg: AppColors.iconDecoratorBg,
        fg: AppColors.iconDecoratorFg),
    ServiceItem(
        label: 'Catering',
        icon: Icons.restaurant,
        bg: AppColors.iconCateringBg,
        fg: AppColors.iconCateringFg),
    ServiceItem(
        label: 'Makeup Artist',
        icon: Icons.brush,
        bg: AppColors.iconMakeupBg,
        fg: AppColors.iconMakeupFg),
    ServiceItem(
        label: 'DJ',
        icon: Icons.music_note,
        bg: AppColors.iconDjBg,
        fg: AppColors.iconDjFg),
    ServiceItem(
        label: 'Mehendi Artist',
        icon: Icons.back_hand,
        bg: AppColors.iconMehendiBg,
        fg: AppColors.iconMehendiFg),
    ServiceItem(
        label: 'Event Planner',
        icon: Icons.mic,
        bg: AppColors.iconEventBg,
        fg: AppColors.iconEventFg),
    ServiceItem(
        label: 'Tutor',
        icon: Icons.menu_book,
        bg: AppColors.iconTutorBg,
        fg: AppColors.iconTutorFg),
    ServiceItem(
        label: 'Pandit',
        icon: Icons.star,
        bg: AppColors.iconPanditBg,
        fg: AppColors.iconPanditFg),
    ServiceItem(
        label: 'Interior Designer',
        icon: Icons.chair_alt,
        bg: AppColors.iconInteriorBg,
        fg: AppColors.iconInteriorFg),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: CommonAppBar(),
      body: Column(
        children: [
          // Scrollable content (Advance Booking section)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _SectionCard(
                    backgroundColor: AppColors.advanceBannerBg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionHeader(
                          icon: Icons.calendar_today,
                          iconColor: AppColors.primaryPurple,
                          title: 'ADVANCE BOOKING',
                          subtitleWidget: const Text(
                            '        Book for future date & events',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          onViewAll: () {},
                        ),
                        const SizedBox(height: 16),
                        _ServiceGrid(items: advanceBooking),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // You can add more sections here if needed
                ],
              ),
            ),
          ),
          // Sticky footer: Smart Search Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.bg, // match scaffold background
            child: const _SmartSearchCard(),
          ),
        ],
      ),
    );
  }
}

/// -----------------------------------------------------------------------
/// Rounded section wrapper (instant / advance booking)
/// -----------------------------------------------------------------------
class _SectionCard extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;

  const _SectionCard({required this.backgroundColor, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

/// -----------------------------------------------------------------------
/// Section header: icon + title + subtitle on the left, "View All" on right
/// -----------------------------------------------------------------------
class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget subtitleWidget;
  final VoidCallback onViewAll;

  const _SectionHeader({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitleWidget,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: iconColor, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              subtitleWidget,
            ],
          ),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: const Text(
            'View All',
            style: TextStyle(
              color: AppColors.primaryPurple,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

/// -----------------------------------------------------------------------
/// 4-column grid of service tiles
/// -----------------------------------------------------------------------
class _ServiceGrid extends StatelessWidget {
  final List<ServiceItem> items;

  const _ServiceGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 14,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return _ServiceTile(item: item);
      },
    );
  }
}

/// -----------------------------------------------------------------------
/// Single service tile (icon box in white card + label)
/// -----------------------------------------------------------------------
class _ServiceTile extends StatelessWidget {
  final ServiceItem item;

  const _ServiceTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: item.bg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(item.icon, color: item.fg, size: 18),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }
}

/// -----------------------------------------------------------------------
/// Bottom "Not sure which service?" + Smart Search card (sticky footer)
/// -----------------------------------------------------------------------
class _SmartSearchCard extends StatelessWidget {
  const _SmartSearchCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.smartSearchBg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.navy,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.smart_toy_outlined,
                color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Not sure which service to choose?',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "Tell us what you need and we'll help you.",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.auto_awesome, size: 16),
            label: const Text(
              'Smart Search',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}