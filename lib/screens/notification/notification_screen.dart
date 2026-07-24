import 'package:flutter/material.dart';
import 'package:truxperts/utils/appcolors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationItem {
  final IconData icon;
  final Color iconBg;
  final Color iconFg;
  final String title;
  final String subtitle;
  final String time;
  bool unread;
  final String category;

  _NotificationItem({
    required this.icon,
    required this.iconBg,
    required this.iconFg,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.unread,
    required this.category,
  });
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Bookings', 'Offers', 'Updates', 'Chats'];

  final List<_NotificationItem> _notifications = [
    _NotificationItem(
      icon: Icons.assignment_turned_in_rounded,
      iconBg: AppColors.lightBlue,
      iconFg: AppColors.blueAccent,
      title: 'Booking Confirmed',
      subtitle:
          'Your booking for AC Repair has been confirmed. Expert will visit today between 2:00 PM - 4:00 PM.',
      time: '2m ago',
      unread: true,
      category: 'Bookings',
    ),
    _NotificationItem(
      icon: Icons.delivery_dining_rounded,
      iconBg: AppColors.lightPurple,
      iconFg: AppColors.primaryPurple,
      title: 'Order On The Way',
      subtitle:
          'Your medicine order is on the way and will be delivered in 20 minutes.',
      time: '15m ago',
      unread: true,
      category: 'Updates',
    ),
    _NotificationItem(
      icon: Icons.chat_bubble_rounded,
      iconBg: AppColors.iconElectricianBg,
      iconFg: AppColors.iconElectricianFg,
      title: 'New Message',
      subtitle: 'You have a new message from Rakesh (Electrician).',
      time: '1h ago',
      unread: true,
      category: 'Chats',
    ),
    _NotificationItem(
      icon: Icons.local_offer_rounded,
      iconBg: AppColors.iconCateringBg,
      iconFg: AppColors.iconCateringFg,
      title: 'Special Offer!',
      subtitle: 'Get 20% OFF on your first AC servicing. Use code: TRUX20',
      time: '3h ago',
      unread: true,
      category: 'Offers',
    ),
    _NotificationItem(
      icon: Icons.notifications_active_rounded,
      iconBg: AppColors.iconPlumberBg,
      iconFg: AppColors.iconPlumberFg,
      title: 'Service Reminder',
      subtitle:
          'Reminder: Your plumbing service is scheduled for tomorrow at 11:00 AM.',
      time: '5h ago',
      unread: true,
      category: 'Bookings',
    ),
    _NotificationItem(
      icon: Icons.account_balance_wallet_rounded,
      iconBg: AppColors.pink,
      iconFg: AppColors.orange,
      title: 'Payment Successful',
      subtitle: 'Your payment of ₹750 for AC Repair was successful.',
      time: 'Yesterday',
      unread: false,
      category: 'Updates',
    ),
    _NotificationItem(
      icon: Icons.star_border_rounded,
      iconBg: AppColors.lightBlue,
      iconFg: AppColors.blueAccent,
      title: 'Rate Your Experience',
      subtitle: 'How was your experience with Suresh (Plumber)?',
      time: 'Yesterday',
      unread: false,
      category: 'Updates',
    ),
    _NotificationItem(
      icon: Icons.card_giftcard_rounded,
      iconBg: AppColors.iconCateringBg,
      iconFg: AppColors.iconCateringFg,
      title: 'Welcome to TruXperts!',
      subtitle: 'Thanks for joining us. Explore services and book your first service now.',
      time: '2 days ago',
      unread: false,
      category: 'Updates',
    ),
  ];

  void _markAllAsRead() {
    setState(() {
      for (final n in _notifications) {
        n.unread = false;
      }
    });
  }

  List<_NotificationItem> get _filteredList {
    if (_selectedFilter == 'All') return _notifications;
    return _notifications.where((n) => n.category == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldLightBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 14),
            _buildFilterChips(),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: [
                  ..._filteredList.map((n) => _NotificationTile(item: n)),
                  const SizedBox(height: 8),
                  _EnablePushBanner(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 16, 0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              'Notifications',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          InkWell(
            onTap: _markAllAsRead,
            child: Row(
              children: [
                Text(
                  'Mark all as read',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryPurple,
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = filter == _selectedFilter;
          return InkWell(
            onTap: () => setState(() => _selectedFilter = filter),
            borderRadius: BorderRadius.circular(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.navy : AppColors.chipUnselected,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                filter,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final _NotificationItem item;
  const _NotificationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: item.unread ? AppColors.lightBlue.withOpacity(0.5) : AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: item.unread ? Colors.transparent : AppColors.cardBorder,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: item.iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: item.iconFg, size: 19),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.time,
                style: TextStyle(fontSize: 10.5, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              if (item.unread)
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EnablePushBanner extends StatelessWidget {
  const _EnablePushBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.lightBlue.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.blueAccent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.notifications_rounded,
                    color: AppColors.blueAccent, size: 20),
              ),
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                  child: const Text(
                    '1',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
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
                Text(
                  'Enable Push Notifications',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Stay updated with real-time alerts and important updates.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              // TODO: system push notification permission request yaha call karo
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.navy,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              elevation: 0,
            ),
            child: const Text(
              'Enable',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}