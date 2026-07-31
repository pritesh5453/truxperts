import 'package:flutter/material.dart';
import 'package:truxperts/Customer/screen/chat/chat_listScreen.dart';
import 'package:truxperts/utils/appcolors.dart';

/// Simple message model.
/// Replace with your real message model / Firestore data.
class ChatMessage {
  final String text;
  final DateTime time;
  final bool isMe;
  final bool isRead;

  ChatMessage({
    required this.text,
    required this.time,
    required this.isMe,
    this.isRead = false,
  });
}

class ChatScreen extends StatefulWidget {
  final ChatContact contact;

  const ChatScreen({super.key, required this.contact});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Dummy data — swap with real data source (Firestore stream etc.)
  late final List<ChatMessage> _messages = [
    ChatMessage(
      text: 'Hi, any update on the load?',
      time: DateTime.now().subtract(const Duration(minutes: 40)),
      isMe: false,
    ),
    ChatMessage(
      text: 'The truck has reached the loading point.',
      time: DateTime.now().subtract(const Duration(minutes: 35)),
      isMe: true,
      isRead: true,
    ),
    ChatMessage(
      text: 'Great, please share the driver\'s number.',
      time: DateTime.now().subtract(const Duration(minutes: 30)),
      isMe: false,
    ),
    ChatMessage(
      text: '9876543210',
      time: DateTime.now().subtract(const Duration(minutes: 28)),
      isMe: true,
      isRead: true,
    ),
    ChatMessage(
      text: widget.contact.lastMessage,
      time: DateTime.now().subtract(const Duration(minutes: 2)),
      isMe: false,
    ),
  ];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        time: DateTime.now(),
        isMe: true,
      ));
    });

    _messageController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });

    // TODO: Actually send the message via your backend / Firestore.
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _MessageBubble(
                  message: message,
                  timeLabel: _formatTime(message.time),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.navyDark,
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.navy,
                backgroundImage: widget.contact.avatarUrl != null
                    ? NetworkImage(widget.contact.avatarUrl!)
                    : null,
                child: widget.contact.avatarUrl == null
                    ? Text(
                        _initials(widget.contact.name),
                        style: const TextStyle(
                          color: AppColors.orange,
                          fontWeight: FontWeight.w700,
                          fontSize: 12, // Reduced from 13
                        ),
                      )
                    : null,
              ),
              if (widget.contact.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3ECF6E),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.navyDark, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.contact.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14, // Reduced from 15
                  ),
                ),
                Text(
                  widget.contact.isOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 10.5, // Reduced from 11.5
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.call_outlined, color: Colors.white70),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white70),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return SafeArea(
      top: false,
      child: Container(
        color: AppColors.navyDark,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.attach_file,
                  color: Colors.white.withOpacity(0.6)),
              onPressed: () {},
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _messageController,
                  minLines: 1,
                  maxLines: 4,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13, // Reduced from 14
                  ),
                  cursorColor: AppColors.orange,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13, // Added explicit size
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 6),
            CircleAvatar(
              radius: 21,
              backgroundColor: AppColors.orange,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 19),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final String timeLabel;

  const _MessageBubble({required this.message, required this.timeLabel});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? AppColors.orange : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomLeft: Radius.circular(isMe ? 14 : 2),
            bottomRight: Radius.circular(isMe ? 2 : 14),
          ),
          border: isMe
              ? null
              : Border.all(color: AppColors.navy.withOpacity(0.12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: isMe ? Colors.white : AppColors.navy,
                fontSize: 13, // Reduced from 14
                height: 1.35,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  timeLabel,
                  style: TextStyle(
                    color: isMe
                        ? Colors.white.withOpacity(0.75)
                        : AppColors.navy.withOpacity(0.45),
                    fontSize: 10, // Reduced from 10.5
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    message.isRead ? Icons.done_all : Icons.done,
                    size: 14,
                    color: message.isRead
                        ? Colors.white
                        : Colors.white.withOpacity(0.7),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}