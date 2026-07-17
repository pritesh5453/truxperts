import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';

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
              _TopBar(),
              SizedBox(height: 12),
              _SearchBar(),
              SizedBox(height: 16),
              _HeroBanner(),
              SizedBox(height: 20),
              _SectionHeader(title: 'Top Instant Services'),
              SizedBox(height: 12),
              _TopInstantServices(),
              SizedBox(height: 20),
              _SectionHeader(title: 'Popular for Advance Booking'),
              SizedBox(height: 12),
              _AdvanceBookingServices(),
              SizedBox(height: 20),
              _RewardsBanner(),
              SizedBox(height: 20),
              _SectionHeader(title: 'Live Offers 🔥'),
              SizedBox(height: 12),
              _LiveOffersRow(),
              SizedBox(height: 20),
              _SectionHeader(title: 'Nearby Professionals'),
              SizedBox(height: 12),
              _NearbyProfessionalsRow(),
              SizedBox(height: 20),
              _StatsRow(),
              SizedBox(height: 20),
              _SectionHeader(title: 'Latest Posts from Professionals'),
              SizedBox(height: 12),
              _LatestPostsRow(),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------- TOP BAR (फिक्स्ड) ----------------------
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.location_on, color: AppColors.navy, size: 16),
                SizedBox(width: 2),
                Flexible(
                  child: Text(
                    'Pune, Maharashtra',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textDark),
              ],
            ),
          ),
          const Spacer(),
          Column(
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: 'Tru',
                    style: TextStyle(color: Color(0xff1C2D5A)),
                  ),
                  TextSpan(
                    text: 'Xperts',
                    style: TextStyle(color: Color(0xffE65F2B)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              "— Trusted Professionals, One Tap Away. —",
              style: TextStyle(
                fontSize: 8,
                color: Color(0xff6C757D),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
          const Spacer(),
          _IconBadge(icon: Icons.notifications_none_rounded, badgeCount: 1),
          const SizedBox(width: 8),
          _IconBadge(icon: Icons.chat_bubble_outline_rounded, badgeCount: 1),
        ],
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final IconData icon;
  final int badgeCount;
  const _IconBadge({required this.icon, required this.badgeCount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6, offset: const Offset(0, 2))],
          ),
          child: Icon(icon, size: 16, color: AppColors.navy),
        ),
        if (badgeCount > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(color: AppColors.orange, shape: BoxShape.circle),
              constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
              child: Text('$badgeCount', textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold)),
            ),
          ),
      ],
    );
  }
}

// ---------------------- SEARCH BAR ----------------------
class _SearchBar extends StatelessWidget {
  const _SearchBar();

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
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: const [
            Icon(Icons.search, color: AppColors.textGrey, size: 18),
            SizedBox(width: 6),
            Expanded(child: Text('Search for services or professionals...',
                style: TextStyle(color: AppColors.textGrey, fontSize: 12))),
            Icon(Icons.tune, color: AppColors.navy, size: 18),
          ],
        ),
      ),
    );
  }
}

