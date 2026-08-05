import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:truxperts/Model_n_svc/my_requests/my_request_model.dart';
import 'package:truxperts/Model_n_svc/my_requests/my_request_svc.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';
import 'package:truxperts/Customer/screen/advance/advance_details_screen.dart';
import 'package:truxperts/Customer/screen/Requests/assign_details_screen.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';
import 'package:dio/dio.dart';
import 'package:truxperts/utils/sharedPreference/apppreference.dart';
import 'package:shimmer/shimmer.dart'; // ✅ Shimmer import

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({Key? key}) : super(key: key);

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  bool instantSelected = true;
  bool advanceSelected = false;

  List<Booking> _allBookings = [];
  List<Booking> _displayedBookings = [];
  bool _isLoading = false;
  String? _selectedStatus;

  Map<String, dynamic> _stats = {};

  late InstantBookingService _bookingService;

  @override
  void initState() {
    super.initState();
    final dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
    _bookingService = InstantBookingService(dio);
    _fetchStatsAndBookings();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatTime(String time) {
    try {
      final parts = time.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      final ampm = hour >= 12 ? 'PM' : 'AM';
      if (hour > 12) hour -= 12;
      if (hour == 0) hour = 12;
      return '$hour:${minute.toString().padLeft(2, '0')} $ampm';
    } catch (_) {
      return time;
    }
  }

  Future<void> _fetchStatsAndBookings() async {
    setState(() => _isLoading = true);
    try {
      final userData = await AppPreferences.getUser();
      final userId = userData?['id'] as int?;
      if (userId == null) {
        throw Exception('User ID not found. Please login again.');
      }

      await _fetchStats(userId);

      final response = await _bookingService.getInstantBookings(
        userId: userId,
        status: null,
      );

      setState(() {
        _allBookings = response.data;
        _applyFilter();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _fetchStats(int userId) async {
    try {
      final response = await _bookingService.getInstantStats(userId: userId);
      setState(() {
        _stats = response.data;
      });
    } catch (e) {
      print('Stats fetch error: $e');
    }
  }

  Future<void> _refreshStats() async {
    try {
      final userData = await AppPreferences.getUser();
      final userId = userData?['id'] as int?;
      if (userId != null) {
        await _fetchStats(userId);
      }
    } catch (e) {
      print('Stats refresh error: $e');
    }
  }

  void _applyFilter() {
    if (_selectedStatus == null) {
      _displayedBookings = List.from(_allBookings);
    } else {
      _displayedBookings = _allBookings.where((b) => b.status == _selectedStatus).toList();
    }
    setState(() {});
  }

  Map<String, int> _getStatusCounts() {
    return {
      'pending': int.tryParse(_stats['pending']?.toString() ?? '0') ?? 0,
      'assign': int.tryParse(_stats['assign']?.toString() ?? '0') ?? 0,
      'in_progress': int.tryParse(_stats['in_progress']?.toString() ?? '0') ?? 0,
      'completed': int.tryParse(_stats['completed']?.toString() ?? '0') ?? 0,
      'cancelled': int.tryParse(_stats['cancelled']?.toString() ?? '0') ?? 0,
    };
  }

  // ================== SKELETON CARD (card-shaped) ==================
  Widget _buildSkeletonCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon/avatar skeleton
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + status skeleton
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 14,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 60,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Location skeleton
                      Container(
                        height: 10,
                        width: 120,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 4),
                      // Date skeleton
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 8),
                      // Description skeleton
                      Container(
                        height: 10,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 10,
                        width: 150,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                ),
                // Right side placeholder (avatar + rating)
                const SizedBox(width: 12),
                Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 40,
                      height: 8,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 2),
                    Container(
                      width: 30,
                      height: 8,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Footer skeleton
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xffF1F3F5), width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 10,
                  width: 80,
                  color: Colors.grey.shade300,
                ),
                Container(
                  height: 10,
                  width: 60,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================== SKELETON LIST ==================
  Widget _buildSkeletonList() {
    return Column(
      children: List.generate(3, (index) => _buildSkeletonCard()),
    );
  }

  // ================== BUILD ==================
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
              _buildHeader(),
              const SizedBox(height: 16),
              _buildBookingTypeTabs(),
              const SizedBox(height: 16),
              _buildStatusFilters(),
              const SizedBox(height: 20),
              instantSelected ? _buildInstantList() : _buildStaticAdvanceList(),
            ],
          ),
        ),
      ),
    );
  }

  // ================== HEADER ==================
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Requests',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff1A1A2E)),
            ),
            SizedBox(height: 4),
            Text(
              'Track all your service requests in one place.',
              style: TextStyle(fontSize: 10, color: Color(0xff6C757D)),
            ),
          ],
        ),
      ],
    );
  }

  // ================== BOOKING TYPE TABS ==================
  Widget _buildBookingTypeTabs() {
    return Column(
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
                        _refreshStats();
                        _fetchStatsAndBookings();
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
    );
  }

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
          border: Border.all(color: selected ? AppColors.navy : const Color(0xffEFF1F4), width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? Colors.white : const Color(0xffA0AEC0), size: 18),
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

  // ================== STATUS FILTERS ==================
  Widget _buildStatusFilters() {
    final counts = _getStatusCounts();
    final total = _stats['total'] ?? 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                  '$total',
                  isSelected: _selectedStatus == null && instantSelected,
                  onTap: () {
                    if (instantSelected) {
                      setState(() {
                        _selectedStatus = null;
                        _applyFilter();
                      });
                    }
                  },
                  activeColor: AppColors.navy,
                ),
                _buildVerticalDivider(),
                _buildFilterChip(
                  'Pending',
                  '${counts['pending'] ?? 0}',
                  isSelected: _selectedStatus == 'pending' && instantSelected,
                  onTap: () {
                    if (instantSelected) {
                      setState(() {
                        _selectedStatus = 'pending';
                        _applyFilter();
                      });
                    }
                  },
                  countBg: const Color(0xffFFECC7),
                  countText: const Color(0xffFF9F00),
                ),
                _buildVerticalDivider(),
                _buildFilterChip(
                  'Assigned',
                  '${counts['assign'] ?? 0}',
                  isSelected: (_selectedStatus == 'assign' || _selectedStatus == 'assigned') && instantSelected,
                  onTap: () {
                    if (instantSelected) {
                      setState(() {
                        _selectedStatus = 'assign';
                        _applyFilter();
                      });
                    }
                  },
                  countBg: const Color(0xffE0EFFF),
                  countText: const Color(0xff007AFF),
                ),
                _buildVerticalDivider(),
                _buildFilterChip(
                  'In Progress',
                  '${counts['in_progress'] ?? 0}',
                  isSelected: _selectedStatus == 'in_progress' && instantSelected,
                  onTap: () {
                    if (instantSelected) {
                      setState(() {
                        _selectedStatus = 'in_progress';
                        _applyFilter();
                      });
                    }
                  },
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
                  '${counts['completed'] ?? 0}',
                  isSelected: _selectedStatus == 'completed' && instantSelected,
                  onTap: () {
                    if (instantSelected) {
                      setState(() {
                        _selectedStatus = 'completed';
                        _applyFilter();
                      });
                    }
                  },
                  countBg: const Color(0xffE2F6EA),
                  countText: const Color(0xff27AE60),
                ),
                const SizedBox(width: 16),
                _buildVerticalDivider(),
                const SizedBox(width: 16),
                _buildFilterChip(
                  'Cancelled',
                  '${counts['cancelled'] ?? 0}',
                  isSelected: _selectedStatus == 'cancelled' && instantSelected,
                  onTap: () {
                    if (instantSelected) {
                      setState(() {
                        _selectedStatus = 'cancelled';
                        _applyFilter();
                      });
                    }
                  },
                  countBg: const Color(0xffE9ECEF),
                  countText: const Color(0xff6C757D),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 8, vertical: 6)
            : const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? (activeColor ?? AppColors.navy) : Colors.transparent,
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
                color: isSelected ? Colors.white : (countBg ?? const Color(0xffE2E8F0)),
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
      ),
    );
  }

  // ================== INSTANT LIST (with shimmer) ==================
  Widget _buildInstantList() {
    if (_isLoading) {
      // Show shimmer skeleton
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: _buildSkeletonList(),
      );
    }

    if (_displayedBookings.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: Text(
            'No bookings found for this status.',
            style: TextStyle(color: Color(0xff6C757D)),
          ),
        ),
      );
    }

    return Column(
      children: _displayedBookings.map((booking) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildRequestCardFromBooking(booking),
        );
      }).toList(),
    );
  }

  // ================== STATIC ADVANCE LIST ==================
  Widget _buildStaticAdvanceList() {
    return Column(
      children: [
        _buildStaticRequestCard(
          title: 'Electrical Wiring Repair',
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
        _buildStaticRequestCard(
          title: 'Plumbing Issue',
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
              const Icon(LucideIcons.clock, color: AppColors.navy, size: 15),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Looking for professionals...',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Text(
                      "We'll notify you soon",
                      style: TextStyle(fontSize: 11, color: Color(0xff6C757D)),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xffA0AEC0)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildStaticRequestCard(
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
        _buildStaticRequestCard(
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
        _buildStaticRequestCard(
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
                      style: TextStyle(fontSize: 12, color: Color(0xff6C757D)),
                    ),
                    Text(
                      '28 Jun 2025',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
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
    );
  }

  // ================== DYNAMIC CARD ==================
  Widget _buildRequestCardFromBooking(Booking booking) {
    IconData getIcon(String category) {
      switch (category.toLowerCase()) {
        case 'electrician':
          return LucideIcons.zap;
        case 'plumber':
          return LucideIcons.pipette;
        case 'ac repair':
        case 'air conditioner':
          return LucideIcons.airplay;
        case 'carpenter':
          return LucideIcons.hammer;
        case 'painter':
          return LucideIcons.paintBucket;
        default:
          return LucideIcons.wrench;
      }
    }

    Map<String, dynamic> getStatusStyle(String status) {
      switch (status.toLowerCase()) {
        case 'pending':
          return {'bg': const Color(0xffFFECC7), 'text': const Color(0xffFF9F00), 'label': 'Pending'};
        case 'assign':
        case 'assigned':
          return {'bg': const Color(0xffE0EFFF), 'text': const Color(0xff007AFF), 'label': 'Assigned'};
        case 'in_progress':
        case 'in progress':
          return {'bg': const Color(0xffEAE4FF), 'text': AppColors.navy, 'label': 'In Progress'};
        case 'completed':
          return {'bg': const Color(0xffE2F6EA), 'text': const Color(0xff27AE60), 'label': 'Completed'};
        case 'cancelled':
          return {'bg': const Color(0xffE9ECEF), 'text': const Color(0xff6C757D), 'label': 'Cancelled'};
        default:
          return {'bg': Colors.grey.shade200, 'text': Colors.grey, 'label': status};
      }
    }

    final statusStyle = getStatusStyle(booking.status);
    final icon = getIcon(booking.categoryName);

    final dateStr = _formatDate(booking.preferredDate);
    final timeStr = _formatTime(booking.preferredTime);
    final dateTimeDisplay = '$dateStr  •  $timeStr';

    Widget? rightWidget;
    if (booking.vendorId != null && booking.vendorName != null) {
      rightWidget = Row(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://i.imgur.com/8Km9tLL.png',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xffCBD5E0),
                    child: Icon(LucideIcons.user, size: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 50,
                child: Text(
                  booking.vendorName!.length > 10
                      ? '${booking.vendorName!.substring(0, 8)}...'
                      : booking.vendorName!,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1A1A2E),
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.amber, size: 12),
                  SizedBox(width: 2),
                  Text('4.5', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: Color(0xffA0AEC0)),
        ],
      );
    } else if (booking.status.toLowerCase() == 'pending') {
      rightWidget = Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Looking for professionals...',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text(
                  "We'll notify you soon",
                  style: TextStyle(fontSize: 11, color: Color(0xff6C757D)),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xffA0AEC0)),
        ],
      );
    }

    Widget actionWidget;
    if (booking.status.toLowerCase() == 'pending') {
      actionWidget = _buildViewDetailsButton();
    } else if (booking.status.toLowerCase() == 'assigned' ||
        booking.status.toLowerCase() == 'in_progress') {
      actionWidget = _buildChatButton();
    } else if (booking.status.toLowerCase() == 'completed') {
      actionWidget = TextButton(
        onPressed: () {},
        child: const Text(
          'Rate Now',
          style: TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold, fontSize: 10),
        ),
      );
    } else {
      actionWidget = _buildViewDetailsButton();
    }

    String footerText = '';
    switch (booking.status.toLowerCase()) {
      case 'pending':
        footerText = '0 Quotes Yet';
        break;
      case 'assigned':
        footerText = '1 Quote Received';
        break;
      case 'in_progress':
        footerText = 'Work in Progress';
        break;
      case 'completed':
        footerText = 'Completed on ${_formatDate(booking.updatedAt)}';
        break;
      default:
        footerText = '';
    }

    return _buildStaticRequestCard(
      title: booking.categoryName,
      location: booking.locationAddress,
      dateTime: dateTimeDisplay,
      description: booking.description,
      reqId: 'REQ${booking.id}',
      statusText: statusStyle['label'] as String,
      statusBg: statusStyle['bg'] as Color,
      statusTextColor: statusStyle['text'] as Color,
      icon: icon,
      iconColor: statusStyle['text'] as Color,
      iconBg: (statusStyle['bg'] as Color).withOpacity(0.3),
      footerLeftText: footerText,
      actionWidget: actionWidget,
      providerName: booking.vendorName,
      providerRating: '4.5',
      providerImage: 'https://i.imgur.com/8Km9tLL.png',
      middleWidget: rightWidget,
    );
  }

  // ================== STATIC REQUEST CARD BUILDER ==================
  Widget _buildStaticRequestCard({
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
                              Expanded(
                                child: Text(
                                  location,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xff718096),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                              Expanded(
                                child: Text(
                                  dateTime,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    color: Color(0xff718096),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
                              SizedBox(
                                width: 50,
                                child: Text(
                                  providerName.length > 10
                                      ? '${providerName.substring(0, 8)}...'
                                      : providerName,
                                  style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1A1A2E),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
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
          // Footer
         
        ],
      ),
    );
  }

  // ================== ACTION WIDGETS ==================
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