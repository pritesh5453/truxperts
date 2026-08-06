import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:shimmer/shimmer.dart'; // ✅ Shimmer import
import 'package:truxperts/Model_n_svc/cancel_request/cancel_request_model.dart';
import 'package:truxperts/Model_n_svc/cancel_request/cancel_svc.dart';
import 'package:truxperts/Model_n_svc/tracking/tracking_model.dart';
import 'package:truxperts/Model_n_svc/tracking/tracking_svc.dart';
import 'package:truxperts/Customer/screen/Requests/payment_method_screen.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

class RequestTrackingScreen extends StatefulWidget {
  final int bookingId;
  final int userId;

  const RequestTrackingScreen({
    Key? key,
    required this.bookingId,
    required this.userId,
  }) : super(key: key);

  @override
  State<RequestTrackingScreen> createState() => _RequestTrackingScreenState();
}

class _RequestTrackingScreenState extends State<RequestTrackingScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  TrackingData? _trackingData;

  late final AnimationController _searchAnimController;

  @override
  void initState() {
    super.initState();
    _fetchTrackingData();
    _searchAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _searchAnimController.dispose();
    super.dispose();
  }

  Future<void> _fetchTrackingData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
      final service = InstantTrackingService(dio);
      final response = await service.fetchTracking(
        bookingId: widget.bookingId,
        userId: widget.userId,
      );

      if (response.success) {
        setState(() {
          _trackingData = response.data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = response.message;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = e.toString();
      });
    }
  }

  // ================== STATUS HELPERS ==================
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.warningBg;
      case 'assigned':
        return AppColors.lightBlue;
      case 'ontheway':
      case 'in_progress':
        return AppColors.lightPurple;
      case 'completed':
        return AppColors.successBg;
      case 'cancelled':
        return AppColors.errorBg;
      default:
        return AppColors.warningBg;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.warningText;
      case 'assigned':
        return AppColors.blueAccent;
      case 'ontheway':
      case 'in_progress':
        return AppColors.navy;
      case 'completed':
        return AppColors.successText;
      case 'cancelled':
        return AppColors.errorText;
      default:
        return AppColors.warningText;
    }
  }

  String _getStatusDisplay(String status) {
    switch (status.toLowerCase()) {
      case 'ontheway':
        return 'On The Way';
      case 'in_progress':
        return 'In Progress';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_getMonth(date.month)}, ${date.year}';
  }

  String _getMonth(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  // ================== SKELETON WIDGETS ==================
  Widget _buildSkeletonContent() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSkeletonJobSummaryCard(),
            const SizedBox(height: 16),
            _buildSkeletonVendorCard(),
            const SizedBox(height: 16),
            _buildSkeletonStatusTracker(),
            const SizedBox(height: 16),
            _buildSkeletonRequestDetails(),
            const SizedBox(height: 24),
            _buildSkeletonActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonJobSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 6),
                Container(
                  height: 18,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 10,
                  width: 120,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 6),
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
        ],
      ),
    );
  }

  Widget _buildSkeletonVendorCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 10,
            width: 120,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12,
                      width: 100,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 80,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 120,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 8,
                    width: 30,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 14,
                    width: 40,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonStatusTracker() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 12,
            width: 100,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              return Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 8,
                    width: 40,
                    color: Colors.grey.shade300,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonRequestDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 12,
            width: 100,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonActionButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  // ================== BUILD ==================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: CommonAppBar(),
      body: _isLoading
          ? _buildSkeletonContent() // ✅ Skeleton with shimmer
          : _hasError
              ? _buildErrorState()
              : _buildContent(),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: AppColors.textSecondary),
          const SizedBox(height: 12),
          Text(
            'Failed to load tracking details',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _errorMessage,
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _fetchTrackingData,
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

  Widget _buildContent() {
    final data = _trackingData!;
    final actions = data.actions;
    final vendor = data.vendor;
    final otp = data.serviceOtp;
    final bool isCancelled = data.status.toLowerCase() == 'cancelled';
    final bool isPending = data.status.toLowerCase() == 'pending';

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBriefJobSummaryCard(data),
            const SizedBox(height: 16),

            // 🔍 If pending, show the "Searching for Vendor" animation
            if (isPending) ...[
              _buildSearchingVendorCard(),
              const SizedBox(height: 16),
            ],

            // ✅ If cancelled, show cancellation message and skip all other sections
            if (isCancelled) ...[
              _buildCancelledMessage(),
              const SizedBox(height: 16),
            ],

            // OTP Card – show only if showServiceOtp is true AND not cancelled
            if (!isCancelled && actions.showServiceOtp)
              _buildServiceOtpCard(otp.otp),

            if (!isCancelled && actions.showServiceOtp) const SizedBox(height: 16),

            // Vendor Card – show only if showVendor is true AND not cancelled
            if (!isCancelled && actions.showVendor && vendor != null)
              _buildVendorAssignmentCard(vendor),

            if (!isCancelled && actions.showVendor && vendor != null) const SizedBox(height: 16),

            // Live Location – show only if showLiveLocation is true AND not cancelled
            if (!isCancelled && actions.showLiveLocation)
              _buildLiveLocationMapCard(data),

            if (!isCancelled && actions.showLiveLocation) const SizedBox(height: 16),

            // Status Tracker (always show, but timeline will show cancellation)
            _buildRequestStatusTracker(data.timeline),
            const SizedBox(height: 16),

            // Request Details
            _buildRequestDetailsGrid(data.requestDetails),
            const SizedBox(height: 24),

            // Action Buttons – only if not cancelled
            if (!isCancelled)
              _buildBottomActionButtons(
                showCancel: actions.showCancelButton,
                showMarkDone: actions.showMarkDoneButton,
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ================== SEARCHING FOR VENDOR ==================
  Widget _buildSearchingVendorCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 110,
            width: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double a = math.min(constraints.maxWidth / 2 - 30, 90);
                const double b = 30;

                return AnimatedBuilder(
                  animation: _searchAnimController,
                  builder: (context, child) {
                    final double t = _searchAnimController.value * 2 * math.pi;
                    final double sinT = math.sin(t);
                    final double cosT = math.cos(t);
                    final double denom = 1 + (sinT * sinT);
                    final double x = a * cosT / denom;
                    final double y = b * sinT * cosT / denom;

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.translate(
                          offset: Offset(x, y),
                          child: Image.asset(
                            'assets/icons/magnifying_glass.png',
                            width: 150,
                            height: 150,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Searching for Vendor',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Please wait while we find the best vendor for you',
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ================== CANCELLED MESSAGE ==================
  Widget _buildCancelledMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.errorBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.errorText.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.cancel, color: AppColors.errorText, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Request Cancelled',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.errorText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'This request has been cancelled and is no longer active.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================== BRIEF JOB SUMMARY ==================
  Widget _buildBriefJobSummaryCard(TrackingData data) {
    final summary = data.jobSummary;
    final statusDisplay = _getStatusDisplay(data.status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: AppColors.lightPurple,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  LucideIcons.zap,
                  color: AppColors.navy,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      summary.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(data.status),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        statusDisplay.toUpperCase(),
                        style: TextStyle(
                          color: _getStatusTextColor(data.status),
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          LucideIcons.calendar,
                          size: 14,
                          color: AppColors.hintText,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${_formatDate(summary.bookingDate)}  •  ${summary.bookingTime}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      summary.description,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  LucideIcons.headphones,
                  size: 12,
                  color: AppColors.navy,
                ),
                label: const Text(
                  'Need Help?',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.borderLight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================== OTP CARD ==================
  Widget _buildServiceOtpCard(String otp) {
    final List<String> otpDigits = otp.split('');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Service OTP Verification',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Share this OTP only with your assigned vendor to start the service.',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textGrey,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 60,
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.navy.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.shield_outlined,
                        size: 38,
                        color: AppColors.navy,
                      ),
                    ),
                    const Icon(
                      Icons.lock_rounded,
                      size: 18,
                      color: AppColors.navy,
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          size: 18,
                          color: Color(0xFF22C55E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.cardBg.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Column(
              children: [
                const Text(
                  'Your Service OTP',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: otpDigits.map((digit) {
                    return Container(
                      width: 38,
                      height: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Text(
                        digit,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================== VENDOR ASSIGNMENT CARD ==================
  Widget _buildVendorAssignmentCard(VendorInfo vendor) {
    final eta = vendor.etaMinutes != null ? '${vendor.etaMinutes} min' : 'N/A';
    final distance = vendor.distanceKm != null ? '${vendor.distanceKm} km' : 'N/A';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your request has been assigned to',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: vendor.profileImage.isNotEmpty
                        ? NetworkImage(vendor.profileImage)
                        : const NetworkImage('https://randomuser.me/api/portraits/men/32.jpg') as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        vendor.verified ? Icons.check_circle : Icons.circle,
                        color: vendor.verified ? AppColors.navy : Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          vendor.businessName.isNotEmpty ? vendor.businessName : vendor.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (vendor.verified) ...[
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, color: AppColors.navy, size: 16),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppColors.star, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          vendor.rating > 0 ? vendor.rating.toString() : 'New',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (vendor.reviews > 0) ...[
                          const SizedBox(width: 4),
                          Text(
                            '(${vendor.reviews} Reviews)',
                            style: const TextStyle(
                              fontSize: 9,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          LucideIcons.phone,
                          size: 12,
                          color: AppColors.textGrey,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          vendor.mobile.isNotEmpty ? vendor.mobile : '+91 xxxxxxxxxx',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'ETA',
                    style: TextStyle(
                      fontSize: 8,
                      color: AppColors.hintText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    eta,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navy,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Distance from you',
                    style: TextStyle(
                      fontSize: 7,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Text(
                    distance,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    LucideIcons.messageSquare,
                    size: 16,
                    color: AppColors.navy,
                  ),
                  label: const Text(
                    'Chat',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.navy),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Make phone call
                  },
                  icon: const Icon(
                    LucideIcons.phone,
                    size: 16,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Call',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.navy,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================== LIVE LOCATION ==================
  Widget _buildLiveLocationMapCard(TrackingData data) {
    final location = data.liveLocation;
    final status = data.status.toLowerCase();

    String statusText = 'Awaiting vendor assignment';
    if (status == 'assigned') {
      statusText = 'Vendor is on the way';
    } else if (status == 'ontheway' || status == 'in_progress') {
      statusText = 'Vendor is working';
    } else if (status == 'completed') {
      statusText = 'Service completed';
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Live Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      statusText,
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: _fetchTrackingData,
                  child: Row(
                    children: const [
                      Icon(
                        LucideIcons.refreshCw,
                        size: 12,
                        color: AppColors.navy,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Refresh',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.navy,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://i.imgur.com/WbX2eW0.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.blur_linear,
                    color: AppColors.navy.withOpacity(0.5),
                    size: 100,
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 40,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4),
                          ],
                        ),
                        child: Text(
                          'Your Location\n${data.requestDetails.location}',
                          style: const TextStyle(
                            fontSize: 6,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Icon(
                        Icons.location_on,
                        color: AppColors.navy,
                        size: 28,
                      ),
                    ],
                  ),
                ),
                if (location != null && status != 'pending' && status != 'cancelled')
                  Positioned(
                    top: 70,
                    right: 60,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 4),
                            ],
                          ),
                          child: Text(
                            status == 'completed'
                                ? 'Service Completed'
                                : 'Vendor Location\n${_trackingData?.vendor?.etaMinutes ?? ''} min away',
                            style: const TextStyle(
                              fontSize: 6,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Icon(
                          status == 'completed' ? Icons.check_circle : Icons.motorcycle,
                          color: status == 'completed' ? Colors.green : AppColors.orange,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================== STATUS TRACKER ==================
  Widget _buildRequestStatusTracker(List<TimelineItem> timeline) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Request Status',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: timeline.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final bool isLast = index == timeline.length - 1;

              return Expanded(
                child: Column(
                  children: [
                    _buildTimelineStep(
                      item.title,
                      item.completed ? 'Completed' : '--',
                      _getTimelineIcon(item.title),
                      isCompleted: item.completed,
                      isActive: item.active,
                    ),
                    if (!isLast)
                      _buildTimelineDivider(
                        isSolid: timeline[index + 1].completed,
                      ),
                  ],
                ),
              );
            }).toList().expand((widget) => [widget]).toList(),
          ),
        ],
      ),
    );
  }

  IconData _getTimelineIcon(String title) {
    final lower = title.toLowerCase();
    if (lower.contains('placed') || lower.contains('request')) {
      return LucideIcons.fileText;
    } else if (lower.contains('assign')) {
      return LucideIcons.users;
    } else if (lower.contains('vendor') || lower.contains('way')) {
      return LucideIcons.bike;
    } else if (lower.contains('progress')) {
      return LucideIcons.wrench;
    } else if (lower.contains('complete')) {
      return LucideIcons.checkSquare;
    }
    return LucideIcons.circle;
  }

  Widget _buildTimelineStep(
    String title,
    String time,
    IconData icon, {
    bool isCompleted = false,
    bool isActive = false,
  }) {
    Color primaryColor = isCompleted || isActive ? AppColors.navy : AppColors.hintText;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.navy
                : (isCompleted
                    ? AppColors.lightPurple
                    : AppColors.chipUnselected),
            shape: BoxShape.circle,
            border: Border.all(color: primaryColor, width: isActive ? 2 : 1),
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.white : primaryColor,
            size: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 7,
            fontWeight: isCompleted || isActive ? FontWeight.bold : FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 6,
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineDivider({required bool isSolid}) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: 24,
      child: Row(
        children: List.generate(
          4,
          (index) => Expanded(
            child: Container(
              height: 1.5,
              color: isSolid ? AppColors.navy : AppColors.borderLight,
              margin: const EdgeInsets.symmetric(horizontal: 1),
            ),
          ),
        ),
      ),
    );
  }

  // ================== REQUEST DETAILS ==================
  Widget _buildRequestDetailsGrid(RequestDetails details) {
    final paymentMethod = details.paymentMethod == 'full' ? 'Cash on Completion' : 'Advance Payment';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Request Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildDetailItem(LucideIcons.zap, 'Category', details.category),
              const SizedBox(width: 12),
              _buildDetailItem(
                LucideIcons.mapPin,
                'Location',
                details.location,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildDetailItem(
                LucideIcons.calendar,
                'Preferred Time',
                details.preferredTime,
              ),
              const SizedBox(width: 12),
              _buildDetailItem(
                LucideIcons.creditCard,
                'Payment',
                paymentMethod,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.chipUnselected),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 16, color: AppColors.navy),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 8,
                      color: AppColors.hintText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                    maxLines: 2,
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

  // ================== ACTION BUTTONS ==================
  Widget _buildBottomActionButtons({
    required bool showCancel,
    required bool showMarkDone,
  }) {
    if (!showCancel && !showMarkDone) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        if (showCancel)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _showCancelDialog(context),
              icon: const Icon(LucideIcons.xCircle, size: 16, color: Colors.red),
              label: const Text(
                'Cancel Request',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.borderLight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.white,
              ),
            ),
          ),

        if (showCancel && showMarkDone) const SizedBox(width: 12),

        if (showMarkDone)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServicePaymentScreen()),
                );
              },
              icon: const Icon(
                LucideIcons.checkCircle,
                size: 16,
                color: Colors.white,
              ),
              label: const Text(
                'Mark as Done',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navy,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
      ],
    );
  }

  // ================== CANCEL DIALOG ==================
  void _showCancelDialog(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Request'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please tell us why you want to cancel this request:',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(
                hintText: 'e.g. Changed my mind',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('No, Go Back'),
          ),
          TextButton(
            onPressed: () async {
              final reason = reasonController.text.trim();
              if (reason.isEmpty) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a cancellation reason'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              Navigator.pop(ctx);
              setState(() => _isLoading = true);

              try {
                final dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
                final service = CancelBookingService(dio);

                final request = CancelBookingRequest(
                  userId: widget.userId,
                  cancellationReason: reason,
                );

                await service.cancelBooking(
                  bookingId: widget.bookingId,
                  request: request,
                );

                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Request cancelled successfully'),
                    backgroundColor: Colors.green,
                  ),
                );

                await _fetchTrackingData();
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error cancelling: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              } finally {
                if (mounted) setState(() => _isLoading = false);
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Yes, Cancel Request'),
          ),
        ],
      ),
    );
  }
}

// ================== INFINITY TRACK PAINTER ==================
class _InfinityTrackPainter extends CustomPainter {
  final double a;
  final double b;

  _InfinityTrackPainter({required this.a, required this.b});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = AppColors.navy.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    const int steps = 200;
    for (int i = 0; i <= steps; i++) {
      final double t = (i / steps) * 2 * math.pi;
      final double sinT = math.sin(t);
      final double cosT = math.cos(t);
      final double denom = 1 + (sinT * sinT);
      final double x = a * cosT / denom;
      final double y = b * sinT * cosT / denom;
      final Offset point = center + Offset(x, y);
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _InfinityTrackPainter oldDelegate) {
    return oldDelegate.a != a || oldDelegate.b != b;
  }
}