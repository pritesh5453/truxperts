import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:truxperts/screens/Requests/payment_method_screen.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';
class RequestTrackingScreen extends StatelessWidget {
  const RequestTrackingScreen({Key? key}) : super(key: key);

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
              _buildBriefJobSummaryCard(),
              const SizedBox(height: 16),
              _buildServiceOtpCard(),
              const SizedBox(height: 16),
              _buildVendorAssignmentCard(),
              const SizedBox(height: 16),
              _buildLiveLocationMapCard(),
              const SizedBox(height: 16),
              _buildRequestStatusTracker(),
              const SizedBox(height: 16),
              _buildRequestDetailsGrid(),
              const SizedBox(height: 24),
              _buildBottomActionButtons(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // --- 1. Top Brief Job Summary Card ---
  Widget _buildBriefJobSummaryCard() {
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
                    const Text(
                      'Electrical Wiring Repair',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13, // reduced from 16
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
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Assigned',
                        style: TextStyle(
                          color: AppColors.blueAccent,
                          fontSize: 8, // reduced from 10
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Icon(
                          LucideIcons.calendar,
                          size: 14,
                          color: AppColors.hintText,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '08 Jul 2025  •  04:30 PM',
                          style: TextStyle(
                            fontSize: 10, // reduced from 12
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Need wiring repair in 2BHK flat.',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textDark,
                      ), // reduced from 12
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
                    fontSize: 8, // reduced from 10
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

  // --- OTP Verification Card ---
  Widget _buildServiceOtpCard() {
    final List<String> otpDigits = ['7', '2', '8', '4', '6', '1'];

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
          // Top Header: Text and Shield Icon
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
              // Graphic Shield Badge
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

          // Inner Gray OTP Box Container
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

                // OTP Digits Display
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

  // --- 2. Vendor Assignment Card ---
  Widget _buildVendorAssignmentCard() {
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
          const Text(
            'Your request has been assigned to',
            style: TextStyle(
              fontSize: 10, // reduced from 12
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/32.jpg',
                    ),
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
                      child: const Icon(
                        Icons.check_circle,
                        color: AppColors.navy,
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
                      children: const [
                        Text(
                          'Amit Electricals',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12, // reduced from 15
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.verified, color: AppColors.navy, size: 16),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.star, color: AppColors.star, size: 14),
                        SizedBox(width: 2),
                        Text(
                          '4.7',
                          style: TextStyle(
                            fontSize: 10, // reduced from 12
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '(128 Reviews)',
                          style: TextStyle(
                            fontSize: 9, // reduced from 11
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(
                          LucideIcons.phone,
                          size: 12,
                          color: AppColors.textGrey,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '+91 xxxxxxxxxx',
                          style: TextStyle(
                            fontSize: 10, // reduced from 12
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
                      fontSize: 8, // reduced from 10
                      color: AppColors.hintText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '18 min',
                    style: TextStyle(
                      fontSize: 14, // reduced from 18
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
                    ), // reduced from 9
                  ),
                  const Text(
                    '1.2 km',
                    style: TextStyle(
                      fontSize: 9, // reduced from 11
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
                      fontSize: 12, // added explicit size
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
                  onPressed: () {},
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
                      fontSize: 12, // added explicit size
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

  // --- 3. Live Location Map Card ---
  Widget _buildLiveLocationMapCard() {
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
                        fontSize: 10, // reduced from 13
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
                    const Text(
                      'Amit is on the way',
                      style: TextStyle(
                        fontSize: 9,
                        color: AppColors.textGrey,
                      ), // reduced from 11
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
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
                          fontSize: 10, // reduced from 12
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
                        child: const Text(
                          'Your Location\nKothrud, Pune',
                          style: TextStyle(
                            fontSize: 6, // reduced from 8
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
                        child: const Text(
                          'Vendor Location\n18 min away',
                          style: TextStyle(
                            fontSize: 6, // reduced from 8
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Icon(
                        Icons.motorcycle,
                        color: AppColors.orange,
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

  // --- 4. Request Status Timeline Tracker ---
  Widget _buildRequestStatusTracker() {
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
                  fontSize: 11, // reduced from 14
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimelineStep(
                'Request\nPlaced',
                '08 Jul, 04:30 PM',
                LucideIcons.fileText,
                isCompleted: true,
              ),
              _buildTimelineDivider(isSolid: true),
              _buildTimelineStep(
                'Assigned',
                '08 Jul, 04:35 PM',
                LucideIcons.users,
                isCompleted: true,
              ),
              _buildTimelineDivider(isSolid: true),
              _buildTimelineStep(
                'Vendor on\nthe Way',
                '08 Jul, 04:40 PM',
                LucideIcons.bike,
                isCompleted: true,
                isActive: true,
              ),
              _buildTimelineDivider(isSolid: false),
              _buildTimelineStep(
                'In Progress',
                '--',
                LucideIcons.wrench,
                isCompleted: false,
              ),
              _buildTimelineDivider(isSolid: false),
              _buildTimelineStep(
                'Completed',
                '--',
                LucideIcons.checkSquare,
                isCompleted: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(
    String title,
    String time,
    IconData icon, {
    bool isCompleted = false,
    bool isActive = false,
  }) {
    Color primaryColor = isCompleted ? AppColors.navy : AppColors.hintText;
    return Expanded(
      child: Column(
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
              fontSize: 7, // reduced from 9
              fontWeight: isCompleted ? FontWeight.bold : FontWeight.w500,
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
            ), // reduced from 8
          ),
        ],
      ),
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

  // --- 5. Request Details Grid Section ---
  Widget _buildRequestDetailsGrid() {
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
                  fontSize: 11, // reduced from 14
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildDetailItem(LucideIcons.zap, 'Category', 'Electrician'),
              const SizedBox(width: 12),
              _buildDetailItem(
                LucideIcons.mapPin,
                'Location',
                'Kothrud, Pune, Maharashtra',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildDetailItem(
                LucideIcons.calendar,
                'Preferred Time',
                '08 Jul 2025, 4:30 PM',
              ),
              const SizedBox(width: 12),
              _buildDetailItem(
                LucideIcons.creditCard,
                'Payment',
                'Cash on Completion',
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
                      fontSize: 8, // reduced from 10
                      color: AppColors.hintText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 9, // reduced from 11
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

  // --- 6. Action Bottom Buttons Row ---
  Widget _buildBottomActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(LucideIcons.xCircle, size: 16, color: Colors.red),
            label: const Text(
              'Cancel Request',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 10, // reduced from 13
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
        const SizedBox(width: 12),
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
                fontSize: 10, // reduced from 13
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
}