// ---------------------- HERO BANNER ----------------------
// ---------------------- HERO BANNER ----------------------
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
              aspectRatio: 1536 / 1024, // apni image ke actual ratio se adjust kar lena
              child: Image.asset(
                'assets/images/hero_banner.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Cards jo image ke bottom edge pe "half overlap" karte hain
          Positioned(
            left: 12,
            right: 12,
            bottom: 10, // jitna neeche overlap chahiye utna adjust karo
            child: Row(
              children: [
                Expanded(
                  child: _buildOptionCard(
                    icon: Icons.bolt,
                    title: 'Need Service Now?',
                    subtitle: 'Get an expert\nin minutes',
                    buttonText: 'Get Started',
                    isOrange: false,
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
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.bg, // solid navy card, image pe overlap ke liye opaque hona chahiye
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
          Row(children: [
            Icon(icon, color: AppColors.orange, size: 12),
            const SizedBox(width: 4),
            Text(title, style: const TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(color: Colors.black, fontSize: 9)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: isOrange ? AppColors.orange : AppColors.navy ,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(buttonText,
                    style: TextStyle(color: isOrange ? AppColors.navy: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 10, color: isOrange ? Colors.white : AppColors.navy),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------- SECTION HEADER ----------------------
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const Text('View All', style: TextStyle(fontSize: 12, color: AppColors.orange, fontWeight: FontWeight.w600)),
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

// ---------------------- TOP INSTANT SERVICES (ROW, बिना स्क्रॉल) ----------------------
class _TopInstantServices extends StatelessWidget {
  const _TopInstantServices();

  @override
  Widget build(BuildContext context) {
    const items = [
      _ServiceItem(Icons.bolt, 'Electrician', Color(0xFFE9ECFB), Color(0xFF4A5AD9)),
      _ServiceItem(Icons.plumbing, 'Plumber', Color(0xFFDBF0FF), Color(0xFF2196D9)),
      _ServiceItem(Icons.ac_unit, 'AC Repair', Color(0xFFE3F5FF), Color(0xFF1EA7E0)),
      _ServiceItem(Icons.cleaning_services, 'Cleaning', Color(0xFFE0F7EF), Color(0xFF2FAE60)),
      _ServiceItem(Icons.shopping_basket, 'Grocery', Color(0xFFE0F7E9), Color(0xFF2FAE60)),
      _ServiceItem(Icons.more_horiz, 'More', Color(0xFFEFEFF4), Color(0xFF8A8CA3)),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) {
          return SizedBox(
            width: 50,
            child: Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: item.bg, borderRadius: BorderRadius.circular(12)),
                  child: Icon(item.icon, color: item.iconColor, size: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 8, color: AppColors.textDark, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ---------------------- ADVANCE BOOKING (ROW, बिना स्क्रॉल) ----------------------
class _AdvanceBookingServices extends StatelessWidget {
  const _AdvanceBookingServices();

  @override
  Widget build(BuildContext context) {
    const items = [
      _ServiceItem(Icons.camera_alt, 'Photographer', Color(0xFFF3E8FF), Color(0xFF9B51E0)),
      _ServiceItem(Icons.diamond_outlined, 'Wedding\nPlanner', Color(0xFFFFF1E0), Color(0xFFFF9800)),
      _ServiceItem(Icons.restaurant, 'Catering', Color(0xFFFFE7E7), Color(0xFFE53935)),
      _ServiceItem(Icons.chair_alt, 'Decorator', Color(0xFFE7F0FF), Color(0xFF3F6BE0)),
      _ServiceItem(Icons.music_note, 'DJ', Color(0xFFF3E8FF), Color(0xFF9B51E0)),
      _ServiceItem(Icons.more_horiz, 'More', Color(0xFFEFEFF4), Color(0xFF8A8CA3)),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) {
          return SizedBox(
            width: 50,
            child: Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: item.bg, borderRadius: BorderRadius.circular(12)),
                  child: Icon(item.icon, color: item.iconColor, size: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 8, color: AppColors.textDark, fontWeight: FontWeight.w500),
                ),
              ],
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF3B2B8C), Color(0xFF1B2B6B)],
              begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('TruXperts Rewards',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 2),
                  const Text('Book now, earn more!', style: TextStyle(color: Colors.white70, fontSize: 10)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: const Text('Explore Rewards',
                        style: TextStyle(color: AppColors.navy, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Your Points', style: TextStyle(color: Colors.white60, fontSize: 9)),
                Row(children: const [
                  Icon(Icons.emoji_events, color: Color(0xFFFFC94A), size: 14),
                  SizedBox(width: 4),
                  Text('250', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ]),
                const SizedBox(height: 6),
                Icon(Icons.card_giftcard, color: Colors.white.withOpacity(0.5), size: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- LIVE OFFERS – ROW (बिना स्क्रॉल) ----------------------
class _LiveOffersRow extends StatelessWidget {
  const _LiveOffersRow();

  @override
  Widget build(BuildContext context) {
    final offers = [
      {'discount': '20% OFF', 'desc': 'on AC Service', 'code': 'CODE: CDDL20', 'valid': 'Valid till 31 May 2025', 'bg': const Color(0xFFE3F8EA), 'accent': const Color(0xFF2FAE60)},
      {'discount': '\$100 OFF', 'desc': 'on Fast Booking', 'code': 'CODE: FBSIT100', 'valid': 'Valid till 25 May 2025', 'bg': const Color(0xFFFFEFE3), 'accent': const Color(0xFFFF7A1A)},
      {'discount': 'UP TO 15% OFF', 'desc': 'on Cleaning Services', 'code': 'CODE: CLEAR15', 'valid': 'Valid till 31 May 2025', 'bg': const Color(0xFFEFE9FF), 'accent': const Color(0xFF7A5AF8)},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: offers.map((o) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: o['bg'] as Color, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(o['discount'] as String,
                      style: TextStyle(color: o['accent'] as Color, fontSize: 12, fontWeight: FontWeight.bold)),
                  Text(o['desc'] as String, style: const TextStyle(fontSize: 9, color: AppColors.textDark)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: (o['accent'] as Color).withOpacity(0.4)),
                    ),
                    child: Text(o['code'] as String,
                        style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: o['accent'] as Color)),
                  ),
                  const SizedBox(height: 4),
                  Text(o['valid'] as String, style: const TextStyle(fontSize: 7, color: AppColors.textGrey)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ---------------------- NEARBY PROFESSIONALS – ROW (बिना स्क्रॉल) ----------------------
class _NearbyProfessionalsRow extends StatelessWidget {
  const _NearbyProfessionalsRow();

  @override
  Widget build(BuildContext context) {
    final profs = [
      {'name': 'Amit Bactwala', 'rating': '+4.8 (120)', 'color': const Color(0xFFB9C4FF)},
      {'name': 'Suresh Pushkar', 'rating': '+4.7 (90)', 'color': const Color(0xFFFFC9A6)},
      {'name': 'AC Repair Pro', 'rating': '+4.6 (76)', 'color': const Color(0xFFA6D8FF)},
      {'name': 'Home Cleaning', 'rating': '+4.8 (112)', 'color': const Color(0xFFFFB9D6)},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: profs.map((p) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(radius: 20, backgroundColor: p['color'] as Color,
                      child: const Icon(Icons.person, color: Colors.white, size: 18)),
                  const SizedBox(height: 4),
                  Text(p['name'] as String, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                  const SizedBox(height: 2),
                  Text(p['rating'] as String, style: const TextStyle(fontSize: 8, color: AppColors.textGrey)),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFFE9ECFB), borderRadius: BorderRadius.circular(6)),
                    child: const Text('Available now', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 7, color: AppColors.navy, fontWeight: FontWeight.w600)),
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

// ---------------------- STATS ROW ----------------------
class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    final stats = [
      {'icon': Icons.emoji_emotions, 'value': '50,000+', 'label': 'Happy Customers'},
      {'icon': Icons.verified_user, 'value': '5,000+', 'label': 'Verified Professionals'},
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
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: stats.map((s) {
            return Column(
              children: [
                Icon(s['icon'] as IconData, color: AppColors.navy, size: 16),
                const SizedBox(height: 4),
                Text(s['value'] as String,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                const SizedBox(height: 2),
                SizedBox(width: 60, child: Text(s['label'] as String, textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 7, color: AppColors.textGrey))),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ---------------------- LATEST POSTS – ROW (4 कार्ड एक पंक्ति में) ----------------------
class _LatestPostsRow extends StatelessWidget {
  const _LatestPostsRow();

  @override
  Widget build(BuildContext context) {
    final posts = [
      {'author': 'Amit Photography', 'time': '2h ago', 'caption': 'Pre-wedding shoot available for this season. Book your date!', 'likes': 26, 'comments': 8, 'color': const Color(0xFFE8D9C4)},
      {'author': 'Drawn Wedding Planners', 'time': '3h ago', 'caption': 'Make your big day memorable with our expert planning.', 'likes': 32, 'comments': 5, 'color': const Color(0xFFF3C9D6)},
      {'author': 'Bing Ceremony Experts', 'time': '4h ago', 'caption': 'Bing and ceremony services for your special moments.', 'likes': 41, 'comments': 12, 'color': const Color(0xFFD9C9F3)},
      {'author': 'Shah Etesh Events', 'time': '5h ago', 'caption': 'Book a caterer, decorator, and photographers.', 'likes': 27, 'comments': 6, 'color': const Color(0xFFD6C9B0)},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: posts.map((p) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 2))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(radius: 8, backgroundColor: p['color'] as Color,
                          child: const Icon(Icons.person, size: 10, color: Colors.white)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(p['author'] as String, maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 7, fontWeight: FontWeight.w600)),
                      ),
                      const Icon(Icons.more_vert, size: 10, color: AppColors.textGrey),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(color: p['color'] as Color, borderRadius: BorderRadius.circular(8)),
                    child: const Center(child: Icon(Icons.image, color: Colors.white70, size: 18)),
                  ),
                  const SizedBox(height: 4),
                  Text(p['caption'] as String, maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 7, color: AppColors.textDark, height: 1.2)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.favorite_border, size: 9, color: AppColors.textGrey),
                      const SizedBox(width: 2),
                      Text('${p['likes']}', style: const TextStyle(fontSize: 6, color: AppColors.textGrey)),
                      const SizedBox(width: 6),
                      const Icon(Icons.mode_comment_outlined, size: 9, color: AppColors.textGrey),
                      const SizedBox(width: 2),
                      Text('${p['comments']}', style: const TextStyle(fontSize: 6, color: AppColors.textGrey)),
                    ],
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