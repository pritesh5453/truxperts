import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // ✅ Added Shimmer package import
import 'package:truxperts/Model_n_svc/categories/categories_model.dart';
import 'package:truxperts/Model_n_svc/categories/categories_svc.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';

// -----------------------------------------------------------------------
// Simple model for a service item shown in the grid
// -----------------------------------------------------------------------
class ServiceItem {
  final String label;
  final String iconUrl;
  final Color bg;
  final Color fg;

  const ServiceItem({
    required this.label,
    required this.iconUrl,
    required this.bg,
    required this.fg,
  });
}

// -----------------------------------------------------------------------
// ChooseServiceScreen WITH SHIMMER SKELETON
// -----------------------------------------------------------------------
class ChooseServiceScreen extends StatefulWidget {
  const ChooseServiceScreen({super.key});

  @override
  State<ChooseServiceScreen> createState() => _ChooseServiceScreenState();
}

class _ChooseServiceScreenState extends State<ChooseServiceScreen> {
  late Future<List<ServiceItem>> _serviceItemsFuture;

  // Static fallback list (agar API fail ho to dikhana hai)
  static const List<ServiceItem> _fallbackServices = [
    ServiceItem(
      label: 'Electrician',
      iconUrl: '',
      bg: AppColors.iconElectricianBg,
      fg: AppColors.iconElectricianFg,
    ),
    ServiceItem(
      label: 'Plumber',
      iconUrl: '',
      bg: AppColors.iconPlumberBg,
      fg: AppColors.iconPlumberFg,
    ),
    ServiceItem(
      label: 'AC Repair',
      iconUrl: '',
      bg: AppColors.iconAcBg,
      fg: AppColors.iconAcFg,
    ),
    ServiceItem(
      label: 'Carpenter',
      iconUrl: '',
      bg: AppColors.iconCarpenterBg,
      fg: AppColors.iconCarpenterFg,
    ),
    ServiceItem(
      label: 'RO Service',
      iconUrl: '',
      bg: AppColors.iconRoBg,
      fg: AppColors.iconRoFg,
    ),
    ServiceItem(
      label: 'Cleaning',
      iconUrl: '',
      bg: AppColors.iconCleaningBg,
      fg: AppColors.iconCleaningFg,
    ),
    ServiceItem(
      label: 'Grocery',
      iconUrl: '',
      bg: AppColors.iconGroceryBg,
      fg: AppColors.iconGroceryFg,
    ),
    ServiceItem(
      label: 'Medicine',
      iconUrl: '',
      bg: AppColors.iconMedicineBg,
      fg: AppColors.iconMedicineFg,
    ),
    ServiceItem(
      label: 'Pest Control',
      iconUrl: '',
      bg: AppColors.iconPestBg,
      fg: AppColors.iconPestFg,
    ),
    ServiceItem(
      label: 'Auto / Cab',
      iconUrl: '',
      bg: AppColors.iconAutoBg,
      fg: AppColors.iconAutoFg,
    ),
    ServiceItem(
      label: 'Courier',
      iconUrl: '',
      bg: AppColors.iconCourierBg,
      fg: AppColors.iconCourierFg,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _serviceItemsFuture = _fetchCategories();
  }

  // API se data laake ServiceItem list banayein
  Future<List<ServiceItem>> _fetchCategories() async {
    try {
      final dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
      final service = CategoriesApiService(dio);
      final response = await service.getCategories();

      if (response.success && response.data.isNotEmpty) {
        return response.data.map((category) {
          Color parseColor(String hex) {
            String clean = hex.trim();
            clean = clean.replaceAll('\\', '');
            if (clean.startsWith('#')) clean = clean.substring(1);
            if (clean.length == 6) clean = 'ff$clean';
            return Color(int.parse('0x$clean'));
          }

          return ServiceItem(
            label: category.name,
            iconUrl: category.cleanIcon,
            bg: parseColor(category.bgColor),
            fg: parseColor(category.iconColor),
          );
        }).toList();
      } else {
        return _fallbackServices;
      }
    } catch (e) {
      print('Error fetching categories: $e');
      return _fallbackServices;
    }
  }

  // ================== SKELETON WITH SHIMMER ==================
  Widget _buildSkeletonTile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 50,
          height: 10,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }

  Widget _buildSkeletonGrid() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 14,
          childAspectRatio: 0.78,
        ),
        itemBuilder: (context, index) => _buildSkeletonTile(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: CommonAppBar(),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ServiceItem>>(
              future: _serviceItemsFuture,
              builder: (context, snapshot) {
                // Loading → Show skeleton grid with shimmer
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    child: Column(
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
                              _buildSkeletonGrid(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Error / no data – fallback dikhao
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _buildServiceGrid(_fallbackServices);
                }

                // ✅ Data mil gaya
                return _buildServiceGrid(snapshot.data!);
              },
            ),
          ),
          // Sticky footer: Smart Search Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.bg,
            child: const _SmartSearchCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceGrid(List<ServiceItem> items) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
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
                _ServiceGrid(items: items),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------
// All the existing widgets
// -----------------------------------------------------------------------

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
                child: _buildIcon(),
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

  Widget _buildIcon() {
    if (item.iconUrl.isNotEmpty) {
      return Image.network(
        item.iconUrl,
        width: 20,
        height: 20,
        color: item.fg,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: item.fg,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.category, color: item.fg, size: 16);
        },
      );
    } else {
      return Icon(Icons.category, color: item.fg, size: 16);
    }
  }
}

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