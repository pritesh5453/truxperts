import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';

class PartnerHomeScreen extends StatelessWidget {
  const PartnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _HeaderSection(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _EarningsCard(),
                  const SizedBox(height: 16),
                  const _StatsRow(),
                  const SizedBox(height: 22),
                  _SectionHeader(title: 'New Service Requests', onViewAll: () {}),
                  const SizedBox(height: 12),
                  ..._serviceRequests.map(
                    (r) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _ServiceRequestCard(request: r),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _SectionHeader(title: 'Upcoming Jobs', onViewAll: () {}),
                  const SizedBox(height: 12),
                  const _UpcomingJobCard(),
                  const SizedBox(height: 20),
                  const _GrowBusinessBanner(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================
// HEADER: gradient app bar + greeting card overlapping it
// ==============================
class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return SizedBox(
      height: topPadding + 175,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: topPadding + 118,
            padding: EdgeInsets.fromLTRB(16, topPadding + 10, 16, 0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.headerGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.menu, color: Colors.white, size: 24),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(text: 'Tru', style: TextStyle(color: Colors.white)),
                          TextSpan(
                              text: 'Xperts',
                              style: TextStyle(color: AppColors.orange)),
                        ],
                      ),
                    ),
                    const Text(
                      'Partner',
                      style: TextStyle(color: Colors.white70, fontSize: 10.5),
                    ),
                  ],
                ),
                const Spacer(),
                const _OnlineChip(),
                const SizedBox(width: 10),
                const _NotificationBell(badgeCount: 5),
              ],
            ),
          ),
          Positioned(
            top: topPadding + 78,
            left: 16,
            right: 16,
            child: const _GreetingCard(),
          ),
        ],
      ),
    );
  }
}

class _OnlineChip extends StatelessWidget {
  const _OnlineChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.greenAccent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'Online',
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
        ],
      ),
    );
  }
}

class _NotificationBell extends StatelessWidget {
  final int badgeCount;
  const _NotificationBell({required this.badgeCount});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(Icons.notifications_none_rounded,
              color: Colors.white, size: 24),
          if (badgeCount > 0)
            Positioned(
              right: -3,
              top: -3,
              child: Container(
                padding: const EdgeInsets.all(3),
                constraints: const BoxConstraints(minWidth: 15, minHeight: 15),
                decoration: const BoxDecoration(
                  color: AppColors.orange,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$badgeCount',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8.5,
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

class _GreetingCard extends StatelessWidget {
  const _GreetingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFFE9ECFB),
            child: Icon(Icons.person, color: AppColors.primaryBlue),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hi, Amit 👋',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "Let's grow your business today!",
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.location_on_outlined,
                  size: 14, color: AppColors.primaryBlue),
              SizedBox(width: 2),
              Text(
                'Pune,\nMaharashtra',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlue,
                ),
              ),
              Icon(Icons.keyboard_arrow_down,
                  size: 16, color: AppColors.primaryBlue),
            ],
          ),
        ],
      ),
    );
  }
}

// ==============================
// EARNINGS CARD
// ==============================
class _EarningsCard extends StatelessWidget {
  const _EarningsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.headerGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CustomPaint(painter: _SparklinePainter()),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Today's Earnings",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      SizedBox(height: 6),
                      Text(
                        '₹2,450',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.account_balance_wallet_outlined,
                        color: Colors.white, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 34),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.task_alt, color: Colors.white70, size: 14),
                      SizedBox(width: 6),
                      Text(
                        '4 Jobs Completed',
                        style: TextStyle(color: Colors.white, fontSize: 11.5),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'View Earnings',
                            style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward,
                              size: 13, color: AppColors.primaryBlue),
                        ],
                      ),
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
}

// Faint ascending sparkline drawn behind the earnings card text
class _SparklinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.14)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final points = <Offset>[
      Offset(size.width * 0.05, size.height * 0.75),
      Offset(size.width * 0.22, size.height * 0.6),
      Offset(size.width * 0.38, size.height * 0.68),
      Offset(size.width * 0.55, size.height * 0.42),
      Offset(size.width * 0.72, size.height * 0.5),
      Offset(size.width * 0.88, size.height * 0.22),
      Offset(size.width * 1.02, size.height * 0.3),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final p in points.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==============================
// STATS ROW
// ==============================
class _StatItem {
  final IconData icon;
  final Color color;
  final String value;
  final String label;
  const _StatItem(this.icon, this.color, this.value, this.label);
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  static const List<_StatItem> _stats = [
    _StatItem(Icons.assignment_outlined, AppColors.primaryBlue, '12', 'New Leads'),
    _StatItem(Icons.event_available_outlined, AppColors.green, '3', 'Upcoming'),
    _StatItem(Icons.star_rounded, AppColors.purple, '4.8', 'Rating'),
    _StatItem(Icons.trending_up, AppColors.orange, '92%', 'Response Rate'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _stats.map((s) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: s.color.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(s.icon, color: s.color, size: 17),
                ),
                const SizedBox(height: 8),
                Text(
                  s.value,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  s.label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 8.5, color: AppColors.textGrey),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ==============================
// SECTION HEADER
// ==============================
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;
  const _SectionHeader({required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        TextButton(
          onPressed: onViewAll,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View All',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlue,
                ),
              ),
              SizedBox(width: 2),
              Icon(Icons.arrow_forward_ios, size: 11, color: AppColors.primaryBlue),
            ],
          ),
        ),
      ],
    );
  }
}

