import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:truxperts/Model_n_svc/categories/advance_category_svc.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';
import 'package:shimmer/shimmer.dart';

// -----------------------------------------------------------------------
// Simple model for a service item shown in the grid
// -----------------------------------------------------------------------
class ServiceItem {
  final String label;
  final String? iconUrl;
  final Color bg;
  final Color fg;

  const ServiceItem({
    required this.label,
    this.iconUrl,
    required this.bg,
    required this.fg,
  });
}

// -----------------------------------------------------------------------
// ChooseServiceScreen2 (Advance Booking) - WITH SHIMMER + IMAGE SUPPORT
// -----------------------------------------------------------------------
class ChooseServiceScreen2 extends StatefulWidget {
  const ChooseServiceScreen2({super.key});

  @override
  State<ChooseServiceScreen2> createState() => _ChooseServiceScreen2State();
}

class _ChooseServiceScreen2State extends State<ChooseServiceScreen2> {
  late Future<List<ServiceItem>> _advanceItemsFuture;

  @override
  void initState() {
    super.initState();
    _advanceItemsFuture = _fetchAdvanceCategories();
  }

  // API se data laao aur ServiceItem list banao
  Future<List<ServiceItem>> _fetchAdvanceCategories() async {
    try {
      print('🔷 FETCHING ADVANCE CATEGORIES...');
      
      final dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
      final service = AdvanceCategoriesApiService(dio);
      final response = await service.getAdvanceCategories();

      print('📦 Advance Response Success: ${response.success}');
      print('📦 Advance Data Count: ${response.data.length}');
      print('📦 Advance Total: ${response.total}');

      if (response.success && response.data.isNotEmpty) {
        print('✅ Mapping ${response.data.length} advance categories...');
        
        final items = response.data.map((category) {
          // ✅ Color parser (handles null)
          Color parseColor(String? hex) {
            if (hex == null || hex.isEmpty) return Colors.grey;
            String clean = hex.trim().replaceAll('\\', '');
            if (clean.startsWith('#')) clean = clean.substring(1);
            if (clean.length == 6) clean = 'ff$clean';
            return Color(int.parse('0x$clean'));
          }

          // ✅ icon URL – use cleanIcon if available, else null
          final iconUrl = category.cleanIcon?.isNotEmpty == true
              ? category.cleanIcon
              : null;

          final bgColor = category.bgColor ?? '#E0E0E0';
          final fgColor = category.iconColor ?? '#000000';

          print('   📍 Category: ${category.name}, Icon: ${iconUrl ?? 'null'}');

          return ServiceItem(
            label: category.name,
            iconUrl: iconUrl,
            bg: parseColor(bgColor),
            fg: parseColor(fgColor),
          );
        }).toList();
        
        print('✅ Successfully mapped ${items.length} advance categories');
        return items;
      } else {
        print('⚠️ Advance categories response empty or unsuccessful');
        return [];
      }
    } catch (e, stack) {
      print('❌ Error fetching advance categories:');
      print('   Error: $e');
      print('   Stack: $stack');
      return [];
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

  // ================== BUILD ==================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: CommonAppBar(),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ServiceItem>>(
              future: _advanceItemsFuture,
              builder: (context, snapshot) {
                // Loading → skeleton grid with shimmer
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SingleChildScrollView(
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
                              _buildSkeletonGrid(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Error / no data → empty state
                if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                  print('❌ Empty state triggered:');
                  print('   hasError: ${snapshot.hasError}');
                  print('   hasData: ${snapshot.hasData}');
                  print('   data length: ${snapshot.data?.length ?? 0}');
                  return _buildEmptyState();
                }

                // ✅ Data mil gaya
                print('✅ Rendering ${snapshot.data!.length} advance categories');
                return _buildAdvanceGrid(snapshot.data!);
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

  // ✅ Empty state with retry button
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: AppColors.textSecondary),
          const SizedBox(height: 12),
          Text(
            'No services available',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Please try again later',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _advanceItemsFuture = _fetchAdvanceCategories();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  // Grid builder
  Widget _buildAdvanceGrid(List<ServiceItem> items) {
    return SingleChildScrollView(
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
// All sub-widgets (unchanged)
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

// ✅ UPDATED _ServiceTile – full image with cover
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
                width: double.infinity,
                height: double.infinity,
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
    if (item.iconUrl == null || item.iconUrl!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Image.network(
      item.iconUrl!,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
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
        print('❌ Image load error for ${item.label}: $error');
        return const SizedBox.shrink();
      },
    );
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