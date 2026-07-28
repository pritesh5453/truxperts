import 'package:flutter/material.dart';
import 'package:truxperts/screens/chat/chatting_screen.dart';
import 'package:truxperts/utils/appcolors.dart';
import 'package:truxperts/utils/common_appbar.dart';

/// Simple model for a chat/contact entry.
class ChatContact {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final String? avatarUrl;

  ChatContact({
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
    this.avatarUrl,
  });
}

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  final List<ChatContact> _allContacts = [
    ChatContact(
      name: 'Rajesh Transport',
      lastMessage: 'Truck reached the loading point.',
      time: '09:41',
      unreadCount: 3,
      isOnline: true,
    ),
    ChatContact(
      name: 'Anita Singh',
      lastMessage: 'Please share the invoice copy.',
      time: '09:12',
      unreadCount: 0,
      isOnline: false,
    ),
    ChatContact(
      name: 'Delhi Logistics Hub',
      lastMessage: 'Booking confirmed for tomorrow.',
      time: 'Yesterday',
      unreadCount: 1,
      isOnline: true,
    ),
    ChatContact(
      name: 'Vikram Yadav',
      lastMessage: 'Ok, sending the POD now.',
      time: 'Yesterday',
      unreadCount: 0,
      isOnline: false,
    ),
    ChatContact(
      name: 'Support Team',
      lastMessage: 'Your ticket has been resolved.',
      time: 'Mon',
      unreadCount: 0,
      isOnline: true,
    ),
    ChatContact(
      name: 'Meena Traders',
      lastMessage: 'Rate kya final hua?',
      time: 'Mon',
      unreadCount: 5,
      isOnline: false,
    ),
  ];

  List<ChatContact> get _filteredContacts {
    if (_query.trim().isEmpty) return _allContacts;
    return _allContacts
        .where((c) =>
            c.name.toLowerCase().contains(_query.toLowerCase()) ||
            c.lastMessage.toLowerCase().contains(_query.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double horizontalPadding = mediaQuery.size.width * 0.05;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.fieldFill,
                AppColors.fieldFill.withOpacity(0.8),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: CommonAppBar(),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(horizontalPadding),
          Expanded(
            child: _filteredContacts.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    itemCount: _filteredContacts.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      thickness: 0.5,
                      indent: 80,
                      endIndent: horizontalPadding,
                      color: Colors.white.withOpacity(0.12),
                    ),
                    itemBuilder: (context, index) {
                      final contact = _filteredContacts[index];
                      return _ChatListTile(
                        contact: contact,
                        paddingHorizontal: horizontalPadding,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatScreen(contact: contact),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(double horizontalPadding) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.bg.withOpacity(0.8),
            AppColors.bg.withOpacity(0.4),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 14),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) => setState(() => _query = value),
          style: const TextStyle(color: Colors.black, fontSize: 13), // Reduced from 14
          cursorColor: AppColors.orange,
          decoration: InputDecoration(
            hintText: 'Search contacts or messages...',
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.45),
              fontSize: 13, // Added explicit size for consistency
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black.withOpacity(0.5),
              size: 20,
            ),
            suffixIcon: _query.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear, color: Colors.white.withOpacity(0.5), size: 18),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _query = '');
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 56,
            color: Colors.white.withOpacity(0.2),
          ),
          const SizedBox(height: 12),
          Text(
            'No chats found',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 13, // Reduced from 15
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatListTile extends StatelessWidget {
  final ChatContact contact;
  final double paddingHorizontal;
  final VoidCallback onTap;

  const _ChatListTile({
    required this.contact,
    required this.paddingHorizontal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasUnread = contact.unreadCount > 0;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: 12,
        ),
        child: Row(
          children: [
            // WhatsApp Style Avatar with Online Status Badge
            Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.textSecondary,
                  backgroundImage: contact.avatarUrl != null
                      ? NetworkImage(contact.avatarUrl!)
                      : null,
                  child: contact.avatarUrl == null
                      ? const Icon(
                          Icons.person,
                          color: Colors.white70,
                          size: 28,
                        )
                      : null,
                ),
                if (contact.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3ECF6E),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.bg, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),

            // Contact Name & Last Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14, // Reduced from 15.5
                      fontWeight:
                          hasUnread ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    contact.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: hasUnread
                          ? Colors.black.withOpacity(0.9)
                          : Colors.black.withOpacity(0.5),
                      fontSize: 12, // Reduced from 13
                      fontWeight:
                          hasUnread ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Timestamp & Unread Badge Count
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  contact.time,
                  style: TextStyle(
                    color: hasUnread
                        ? AppColors.navy
                        : Colors.white.withOpacity(0.4),
                    fontSize: 11, // Reduced from 12
                    fontWeight: hasUnread ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 6),
                if (hasUnread)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.navy,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      contact.unreadCount > 99
                          ? '99+'
                          : contact.unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10, // Reduced from 11
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}