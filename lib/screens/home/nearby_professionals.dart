import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';

class NearbyProfessionalsScreen extends StatefulWidget {
  const NearbyProfessionalsScreen({Key? key}) : super(key: key);

  @override
  State<NearbyProfessionalsScreen> createState() => _NearbyProfessionalsScreenState();
}

class _NearbyProfessionalsScreenState extends State<NearbyProfessionalsScreen> {
  int selectedCategoryIndex = 0;
  int selectedPageIndex = 1;

  final List<String> categories = [
    'All',
    'Electrician',
    'Plumber',
    'AC Repair',
    'Cleaning',
    'Carpenter',
  ];

  final List<Map<String, dynamic>> professionals = [
    {
      'name': 'Amit Electricals',
      'isVerified': true,
      'rating': '4.7',
      'reviews': '(128 Reviews)',
      'jobs': '120+ Jobs',
      'category': 'Electrician',
      'distance': '1.2 km away',
      'responseTime': '15 min response',
      'isAvailable': true,
      'categoryIcon': Icons.electric_bolt_rounded,
      'categoryIconBg': AppColors.iconElectricianBg,
      'categoryIconFg': AppColors.iconElectricianFg,
      'avatarUrl': 'https://i.pravatar.cc/150?img=11',
    },
    {
      'name': 'Suresh Plumbing',
      'isVerified': true,
      'rating': '4.6',
      'reviews': '(96 Reviews)',
      'jobs': '95+ Jobs',
      'category': 'Plumber',
      'distance': '1.5 km away',
      'responseTime': '20 min response',
      'isAvailable': true,
      'categoryIcon': Icons.water_drop_rounded,
      'categoryIconBg': AppColors.iconPlumberBg,
      'categoryIconFg': AppColors.iconPlumberFg,
      'avatarUrl': 'https://i.pravatar.cc/150?img=12',
    },
    {
      'name': 'AC Cool Services',
      'isVerified': true,
      'rating': '4.8',
      'reviews': '(76 Reviews)',
      'jobs': '80+ Jobs',
      'category': 'AC Repair',
      'distance': '1.8 km away',
      'responseTime': '18 min response',
      'isAvailable': true,
      'categoryIcon': Icons.ac_unit_rounded,
      'categoryIconBg': AppColors.iconAcBg,
      'categoryIconFg': AppColors.iconAcFg,
      'avatarUrl': 'https://i.pravatar.cc/150?img=13',
    },
    {
      'name': 'Home Clean Experts',
      'isVerified': true,
      'rating': '4.7',
      'reviews': '(112 Reviews)',
      'jobs': '150+ Jobs',
      'category': 'Home Cleaning',
      'distance': '2.0 km away',
      'responseTime': '25 min response',
      'isAvailable': true,
      'categoryIcon': Icons.cleaning_services_rounded,
      'categoryIconBg': AppColors.iconCleaningBg,
      'categoryIconFg': AppColors.iconCleaningFg,
      'avatarUrl': 'https://i.pravatar.cc/150?img=14',
    },
    {
      'name': 'Sai Carpentry',
      'isVerified': true,
      'rating': '4.5',
      'reviews': '(64 Reviews)',
      'jobs': '60+ Jobs',
      'category': 'Carpenter',
      'distance': '2.3 km away',
      'responseTime': '30 min response',
      'isAvailable': true,
      'categoryIcon': Icons.construction_rounded,
      'categoryIconBg': AppColors.iconCarpenterBg,
      'categoryIconFg': AppColors.iconCarpenterFg,
      'avatarUrl': 'https://i.pravatar.cc/150?img=15',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldLightBg,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldLightBg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.navy),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Column(
          children: [
            const Text(
              'Nearby Professionals',
              style: TextStyle(
                color: AppColors.navy,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.location_on_outlined, size: 14, color: AppColors.navy),
                SizedBox(width: 2),
                Text(
                  'Kothrud, Pune',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.navy),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            
            // Search Bar & Filter Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.fieldFill,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.fieldBorder),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by service or professional name...',
                          hintStyle: TextStyle(
                            color: AppColors.hintText,
                            fontSize: 12.5,
                          ),
                          prefixIcon: Icon(Icons.search, color: AppColors.hintText, size: 20),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.fieldFill,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.fieldBorder),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.tune_rounded, color: AppColors.navy, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'Filters',
                          style: TextStyle(
                            color: AppColors.navy,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Horizontal Filter Chips
            SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.navy : AppColors.chipUnselected,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppColors.textSecondary,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Professional List Cards
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: professionals.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _buildProfessionalCard(professionals[index]);
              },
            ),
            const SizedBox(height: 20),

            // Pagination Text
            const Text(
              'Showing 1 – 10 of 58 professionals',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 12),

            // Pagination Controls
            _buildPaginationControls(),
            const SizedBox(height: 16),

            // Bottom Informational Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.lightPurple.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.lightPurple,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.pin_drop_rounded,
                        color: AppColors.primaryPurple,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Professionals near you',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'These professionals are available in your area and ready to help you.',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // --- Helper Card Widget ---
  Widget _buildProfessionalCard(Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with Online Status Indicator
              Stack(
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundImage: NetworkImage(data['avatarUrl']),
                    backgroundColor: AppColors.chipUnselected,
                  ),
                  if (data['isAvailable'])
                    Positioned(
                      bottom: 0,
                      right: 2,
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),

              // Content Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title & Verified Badge
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            data['name'],
                            style: const TextStyle(
                              color: AppColors.navy,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (data['isVerified']) ...[
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, size: 16, color: AppColors.blueAccent),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Rating & Reviews Row
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: AppColors.star),
                        const SizedBox(width: 3),
                        Text(
                          data['rating'],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          data['reviews'],
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Category Tag
                    Row(
                      children: [
                        Icon(
                          data['categoryIcon'] as IconData,
                          size: 13,
                          color: data['categoryIconFg'] as Color,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          data['category'],
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Distance & Response Time Row
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 13, color: AppColors.textSecondary),
                        const SizedBox(width: 2),
                        Text(
                          data['distance'],
                          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.access_time_rounded, size: 13, color: AppColors.textSecondary),
                        const SizedBox(width: 2),
                        Text(
                          data['responseTime'],
                          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Available Tag & View Profile Button Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.badgeAssignedBg,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Available now',
                            style: TextStyle(
                              color: AppColors.badgeAssignedText,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.navy,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                            minimumSize: const Size(0, 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text(
                            'View Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Top Right Badge (Rating & Jobs Done)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.badgeAssignedBg.withOpacity(0.5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data['rating'],
                        style: const TextStyle(
                          color: AppColors.badgeAssignedText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(Icons.star, color: AppColors.badgeAssignedText, size: 10),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data['jobs'],
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 9,
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

  // --- Pagination Controls ---
  Widget _buildPaginationControls() {
    final List<dynamic> pages = [1, 2, 3, 4, 5, '...', 6];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPageNavButton(Icons.chevron_left_rounded, enabled: false),
        const SizedBox(width: 4),
        ...pages.map((page) {
          if (page == '...') {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text('...', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            );
          }
          final isSelected = selectedPageIndex == page;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedPageIndex = page as int;
              });
            },
            child: Container(
              width: 28,
              height: 28,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.navyDark : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected ? AppColors.navyDark : AppColors.cardBorder,
                ),
              ),
              child: Center(
                child: Text(
                  page.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textDark,
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
        const SizedBox(width: 4),
        _buildPageNavButton(Icons.chevron_right_rounded, enabled: true),
      ],
    );
  }

  Widget _buildPageNavButton(IconData icon, {required bool enabled}) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Icon(
        icon,
        size: 18,
        color: enabled ? AppColors.textDark : AppColors.hintText,
      ),
    );
  }
}