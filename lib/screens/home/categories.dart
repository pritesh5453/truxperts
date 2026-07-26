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
/// ChooseServiceScreen
/// -----------------------------------------------------------------------
class ChooseServiceScreen extends StatelessWidget {
  const ChooseServiceScreen({super.key});

  static const List<ServiceItem> instantServices = [
    ServiceItem(
        label: 'Electrician',
        icon: Icons.electric_bolt,
        bg: AppColors.iconElectricianBg,
        fg: AppColors.iconElectricianFg),
    ServiceItem(
        label: 'Plumber',
        icon: Icons.plumbing,
        bg: AppColors.iconPlumberBg,
        fg: AppColors.iconPlumberFg),
    ServiceItem(
        label: 'AC Repair',
        icon: Icons.ac_unit,
        bg: AppColors.iconAcBg,
        fg: AppColors.iconAcFg),
    ServiceItem(
        label: 'Carpenter',
        icon: Icons.carpenter,
        bg: AppColors.iconCarpenterBg,
        fg: AppColors.iconCarpenterFg),
    ServiceItem(
        label: 'RO Service',
        icon: Icons.water_drop,
        bg: AppColors.iconRoBg,
        fg: AppColors.iconRoFg),
    ServiceItem(
        label: 'Cleaning',
        icon: Icons.cleaning_services,
        bg: AppColors.iconCleaningBg,
        fg: AppColors.iconCleaningFg),
    ServiceItem(
        label: 'Grocery',
        icon: Icons.shopping_basket,
        bg: AppColors.iconGroceryBg,
        fg: AppColors.iconGroceryFg),
    ServiceItem(
        label: 'Medicine',
        icon: Icons.medical_services,
        bg: AppColors.iconMedicineBg,
        fg: AppColors.iconMedicineFg),
    ServiceItem(
        label: 'Pest Control',
        icon: Icons.pest_control,
        bg: AppColors.iconPestBg,
        fg: AppColors.iconPestFg),
    ServiceItem(
        label: 'Auto / Cab',
        icon: Icons.directions_car,
        bg: AppColors.iconAutoBg,
        fg: AppColors.iconAutoFg),
    ServiceItem(
        label: 'Courier',
        icon: Icons.local_shipping,
        bg: AppColors.iconCourierBg,
        fg: AppColors.iconCourierFg),
    ServiceItem(
        label: 'More',
        icon: Icons.grid_view_rounded,
        bg: AppColors.iconMoreBg,
        fg: AppColors.iconMoreFg),
  ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: CommonAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
 
          const SizedBox(height: 16),
          _SectionCard(
            backgroundColor: AppColors.instantBannerBg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionHeader(
                  icon: Icons.bolt,
                  iconColor: AppColors.orange,
                  title: 'INSTANT SERVICES',
                  subtitleWidget: const Text(
                    '        Available in minutes',
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onViewAll: () {},
                ),
                const SizedBox(height: 16),
                _ServiceGrid(items: instantServices),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          const SizedBox(height: 16),
          _SmartSearchCard(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

/// -----------------------------------------------------------------------
/// Search bar
/// -----------------------------------------------------------------------

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
/// Bottom "Not sure which service?" + Smart Search card
/// -----------------------------------------------------------------------
class _SmartSearchCard extends StatelessWidget {
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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