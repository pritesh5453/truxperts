import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:truxperts/screens/Profile/profile_screen.dart';
import 'package:truxperts/screens/cust_profile/manage_address_screen.dart';
import 'package:truxperts/screens/home/address_location.dart';
import 'package:truxperts/screens/home/categories.dart';
import 'package:truxperts/screens/home/categories_2.dart';
import 'package:truxperts/screens/home/explore_rewards_scren.dart';
import 'package:truxperts/screens/home/nearby_prof.dart';
import 'package:truxperts/screens/home/nearby_professionals.dart';
import 'package:truxperts/screens/notification/notification_screen.dart';
import 'package:truxperts/screens/post/post_requestScreen.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 5),
              _TopBar(),
              SizedBox(height: 12),
              _SearchBar(),
              SizedBox(height: 16),
              _HeroBanner(),
              SizedBox(height: 20),
              _SectionHeader(title: 'Top Instant Services', showViewAll: false),
              SizedBox(height: 12),
              _TopInstantServices(),
              SizedBox(height: 20),
              _SectionHeader(
                title: 'Popular for Advance Booking',
                showViewAll: false,
              ),
              SizedBox(height: 12),
              _AdvanceBookingServices(),
              SizedBox(height: 20),
              _RewardsBanner(),
              SizedBox(height: 20),
              // ------------------ Nearby Experts (View All -> NearbyExpertsScreen1) ------------------
              _SectionHeader(
                title: 'Nearby Experts',
                showViewAll: true,
                onViewAll: _navigateToNearbyExperts1, // static function
              ),
              SizedBox(height: 12),
              _NearbyProfessionalsRow(),
              SizedBox(height: 20),
              // ------------------ Latest Posts (View All -> NearbyExpertsScreen) ------------------
              _SectionHeader(
                title: 'Latest Posts from Professionals',
                showViewAll: true,
                onViewAll: _navigateToNearbyExperts2, // static function
              ),
              SizedBox(height: 12),
              _LatestPostsGrid(),
              SizedBox(height: 20),
              _StatsRow(),
            ],
          ),
        ),
      ),
    );
  }

  // Navigation helpers (static so they can be used in const constructors)
  static void _navigateToNearbyExperts1(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NearbyExpertsScreen1()),
    );
  }

  static void _navigateToNearbyExperts2(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NearbyExpertsScreen()),
    );
  }
}

