import 'package:flutter/material.dart';
import 'package:truxperts/screens/Profile/profile_screen.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/screens/home/categories.dart';
import 'package:truxperts/screens/home/section_header.dart';
import 'package:truxperts/screens/home/service_icon.dart';

/// Home / Dashboard screen.
///
/// NOTE: This screen intentionally does NOT include a Scaffold's
/// bottomNavigationBar — it's built to be dropped into an existing
/// navbar/IndexedStack setup as-is.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FB),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          children: [
            _TopBar(),
            const SizedBox(height: 16),
            _SearchBar(),
            const SizedBox(height: 18),
            const _PostServiceRequestCard(),
            const SizedBox(height: 24),

            SectionHeader(title: 'What service do you need?', onViewAll: () {}),
            const SizedBox(height: 14),
            _ServiceGrid(),
            const SizedBox(height: 24),

            SectionHeader(title: 'My Requests', onViewAll: () {}),
            const SizedBox(height: 12),
            const _RequestCard(
              icon: 'assets/icons/electrician.png',
              iconBg: AppColors.iconElectricianBg,
              iconFg: AppColors.iconElectricianFg,
              title: 'Electrician Needed',
              badgeLabel: 'Assigned',
              badgeBg: AppColors.badgeAssignedBg,
              badgeText: AppColors.badgeAssignedText,
              location: 'Kothrud, Pune',
              dateTime: '08 Jul 2025  •  04:30 PM',
              description: 'Need wiring repair in 2BHK flat.',
              trailing: _RequestAssignedTrailing(),
            ),
            const SizedBox(height: 12),
            const _RequestCard(
              icon: 'assets/icons/plumber.png',
              iconBg: AppColors.iconPlumberBg,
              iconFg: AppColors.iconPlumberFg,
              title: 'Plumbing Issue',
              badgeLabel: 'Pending',
              badgeBg: AppColors.badgePendingBg,
              badgeText: AppColors.badgePendingText,
              location: 'Baner, Pune',
              dateTime: '07 Jul 2025  •  11:00 AM',
              description: 'Tap leaking in bathroom.',
              trailing: _RequestPendingTrailing(),
            ),
            const SizedBox(height: 24),

            SectionHeader(title: 'Nearby Professionals', onViewAll: () {}),
            const SizedBox(height: 12),
            const _ProfessionalCard(
              name: 'Amit Electricals',
              role: 'Electrician  •  5 Years Exp.',
              distance: '1.2 km away',
              rating: '4.7',
            ),
            const SizedBox(height: 12),
            const _ProfessionalCard(
              name: 'PowerFix Services',
              role: 'Electrician  •  8 Years Exp.',
              distance: '1.5 km away',
              rating: '4.9',
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Top bar: location + logo + chat/notification icons
// ---------------------------------------------------------------------------

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Row(
              children: const [
                Icon(Icons.location_on, size: 16, color: AppColors.orange),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    'Pune, Maharashtra',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
        Column(
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
                children: [
                  TextSpan(text: 'Tru', style: TextStyle(color: AppColors.navy)),
                  TextSpan(text: 'X', style: TextStyle(color: AppColors.orange)),
                  TextSpan(text: 'perts', style: TextStyle(color: AppColors.navy)),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 10, height: 1, color: AppColors.orange),
                const SizedBox(width: 4),
                const Text(
                  'Trusted Professionals, One Tap Away.',
                  style: TextStyle(fontSize: 8, color: AppColors.textSecondary),
                ),
                const SizedBox(width: 4),
                Container(width: 10, height: 1, color: AppColors.orange),
              ],
            ),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _IconBadge(
  icon: 'assets/icons/chats.png',
  count: '3',
),

const SizedBox(width: 14),

_IconBadge(
  icon: 'assets/icons/notification.png',
  count: '8',
),
            ],
          ),
        ),
      ],
    );
  }
}

class _IconBadge extends StatelessWidget {
  final String icon;
  final String count;

