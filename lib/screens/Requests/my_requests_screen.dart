import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:truxperts/screens/Requests/advance/advance_details_screen.dart';
import 'package:truxperts/screens/Requests/assign_details_screen.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({Key? key}) : super(key: key);

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  bool instantSelected = true;
  bool advanceSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: CommonAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'My Requests',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1A1A2E),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Track all your service requests in one place.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff6C757D),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Booking Type Filters
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  const SizedBox(height: 12),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: _buildBookingTypeChip(
                            icon: LucideIcons.zap,
                            label: 'Instant Booking',
                            subtitle: 'Quick services at your door',
                            selected: instantSelected,
                            onTap: () {
                              setState(() {
                                if (!instantSelected) {
                                  instantSelected = true;
                                  advanceSelected = false;
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: _buildBookingTypeChip(
                            icon: LucideIcons.calendar,
                            label: 'Advance Booking',
                            subtitle: 'Plan ahead, book in advance',
                            selected: advanceSelected,
                            onTap: () {
                              setState(() {
                                if (!advanceSelected) {
                                  advanceSelected = true;
                                  instantSelected = false;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Status Filter Chips (unchanged)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xffEFF1F4)),
                ),
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFilterChip(
                            'All Requests',
                            '12',
                            isSelected: true,
                            activeColor: AppColors.navy,
                          ),
                          _buildVerticalDivider(),
                          _buildFilterChip(
                            'Pending',
                            '4',
                            countBg: const Color(0xffFFECC7),
                            countText: const Color(0xffFF9F00),
                          ),
                          _buildVerticalDivider(),
                          _buildFilterChip(
                            'Assigned',
                            '3',
                            countBg: const Color(0xffE0EFFF),
                            countText: const Color(0xff007AFF),
                          ),
                          _buildVerticalDivider(),
                          _buildFilterChip(
                            'In Progress',
                            '2',
                            countBg: const Color(0xffEAE4FF),
                            countText: AppColors.navy,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildFilterChip(
                            'Completed',
                            '3',
                            countBg: const Color(0xffE2F6EA),
                            countText: const Color(0xff27AE60),
                          ),
                          const SizedBox(width: 16),
                          _buildVerticalDivider(),
                          const SizedBox(width: 16),
                          _buildFilterChip(
                            'Cancelled',
                            '0',
                            countBg: const Color(0xffE9ECEF),
                            countText: const Color(0xff6C757D),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Request Cards (same as before)
              _buildRequestCard(
                title: 'Electrical Wiring Repair',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RequestTrackingScreen(),
                    ),
                  );
                },
                location: 'Kothrud, Pune',
                dateTime: '08 Jul 2025  •  04:30 PM',
                description: 'Need wiring repair in 2BHK flat.',
                reqId: 'REQ125678',
                statusText: 'Assigned',
                statusBg: const Color(0xffE0EFFF),
                statusTextColor: const Color(0xff007AFF),
                icon: LucideIcons.zap,
                iconColor: AppColors.navy,
                iconBg: const Color(0xffEAE4FF),
                footerLeftText: '1 Quote Received',
                actionWidget: _buildChatButton(),
                providerName: 'Amit Electricals',
                providerRating: '4.7',
                providerImage: 'https://i.imgur.com/8Km9tLL.png',
              ),
              const SizedBox(height: 16),

              _buildRequestCard(
                title: 'Plumbing Issue',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RequestDetailsScreen(),
                    ),
                  );
                },
                location: 'Baner, Pune',
                dateTime: '07 Jul 2025  •  11:00 AM',
                description: 'Tap leaking in bathroom.',
                reqId: 'REQ125677',
                statusText: 'Pending',
                statusBg: const Color(0xffFFECC7),
                statusTextColor: const Color(0xffFF9F00),
                icon: LucideIcons.pipette,
                iconColor: const Color(0xffE65F2B),
                iconBg: const Color(0xffFFEFEA),
                footerLeftText: '0 Quotes Yet',
                actionWidget: _buildViewDetailsButton(),
                middleWidget: Row(
                  children: [
                    const Icon(
                      LucideIcons.clock,
                      color: AppColors.navy,
                      size: 15,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Looking for professionals...',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "We'll notify you soon",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xff6C757D),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xffA0AEC0)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              _buildRequestCard(
                title: 'AC Repair & Service',
                location: 'Wakad, Pune',
                dateTime: '05 Jul 2025  •  10:00 AM',
                description: 'AC not cooling properly.',
                reqId: 'REQ125675',
                statusText: 'In Progress',
                statusBg: const Color(0xffEAE4FF),
                statusTextColor: AppColors.navy,
                icon: LucideIcons.airplay,
                iconColor: const Color(0xff007AFF),
                iconBg: const Color(0xffE0EFFF),
                footerLeftText: 'Work in Progress',
                actionWidget: _buildChatButton(),
                providerName: 'CoolTech Solutions',
                providerRating: '4.8',
                providerImage: 'https://i.imgur.com/8Km9tLL.png',
              ),
              const SizedBox(height: 16),

              _buildRequestCard(
                title: 'Wall Painting',
                location: 'Hinjawadi, Pune',
                dateTime: '02 Jul 2025  •  09:00 AM',
                description: '2BHK flat painting with putty.',
                reqId: 'REQ125670',
                statusText: 'Completed',
                statusBg: const Color(0xffE2F6EA),
                statusTextColor: const Color(0xff27AE60),
                icon: LucideIcons.paintBucket,
                iconColor: const Color(0xff27AE60),
                iconBg: const Color(0xffE2F6EA),
                footerLeftText: 'Completed on 03 Jul 2025',
                actionWidget: TextButton(
                  onPressed: () {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => const RequestDetailsScreen()));
                  },
                  child: const Text(
                    'Rate Now',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
                providerName: 'ColorCraft Painters',
                providerRating: '4.6',
                providerImage: 'https://i.imgur.com/8Km9tLL.png',
              ),
              const SizedBox(height: 16),

              _buildRequestCard(
                title: 'Switchboard Installation',
                location: 'Kharadi, Pune',
                dateTime: '28 Jun 2025  •  05:00 PM',
                description: 'Need new switchboard installation.',
                reqId: 'REQ125668',
                statusText: 'Cancelled',
                statusBg: const Color(0xffE9ECEF),
                statusTextColor: const Color(0xff6C757D),
                icon: LucideIcons.wrench,
                iconColor: const Color(0xffE63946),
                iconBg: const Color(0xffFAD2E1),
                footerLeftText: '',
                actionWidget: _buildViewDetailsButton(),
                middleWidget: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Cancelled by you',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff6C757D),
                            ),
                          ),
                          Text(
                            '28 Jun 2025',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xffA0AEC0)),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  // ========== Booking Type Chip (with navy background & white text when selected) ==========
  Widget _buildBookingTypeChip({
    required IconData icon,
    required String label,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.navy : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.navy : const Color(0xffEFF1F4),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : const Color(0xffA0AEC0),
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      color: selected ? Colors.white : const Color(0xff1A1A2E),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 9,
                      color: selected ? Colors.white : const Color(0xff6C757D),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========== Existing helpers ==========
  Widget _buildVerticalDivider() {
    return VerticalDivider(
      color: Colors.grey.shade300,
      thickness: 1,
      width: 1,
      indent: 6,
      endIndent: 6,
    );
  }

  Widget _buildFilterChip(
    String label,
    String count, {
    bool isSelected = false,
    Color? activeColor,
    Color? countBg,
    Color? countText,
  }) {
    return Container(
      padding: isSelected
          ? const EdgeInsets.symmetric(horizontal: 8, vertical: 6)
          : const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? (activeColor ?? AppColors.navy)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xff4A5568),
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white
                  : (countBg ?? const Color(0xffE2E8F0)),
              shape: BoxShape.circle,
            ),
            child: Text(
              count,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? (activeColor ?? AppColors.navy)
                    : (countText ?? AppColors.navy.withOpacity(0.8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard({
    required String title,
    required String location,
    required String dateTime,
    required String description,
    required String reqId,
    required String statusText,
    required Color statusBg,
    required Color statusTextColor,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String footerLeftText,
    required Widget actionWidget,
    String? providerName,
    String? providerRating,
    String? providerImage,
    Widget? middleWidget,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffF1F3F5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: iconBg,
                      child: Icon(icon, color: iconColor, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Color(0xff1A1A2E),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: statusBg,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  statusText,
                                  style: TextStyle(
                                    color: statusTextColor,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                LucideIcons.mapPin,
                                size: 12,
                                color: Color(0xffA0AEC0),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                location,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff718096),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                LucideIcons.calendar,
                                size: 12,
                                color: Color(0xffA0AEC0),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                dateTime,
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Color(0xff718096),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xff4A5568),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (providerName != null) ...[
                      const SizedBox(width: 12),
                      Row(
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  providerImage ?? '',
                                  width: 36,
                                  height: 36,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => const CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Color(0xffCBD5E0),
                                    child: Icon(
                                      LucideIcons.user,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                providerName.length > 12
                                    ? '${providerName.substring(0, 10)}...'
                                    : providerName,
                                style: const TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff1A1A2E),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    providerRating ?? '0.0',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.chevron_right,
                            color: Color(0xffA0AEC0),
                          ),
                        ],
                      ),
                    ] else if (middleWidget != null) ...[
                      const SizedBox(width: 12),
                      SizedBox(width: 120, child: middleWidget),
                    ],
                  ],
                ),
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xffEDF2F7)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  footerLeftText,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xff6C757D),
                  ),
                ),
                actionWidget,
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildChatButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0),
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(
          LucideIcons.messageSquare,
          size: 10,
          color: AppColors.navy,
        ),
        label: const Text(
          'Chat',
          style: TextStyle(
            color: AppColors.navy,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 35),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          side: const BorderSide(color: AppColors.navy),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static Widget _buildViewDetailsButton() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: const [
          Text(
            'View Details',
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.chevron_right, size: 16, color: AppColors.navy),
        ],
      ),
    );
  }
}