// ---------------------- TOP BAR ----------------------
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          // Sirf location wale part pe tap -> bottom sheet khulega
          SizedBox(
            width: 300,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                LocationSelectorSheet.show(context);
              },
              child: Row(
                children: [
                  const Icon(Icons.location_on, size: 20, color: Colors.black),
                  Expanded(
                    child: Text(
                      'Shivajinagar, Satpur, Nashik, Maharashtra',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          const Spacer(),
          _IconBadge(
            icon: Icons.notifications_none_rounded,
            badgeCount: 1,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final IconData icon;
  final int badgeCount;
  final VoidCallback? onTap;
  const _IconBadge({required this.icon, required this.badgeCount, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            child: Icon(LucideIcons.bell, size: 20, color: AppColors.navy),
          ),
          if (badgeCount > 0)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: AppColors.orange,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                child: Text(
                  '$badgeCount',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------- SEARCH BAR (with Speech-to-Text) ----------------------
class _SearchBar extends StatefulWidget {
  const _SearchBar();

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final TextEditingController _controller = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        debugPrint("STATUS: $status");
      },
      onError: (error) {
        debugPrint("ERROR: ${error.errorMsg}");
        debugPrint("PERMANENT: ${error.permanent}");
      },
      debugLogging: true,
    );
    debugPrint("AVAILABLE: $available");
  }

  void _startListening() async {
    if (!_speech.isAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition not available')),
      );
      return;
    }
    setState(() => _isListening = true);
    _speech.listen(
      onResult: (result) {
        setState(() {
          _controller.text = result.recognizedWords;
        });
      },
      listenMode: stt.ListenMode.dictation,
    );
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.textGrey, size: 18),
            const SizedBox(width: 6),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Search for services or professionals...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 12),
                ),
                style: const TextStyle(fontSize: 12),
                onChanged: (value) {
                  // You can trigger search here if needed
                },
              ),
            ),
            GestureDetector(
              onTap: _isListening ? _stopListening : _startListening,
              child: _isListening
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.orange,
                      ),
                    )
                  : const Icon(Icons.mic, color: AppColors.navy, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- HERO BANNER ----------------------
class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Banner image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 1536 / 1024,
              child: Image.asset(
                'assets/images/hero_banner.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlapping cards
          Positioned(
            left: 12,
            right: 12,
            bottom: 10,
            child: Row(
              children: [
                Expanded(
                  child: _buildOptionCard(
                    icon: Icons.bolt,
                    title: 'Need Service Now?',
                    subtitle: 'Get an expert\nin minutes',
                    buttonText: 'Get Started',
                    isOrange: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PostRequestScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildOptionCard(
                    icon: Icons.calendar_today,
                    title: 'Plan for Later?',
                    subtitle: 'Book for events\nor future date',
                    buttonText: 'Plan Now',
                    isOrange: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PostRequestScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required bool isOrange,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.orange, size: 12),
                const SizedBox(width: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.black, fontSize: 9),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: isOrange ? AppColors.orange : AppColors.navy,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    buttonText,
                    style: TextStyle(
                      color: isOrange ? AppColors.bg : Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    size: 10,
                    color: isOrange ? Colors.white : AppColors.navy,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- SECTION HEADER (UPDATED WITH DYNAMIC onViewAll) ----------------------
class _SectionHeader extends StatelessWidget {
  final String title;
  final bool showViewAll;
  final void Function(BuildContext context)? onViewAll; // new callback

  const _SectionHeader({
    required this.title,
    this.showViewAll = true,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          if (showViewAll)
            TextButton(
              onPressed: () {
                if (onViewAll != null) {
                  onViewAll!(context);
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Row(
                children: [
                  Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navy,
                    ),
                  ),
                  SizedBox(width: 2),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColors.navy,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------- SERVICE ITEM (data model) ----------------------
class _ServiceItem {
  final IconData icon;
  final String label;
  final Color bg;
  final Color iconColor;
  const _ServiceItem(this.icon, this.label, this.bg, this.iconColor);
}

// ---------------------- TOP INSTANT SERVICES ----------------------
class _TopInstantServices extends StatelessWidget {
  const _TopInstantServices();

  @override
  Widget build(BuildContext context) {
    const items = [
      _ServiceItem(
        Icons.bolt,
        'Electrician',
        Color(0xFFE9ECFB),
        Color(0xFF4A5AD9),
      ),
      _ServiceItem(
        Icons.plumbing,
        'Plumber',
        Color(0xFFDBF0FF),
        Color(0xFF2196D9),
      ),
      _ServiceItem(
        Icons.ac_unit,
        'AC Repair',
        Color(0xFFE3F5FF),
        Color(0xFF1EA7E0),
      ),
      _ServiceItem(
        Icons.cleaning_services,
        'Cleaning',
        Color(0xFFE0F7EF),
        Color(0xFF2FAE60),
      ),
      _ServiceItem(
        Icons.shopping_basket,
        'Grocery',
        Color(0xFFE0F7E9),
        Color(0xFF2FAE60),
      ),
      _ServiceItem(
        Icons.more_horiz,
        'More',
        Color(0xFFEFEFF4),
        Color(0xFF8A8CA3),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) {
          return GestureDetector(
            onTap: () {
              if (item.label == 'More') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChooseServiceScreen(),
                  ),
                );
              }
            },
            child: SizedBox(
              width: 50,
              child: Column(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: item.bg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item.icon, color: item.iconColor, size: 20),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 8,
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ---------------------- ADVANCE BOOKING ----------------------
class _AdvanceBookingServices extends StatelessWidget {
  const _AdvanceBookingServices();

  @override
  Widget build(BuildContext context) {
    const items = [
      _ServiceItem(
        Icons.camera_alt,
        'Photographer',
        Color(0xFFF3E8FF),
        Color(0xFF9B51E0),
      ),
      _ServiceItem(
        Icons.diamond_outlined,
        'Wedding\nPlanner',
        Color(0xFFFFF1E0),
        Color(0xFFFF9800),
      ),
      _ServiceItem(
        Icons.restaurant,
        'Catering',
        Color(0xFFFFE7E7),
        Color(0xFFE53935),
      ),
      _ServiceItem(
        Icons.chair_alt,
        'Decorator',
        Color(0xFFE7F0FF),
        Color(0xFF3F6BE0),
      ),
      _ServiceItem(
        Icons.music_note,
        'DJ',
        Color(0xFFF3E8FF),
        Color(0xFF9B51E0),
      ),
      _ServiceItem(
        Icons.more_horiz,
        'More',
        Color(0xFFEFEFF4),
        Color(0xFF8A8CA3),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) {
          return GestureDetector(
            onTap: () {
              if (item.label == 'More') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChooseServiceScreen2(),
                  ),
                );
              }
            },
            child: SizedBox(
              width: 50,
              child: Column(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: item.bg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item.icon, color: item.iconColor, size: 20),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 8,
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ---------------------- REWARDS BANNER ----------------------
class _RewardsBanner extends StatelessWidget {
  const _RewardsBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3B2B8C), Color(0xFF1B2B6B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Section: Texts and Button
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'Tru',
                          style: TextStyle(color: AppColors.advanceBannerBg),
                        ),
                        TextSpan(
                          text: 'Xperts',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffE65F2B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Rewards',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Book now, earn more!',
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TruXpertsRewardsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Explore Rewards',
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Center Section: Image
            Expanded(
              flex: 2,
              child: Center(
                child: Image.asset(
                  'assets/images/rewards.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Right Section: Points
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Your Points',
                    style: TextStyle(color: AppColors.bg, fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: Color(0xFFFFC94A),
                        size: 14,
                      ),
                      SizedBox(width: 3),
                      Text(
                        '250',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- NEARBY PROFESSIONALS – ROW ----------------------
class _NearbyProfessionalsRow extends StatelessWidget {
  const _NearbyProfessionalsRow();

  @override
  Widget build(BuildContext context) {
    final profs = [
      {
        'name': 'Amit Bactwala',
        'rating': '+4.8 (120)',
        'color': const Color(0xFFB9C4FF),
      },
      {
        'name': 'Suresh Pushkar',
        'rating': '+4.7 (90)',
        'color': const Color(0xFFFFC9A6),
      },
      {
        'name': 'AC Repair Pro',
        'rating': '+4.6 (76)',
        'color': const Color(0xFFA6D8FF),
      },
      {
        'name': 'Home Cleaning',
        'rating': '+4.8 (112)',
        'color': const Color(0xFFFFB9D6),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: profs.map((p) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProviderProfileScreen(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: p['color'] as Color,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      p['name'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      p['rating'] as String,
                      style: const TextStyle(
                        fontSize: 8,
                        color: AppColors.textGrey,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9ECFB),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Available now',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 7,
                          color: AppColors.navy,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ---------------------- STATS ROW ----------------------
class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        'icon': Icons.emoji_emotions,
        'value': '50,000+',
        'label': 'Happy Customers',
      },
      {
        'icon': Icons.verified_user,
        'value': '5,000+',
        'label': 'Verified Professionals',
      },
      {'icon': Icons.category, 'value': '120+', 'label': 'Service Categories'},
      {'icon': Icons.task_alt, 'value': '1L+', 'label': 'Service Completed'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: stats.map((s) {
            return Column(
              children: [
                Icon(s['icon'] as IconData, color: AppColors.navy, size: 16),
                const SizedBox(height: 4),
                Text(
                  s['value'] as String,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                SizedBox(
                  width: 60,
                  child: Text(
                    s['label'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 7,
                      color: AppColors.textGrey,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ---------------------- LATEST POSTS (Nearby-Experts style image cards) ----------------------
class _Post {
  final String author;
  final String category;
  final String time;
  final String caption;
  final int likes;
  final int comments;
  final Color color;
  final String avatarUrl;
  final String imageUrl;

  const _Post({
    required this.author,
    required this.category,
    required this.time,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.color,
    required this.avatarUrl,
    required this.imageUrl,
  });
}

// Sirf 4 posts home screen pe dikhte hain. Poori list dekhne ke liye
// "View All" hai (upar wale _SectionHeader se already connected).
class _LatestPostsGrid extends StatefulWidget {
  const _LatestPostsGrid();

  @override
  State<_LatestPostsGrid> createState() => _LatestPostsGridState();
}

class _LatestPostsGridState extends State<_LatestPostsGrid> {
  final Set<int> _liked = {};

  static const List<_Post> _posts = [
    _Post(
      author: 'Amit Photography',
      category: 'Photographer',
      time: '2h ago',
      caption: 'Pre-wedding shoot available for this season. Book your date!',
      likes: 26,
      comments: 8,
      color: Color(0xFFE8D9C4),
      avatarUrl: 'https://i.pravatar.cc/80?img=12',
      imageUrl: 'https://picsum.photos/seed/post1photo/400/500',
    ),
    _Post(
      author: 'Drawn Wedding Planners',
      category: 'Wedding Planner',
      time: '3h ago',
      caption: 'Make your big day memorable with our expert planning.',
      likes: 32,
      comments: 5,
      color: Color(0xFFF3C9D6),
      avatarUrl: 'https://i.pravatar.cc/80?img=32',
      imageUrl: 'https://picsum.photos/seed/post2photo/400/500',
    ),
    _Post(
      author: 'Bing Ceremony Experts',
      category: 'Caterer',
      time: '4h ago',
      caption: 'Bing and ceremony services for your special moments.',
      likes: 41,
      comments: 12,
      color: Color(0xFFD9C9F3),
      avatarUrl: 'https://i.pravatar.cc/80?img=5',
      imageUrl: 'https://picsum.photos/seed/post3photo/400/500',
    ),
    _Post(
      author: 'Shah Etesh Events',
      category: 'Decorator',
      time: '5h ago',
      caption: 'Book a caterer, decorator, and photographers.',
      likes: 27,
      comments: 6,
      color: Color(0xFFD6C9B0),
      avatarUrl: 'https://i.pravatar.cc/80?img=45',
      imageUrl: 'https://picsum.photos/seed/post4photo/400/500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _posts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.90,
        ),
        itemBuilder: (context, index) {
          final post = _posts[index];
          return _PostCard(
            post: post,
            liked: _liked.contains(index),
            onLikeTap: () {
              setState(() {
                if (_liked.contains(index)) {
                  _liked.remove(index);
                } else {
                  _liked.add(index);
                }
              });
            },
          );
        },
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final _Post post;
  final bool liked;
  final VoidCallback onLikeTap;

  const _PostCard({
    required this.post,
    required this.liked,
    required this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            post.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(color: post.color.withOpacity(0.3));
            },
            errorBuilder: (context, error, stackTrace) => Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    post.color.withOpacity(0.6),
                    post.color.withOpacity(0.95),
                  ],
                ),
              ),
              child: const Center(
                child: Icon(Icons.image, color: Colors.white70, size: 22),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onLikeTap,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  liked ? Icons.favorite : Icons.favorite_border,
                  size: 14,
                  color: liked ? const Color(0xFFEB5757) : AppColors.textGrey,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.75),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 11,
                            backgroundColor: post.color,
                            backgroundImage: NetworkImage(post.avatarUrl),
                            onBackgroundImageError: (_, __) {},
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
                              child: const Icon(
                                Icons.verified,
                                size: 11,
                                color: Color(0xFF2F80ED),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          post.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          post.category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Icon(
                        liked ? Icons.favorite : Icons.favorite_border,
                        size: 12,
                        color: liked
                            ? const Color(0xFFEB5757)
                            : const Color(0xFFF2A93B),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${post.likes + (liked ? 1 : 0)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.5,
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