  const _IconBadge({
    required this.icon,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
  icon,
  width: 24,
  height: 24,
  fit: BoxFit.contain,
),
        Positioned(
          right: -4,
          top: -4,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: AppColors.badgeNotifBg,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
            child: Text(
              count,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Search bar
// ---------------------------------------------------------------------------

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.fieldBorder, width: 1.2),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Search services or professionals...',
              style: TextStyle(fontSize: 13, color: AppColors.hintText),
            ),
          ),
          const Icon(Icons.tune, size: 18, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Post a Service Request card
// ---------------------------------------------------------------------------

class _PostServiceRequestCard extends StatelessWidget {
  const _PostServiceRequestCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(text: 'Post a ', style: TextStyle(color: Colors.white)),
                    TextSpan(text: 'Service Request', style: TextStyle(color: AppColors.orangeLight)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 170,
                child: Text(
                  "Tell us what you need, we'll connect you with trusted professionals nearby.",
                  style: TextStyle(fontSize: 11.5, color: Colors.white.withOpacity(0.75), height: 1.4),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Post Now', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, size: 15),
                  ],
                ),
              ),
            ],
          ),

          // Person illustration (simplified iconographic representation)
          Positioned(
            right: -6,
            bottom: -18,
            child: Container(
              height: 118,
              width: 118,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.white38, size: 64),
            ),
          ),

          // Floating "I need an Electrician" mini card
          Positioned(
            right: 0,
            top: -6,
            child: Container(
              width: 128,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'I need an',
                    style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                  ),
                  const Text(
                    'Electrician',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navy,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Icon(Icons.bolt, size: 14, color: AppColors.orange),
                      SizedBox(width: 4),
                      Icon(Icons.location_on, size: 12, color: AppColors.textSecondary),
                      SizedBox(width: 2),
                      Text('Near me', style: TextStyle(fontSize: 9.5, color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.navy,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Post', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
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
}

// ---------------------------------------------------------------------------
// Service grid (Electrician / Plumber / Carpenter / Painter / More)
// ---------------------------------------------------------------------------

class _ServiceGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ServiceIconTile(
          icon: 'assets/icons/electrician.png',
          label: 'Electrician',
          iconBg: AppColors.iconElectricianBg,
          iconColor: AppColors.iconElectricianFg,
          selected: true,
          onTap: () {},
        ),
        ServiceIconTile(
          icon: 'assets/icons/plumber.png',
          label: 'Plumber',
          iconBg: AppColors.iconPlumberBg,
          iconColor: AppColors.iconPlumberFg,
          onTap: () {},
        ),
        ServiceIconTile(
          icon: 'assets/icons/carpenter.png',
          label: 'Carpenter',
          iconBg: AppColors.iconCarpenterBg,
          iconColor: AppColors.iconCarpenterFg,
          onTap: () {},
        ),
        ServiceIconTile(
          icon: 'assets/icons/painter.png',
          label: 'Painter',
          iconBg: AppColors.iconPainterBg,
          iconColor: AppColors.iconPainterFg,
          onTap: () {},
        ),
        ServiceIconTile(
          icon: 'assets/icons/more.png',
          label: 'More',
          iconBg: AppColors.iconMoreBg,
          iconColor: AppColors.iconMoreFg,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CategoriesScreen()),
            );
          },
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// My Requests card
// ---------------------------------------------------------------------------

class _RequestCard extends StatelessWidget {
  final String icon;
  final Color iconBg;
  final Color iconFg;
  final String title;
  final String badgeLabel;
  final Color badgeBg;
  final Color badgeText;
  final String location;
  final String dateTime;
  final String description;
  final Widget trailing;

  const _RequestCard({
    required this.icon,
    required this.iconBg,
    required this.iconFg,
    required this.title,
    required this.badgeLabel,
    required this.badgeBg,
    required this.badgeText,
    required this.location,
    required this.dateTime,
    required this.description,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
  height: 40,
  width: 40,
  decoration: BoxDecoration(
    color: iconBg,
    shape: BoxShape.circle,
  ),
  child: Center(
    child: Image.asset(
      icon,
      width: 18,
      height: 18,
      fit: BoxFit.contain,
      // color: iconFg, // Agar image black/white hai tab use karo,
      // agar image already colored hai to is line ko hata do.
    ),
  ),
),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: badgeBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        badgeLabel,
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: badgeText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 3),
                    Text(location, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 11, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(dateTime, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(fontSize: 11.5, color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          trailing,
        ],
      ),
    );
  }
}

/// Right-hand side of the "Electrician Needed / Assigned" card:
/// avatar, name, rating, and a Chat button.
class _RequestAssignedTrailing extends StatelessWidget {
  const _RequestAssignedTrailing();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Rahul Sharma',
                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.star, size: 12, color: AppColors.star),
                    SizedBox(width: 2),
                    Text('4.8', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 6),
            const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.chipUnselected,
              child: Icon(Icons.person, size: 18, color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // OutlinedButton(
        //   onPressed: () {},
        //   style: OutlinedButton.styleFrom(
        //     side: const BorderSide(color: AppColors.navy, width: 1.2),
        //     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        //   ),
        //   child: const Text('Chat', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.navy)),
        // ),
      ],
    );
  }
}

/// Right-hand side of the "Plumbing Issue / Pending" card: clock icon
/// and "Looking for professional..." text.
class _RequestPendingTrailing extends StatelessWidget {
  const _RequestPendingTrailing();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          SizedBox(height: 50),
          Icon(Icons.access_time, size: 14, color: AppColors.navy),
          SizedBox(height: 4),
          Text(
            'Looking for\n professional...',
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Nearby Professionals card
// ---------------------------------------------------------------------------

class _ProfessionalCard extends StatelessWidget {
  final String name;
  final String role;
  final String distance;
  final String rating;

  const _ProfessionalCard({
    required this.name,
    required this.role,
    required this.distance,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder, width: 1.2),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.chipUnselected,
            child: Icon(Icons.person, size: 24, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
                      ),
                    ),
                    const Icon(Icons.star, size: 13, color: AppColors.star),
                    const SizedBox(width: 2),
                    Text(rating, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  ],
                ),
                const SizedBox(height: 3),
                Text(role, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 3),
                    Text(distance, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProviderProfileScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.navy,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('View Profile', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}