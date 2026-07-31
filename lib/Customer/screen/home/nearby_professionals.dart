import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';

class _Expert {
  final String name;
  final String category;
  final double rating;
  final String imageUrl;
  final String avatarUrl;
  final Color avatarBg;

  const _Expert({
    required this.name,
    required this.category,
    required this.rating,
    required this.imageUrl,
    required this.avatarUrl,
    required this.avatarBg,
  });
}

class NearbyExpertsScreen extends StatefulWidget {
  const NearbyExpertsScreen({super.key});

  @override
  State<NearbyExpertsScreen> createState() => _NearbyExpertsScreenState();
}

class _NearbyExpertsScreenState extends State<NearbyExpertsScreen> {
  static const Color _link = Color(0xFF2F80ED);
  static const Color _star = Color(0xFFF2A93B);

  final List<String> _filters = const [
    'All',
    'Photographer',
    'Caterer',
    'Decorator',
    'DJ',
    'Makeup Artist',
  ];

  String _selectedFilter = 'All';
  final Set<int> _favorites = {};

  final List<_Expert> _experts = const [
    _Expert(
      name: 'Amit Photography',
      category: 'Photographer',
      rating: 4.8,
      imageUrl: 'https://picsum.photos/seed/wedcouple1/400/500',
      avatarUrl: 'https://i.pravatar.cc/80?img=12',
      avatarBg: Color(0xFF2F80ED),
    ),
    _Expert(
      name: 'Dream Wedding Planners',
      category: 'Wedding Planner',
      rating: 4.7,
      imageUrl: 'https://picsum.photos/seed/mandap2/400/500',
      avatarUrl: 'https://i.pravatar.cc/80?img=32',
      avatarBg: Color(0xFFEB5757),
    ),
    _Expert(
      name: 'Bling Ceremony Experts',
      category: 'Caterer',
      rating: 4.6,
      imageUrl: 'https://picsum.photos/seed/banquet3/400/500',
      avatarUrl: 'https://i.pravatar.cc/80?img=5',
      avatarBg: Color(0xFF27AE60),
    ),
    _Expert(
      name: 'Shah Elah Events',
      category: 'Decorator',
      rating: 4.8,
      imageUrl: 'https://picsum.photos/seed/decor4/400/500',
      avatarUrl: 'https://i.pravatar.cc/80?img=45',
      avatarBg: Color(0xFFF08C9B),
    ),
    _Expert(
      name: 'DJ Rhythmix',
      category: 'DJ',
      rating: 4.5,
      imageUrl: 'https://picsum.photos/seed/djparty5/400/500',
      avatarUrl: 'https://i.pravatar.cc/80?img=15',
      avatarBg: Color(0xFF9B51E0),
    ),
    _Expert(
      name: 'Makeover by Priya',
      category: 'Makeup Artist',
      rating: 4.7,
      imageUrl: 'https://picsum.photos/seed/bridalmakeup6/400/500',
      avatarUrl: 'https://i.pravatar.cc/80?img=47',
      avatarBg: Color(0xFF27AE60),
    ),
  ];

  List<_Expert> get _filteredExperts {
    if (_selectedFilter == 'All') return _experts;
    return _experts.where((e) => e.category == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            CommonAppBar(),

SizedBox(height: 10,),
            // Category Filter
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final label = _filters[index];
                  final selected = label == _selectedFilter;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = label),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.navy : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selected ? AppColors.navy : const Color(0xFFE3E3E3),
                        ),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: selected ? Colors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Location Info Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  const Text(
                    'Pune, Maharashtra',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Change',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _link,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_filteredExperts.length} Experts found',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: _link,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Grid View
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: _filteredExperts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.70, // Optimized for vertical mobile screens
                ),
                itemBuilder: (context, index) {
                  final expert = _filteredExperts[index];
                  final originalIndex = _experts.indexOf(expert);
                  return _ExpertCard(
                    expert: expert,
                    favorite: _favorites.contains(originalIndex),
                    onFavoriteTap: () {
                      setState(() {
                        if (_favorites.contains(originalIndex)) {
                          _favorites.remove(originalIndex);
                        } else {
                          _favorites.add(originalIndex);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Banner Section
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFF1ECFB),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.campaign_outlined,
                    color: Color(0xFF7C5CE0), size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Can't find right expert?",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Post requirement for best quotes',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.navy,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Post Requirement',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpertCard extends StatelessWidget {
  final _Expert expert;
  final bool favorite;
  final VoidCallback onFavoriteTap;

  const _ExpertCard({
    required this.expert,
    required this.favorite,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            expert.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(color: const Color(0xFFE3E3E3));
            },
            errorBuilder: (context, error, stackTrace) => Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    expert.avatarBg.withOpacity(0.6),
                    expert.avatarBg.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onFavoriteTap,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  favorite ? Icons.favorite : Icons.favorite_border,
                  size: 15,
                  color: favorite ? const Color(0xFFEB5757) : AppColors.textSecondary,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.80),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: expert.avatarBg,
                            backgroundImage: NetworkImage(expert.avatarUrl),
                          ),
                          Positioned(
                            right: -2,
                            bottom: -2,
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.verified,
                                  size: 10, color: Color(0xFF2F80ED)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          expert.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          expert.category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 9.5,
                          ),
                        ),
                      ),
                      const Icon(Icons.star, size: 11, color: Color(0xFFF2A93B)),
                      const SizedBox(width: 2),
                      Text(
                        expert.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}