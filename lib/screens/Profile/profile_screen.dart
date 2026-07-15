import 'package:flutter/material.dart';

class ProviderProfileScreen extends StatelessWidget {
  const ProviderProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const Icon(Icons.arrow_back, color: Color(0xff1A1A2E)),
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'TruXperts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff1C2D5A),
              ),
            ),
            SizedBox(height: 2),
            Text(
              "— Trusted Professionals, One Tap Away. —",
              style: TextStyle(
                fontSize: 8,
                color: Color(0xff6C757D),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.share_outlined, color: Color(0xff1A1A2E), size: 22),
          SizedBox(width: 12),
          Icon(Icons.more_vert, color: Color(0xff1A1A2E), size: 22),
          SizedBox(width: 16),
        ],
      ),
      // SafeArea inside SingleChildScrollView solves the bottom offset calculation bug
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Hero Card Cover
              _buildHeroProfileCard(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // 2. Performance Stats Block
                    _buildPerformanceStatsRow(),
                    const SizedBox(height: 16),

                    // 3. Action Buttons (Chat, Call, Save)
                    _buildCommunicationRow(),
                    const SizedBox(height: 24),

                    // 4. Services Grid Layout
                    _buildSectionHeader('Services', showViewAll: true),
                    const SizedBox(height: 12),
                    _buildServicesGrid(),
                    const SizedBox(height: 24),

                    // 5. Bio Section
                    _buildSectionHeader('About', showViewAll: false),
                    const SizedBox(height: 8),
                    const Text(
                      'We provide professional electrical services for homes, offices and commercial spaces. Quality work, on-time service and customer satisfaction is our priority.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff4A5568),
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildAboutBadgesRow(),
                    const SizedBox(height: 24),

                    // 6. Project Portfolios (Replaced broken image URLs with local Icon widgets)
                    _buildSectionHeader('My Work', showViewAll: true),
                    const SizedBox(height: 12),
                    _buildWorkGalleryRow(),
                    const SizedBox(height: 24),

                    // 7. Testimonials Feed
                    _buildSectionHeader('Reviews & Ratings', showViewAll: true),
                    const SizedBox(height: 12),
                    _buildReviewCard(),

                    // Dynamic padding so bottom persistent container doesn't block lists
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Clean structure container using full horizontal space matrix
      bottomNavigationBar: Material(
        elevation: 20,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xffEDF2F7), width: 1)),
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Wrapped left column content inside Expanded to stop horizontal push crashes
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Get Quote',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6338E2),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Free Estimate',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xffA0AEC0),
                        ),
                      ),
                    ],
                  ),
                ),
                // Center action button layout fixed
                Expanded(
                  flex: 4,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1C2D5A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.send, size: 15, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Send Request',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Right Badge
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.shield_outlined,
                        size: 18,
                        color: Color(0xff1C2D5A),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Verified Professional',
                        style: TextStyle(
                          fontSize: 8,
                          color: Color(0xff718096),
                          height: 1.15,
                        ),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- 1. Top Profile Banner Card ---
  Widget _buildHeroProfileCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xff0F1E36), Color(0xff1C355E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 40),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff27AE60),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.check, color: Colors.white, size: 10),
                          SizedBox(width: 4),
                          Text(
                            'Verified',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Amit Electricals',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '⚡ Electrician',
                      style: TextStyle(
                        color: Color(0xffFF9F00),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Icon(Icons.star, color: Colors.amber, size: 14),
                        SizedBox(width: 2),
                        Text(
                          '4.7',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '(128 Reviews)',
                          style: TextStyle(fontSize: 11, color: Colors.white60),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 2. Stats Rows ---
  Widget _buildPerformanceStatsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xffF8F9FA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffEDF2F7)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSingleStatItem(
            Icons.assignment_turned_in_outlined,
            '5+',
            'Years Exp.',
          ),
          _buildStatDivider(),
          _buildSingleStatItem(
            Icons.business_center_outlined,
            '320+',
            'Jobs Completed',
          ),
          _buildStatDivider(),
          _buildSingleStatItem(Icons.people_outline, '210+', 'Happy Clients'),
        ],
      ),
    );
  }

  Widget _buildSingleStatItem(
    IconData icon,
    String primaryText,
    String secondaryText,
  ) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xff1C2D5A)),
          const SizedBox(height: 6),
          Text(
            primaryText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Color(0xff1A1A2E),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            secondaryText,
            style: const TextStyle(fontSize: 9, color: Color(0xff718096)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(height: 24, width: 1, color: const Color(0xffE2E8F0));
  }

  // --- 3. Communication Rows ---
  Widget _buildCommunicationRow() {
    return Row(
      children: [
        Expanded(child: _buildActionButton(Icons.chat_bubble_outline, 'Chat')),
        const SizedBox(width: 12),
        Expanded(child: _buildActionButton(Icons.phone_outlined, 'Call')),
        const SizedBox(width: 12),
        Expanded(child: _buildActionButton(Icons.favorite_border, 'Save')),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16, color: const Color(0xff1C2D5A)),
      label: Text(
        label,
        style: const TextStyle(
          color: Color(0xff1C2D5A),
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xffE2E8F0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  // --- 4. Services Grid Segment ---
  Widget _buildServicesGrid() {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 0.85,
      children: [
        _buildServiceIconCard(Icons.bolt, 'Wiring'),
        _buildServiceIconCard(Icons.power, 'Sockets'),
        _buildServiceIconCard(Icons.mode_fan_off, 'Fans'),
        _buildServiceIconCard(Icons.add, 'More', isPlus: true),
      ],
    );
  }

  Widget _buildServiceIconCard(
    IconData icon,
    String text, {
    bool isPlus = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffEDF2F7)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isPlus ? Colors.black54 : const Color(0xff6338E2),
            size: 22,
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xff2D3748),
            ),
          ),
        ],
      ),
    );
  }

  // --- 5. Custom Badges Segment ---
  Widget _buildAboutBadgesRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildInfoBadge(
            Icons.verified_user_outlined,
            'License',
            'PUN/EL/14587',
          ),
          const SizedBox(width: 8),
          _buildInfoBadge(Icons.star_outline, 'Exp', '5+ Years'),
        ],
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xffF8F9FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffEDF2F7)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 15, color: const Color(0xff718096)),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 9, color: Color(0xffA0AEC0)),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2D3748),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 6. Work Mock Containers (Replaced Network Dependent Image Views) ---
  Widget _buildWorkGalleryRow() {
    return Row(
      children: [
        Expanded(child: _buildPlaceholderBox('Wiring Done')),
        const SizedBox(width: 6),
        Expanded(child: _buildPlaceholderBox('DB Setup')),
        const SizedBox(width: 6),
        Expanded(child: _buildPlaceholderBox('Inverters')),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                '+12',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderBox(String text) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: const Color(0xffF8F9FA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffEDF2F7)),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // --- 7. Review Section ---
  Widget _buildReviewCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffEDF2F7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueGrey,
                ),
                child: const Icon(Icons.person, size: 18, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Rahul Sharma',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xff1A1A2E),
                      ),
                    ),
                    Text(
                      '⭐ 5.0  •  2 days ago',
                      style: TextStyle(fontSize: 10, color: Color(0xffA0AEC0)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Very professional service. Came on time and fixed the switchboard issue perfectly. Highly recommended!',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff4A5568),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required bool showViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Color(0xff1A1A2E),
          ),
        ),
        if (showViewAll)
          const Text(
            'View All >',
            style: TextStyle(
              color: Color(0xff6338E2),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
