import 'package:flutter/material.dart';
import 'package:truxperts/screens/chat/chatting_screen.dart';
import 'package:truxperts/utils/appcolors.dart';

/// Simple model for a chat/contact entry.
/// Replace this with your real chat model / Firestore data.
class ChatContact {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final String? avatarUrl; // null -> shows initials

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

  // Dummy data — swap with real data source (Firestore stream etc.)
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
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _filteredContacts.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.only(top: 4, bottom: 12),
                    itemCount: _filteredContacts.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      thickness: 0.6,
                      indent: 84,
                      color: Colors.white.withOpacity(0.06),
                    ),
                    itemBuilder: (context, index) {
                      final contact = _filteredContacts[index];
                      return _ChatListTile(
                        contact: contact,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orange,
        onPressed: () {
          // TODO: Start a new chat / pick a contact.
        },
        child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.navyDark,
      elevation: 0,
      centerTitle: false,
      title: const Text(
        'Chats',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white70),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: AppColors.navyDark,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) => setState(() => _query = value),
          style: const TextStyle(color: Colors.white, fontSize: 14),
          cursorColor: AppColors.orange,
          decoration: InputDecoration(
            hintText: 'Search contacts or messages',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            prefixIcon: Icon(Icons.search,
                color: Colors.white.withOpacity(0.5), size: 20),
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
          Icon(Icons.chat_bubble_outline,
              size: 56, color: Colors.white.withOpacity(0.2)),
          const SizedBox(height: 12),
          Text(
            'No chats found',
            style: TextStyle(color: Colors.white.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}

class _ChatListTile extends StatelessWidget {
  final ChatContact contact;
  final VoidCallback onTap;

  const _ChatListTile({required this.contact, required this.onTap});

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread = contact.unreadCount > 0;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.navyDark,
                  backgroundImage: contact.avatarUrl != null
                      ? NetworkImage(contact.avatarUrl!)
                      : null,
                  child: contact.avatarUrl == null
                      ? Text(
                          _initials(contact.name),
                          style: const TextStyle(
                            color: AppColors.orange,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
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
                        border: Border.all(color: AppColors.navy, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),

            // Name + last message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 15.5,
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
                          ? AppColors.navy
                          : AppColors.navy.withOpacity(0.5),
                      fontSize: 13,
                      fontWeight:
                          hasUnread ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Time + unread badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  contact.time,
                  style: TextStyle(
                    color: hasUnread
                        ? AppColors.orange
                        : Colors.white.withOpacity(0.4),
                    fontSize: 12,
                    fontWeight: hasUnread ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 6),
                if (hasUnread)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      contact.unreadCount > 99
                          ? '99+'
                          : contact.unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
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