// ==============================
// NEW SERVICE REQUESTS
// ==============================
class _ServiceRequest {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String location;
  final String distance;
  final String metaLabel; // e.g. "Needed: ASAP" or "18 Aug 2026"
  final Color metaColor;
  final String metaSecondary; // e.g. "Posted 3 min ago" or "Wedding Event"
  final String budget;
  final bool urgent;

  const _ServiceRequest({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.location,
    required this.distance,
    required this.metaLabel,
    required this.metaColor,
    required this.metaSecondary,
    required this.budget,
    this.urgent = false,
  });
}

const List<_ServiceRequest> _serviceRequests = [
  _ServiceRequest(
    icon: Icons.bolt,
    iconBg: Color(0xFFFFF1D6),
    iconColor: AppColors.orange,
    title: 'Electrical Wiring Repair',
    location: 'Kothrud, Pune',
    distance: '1.2 km away',
    metaLabel: 'Needed: ASAP',
    metaColor: AppColors.red,
    metaSecondary: 'Posted 3 min ago',
    budget: 'Budget: ₹500 – ₹800',
    urgent: true,
  ),
  _ServiceRequest(
    icon: Icons.camera_alt_outlined,
    iconBg: Color(0xFFF3E8FF),
    iconColor: AppColors.purple,
    title: 'Wedding Photography',
    location: 'Nashik, Maharashtra',
    distance: '45 km away',
    metaLabel: '18 Aug 2026',
    metaColor: AppColors.textDark,
    metaSecondary: 'Wedding Event',
    budget: 'Budget: ₹25,000 – ₹35,000',
  ),
  _ServiceRequest(
    icon: Icons.plumbing,
    iconBg: Color(0xFFE0F7EF),
    iconColor: AppColors.green,
    title: 'Bathroom Plumbing',
    location: 'Wakad, Pune',
    distance: '3.5 km away',
    metaLabel: 'Needed: Tomorrow',
    metaColor: AppColors.orange,
    metaSecondary: 'Posted 15 min ago',
    budget: 'Budget: ₹700 – ₹1,200',
  ),
];

class _ServiceRequestCard extends StatelessWidget {
  final _ServiceRequest request;
  const _ServiceRequestCard({required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: request.iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(request.icon, color: request.iconColor, size: 19),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 12, color: AppColors.textGrey),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            '${request.location} · ${request.distance}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 10.5, color: AppColors.textGrey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (request.urgent)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.bolt, size: 11, color: AppColors.red),
                      SizedBox(width: 2),
                      Text(
                        'URGENT',
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                request.metaLabel,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: request.metaColor,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '· ${request.metaSecondary}',
                style: const TextStyle(fontSize: 10.5, color: AppColors.textGrey),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            request.budget,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.green,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    side: const BorderSide(color: AppColors.border, width: 1.2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'Accept',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==============================
// UPCOMING JOB CARD
// ==============================
class _UpcomingJobCard extends StatelessWidget {
  const _UpcomingJobCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.red.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                Text(
                  'MAY',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.red,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '28',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.red,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '10:00 AM',
                  style: TextStyle(fontSize: 8, color: AppColors.red),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Home Electrical Installation',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: const [
                    Icon(Icons.location_on_outlined,
                        size: 12, color: AppColors.textGrey),
                    SizedBox(width: 3),
                    Text(
                      'Baner, Pune',
                      style: TextStyle(fontSize: 10.5, color: AppColors.textGrey),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: const [
                    Icon(Icons.call_outlined, size: 12, color: AppColors.primaryBlue),
                    SizedBox(width: 3),
                    Text(
                      'Customer: Rahul S.',
                      style: TextStyle(fontSize: 10.5, color: AppColors.textGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'CONFIRMED',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: AppColors.green,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '₹1,800',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==============================
// GROW BUSINESS BANNER
// ==============================
class _GrowBusinessBanner extends StatelessWidget {
  const _GrowBusinessBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.rocket_launch_outlined,
                color: AppColors.primaryBlue, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Grow Your Business',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Complete more jobs and get more visibility & leads.',
                  style: TextStyle(fontSize: 10, color: AppColors.textGrey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              side: const BorderSide(color: AppColors.primaryBlue, width: 1.2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'View Growth Tips',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}