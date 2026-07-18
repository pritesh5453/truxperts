// import 'package:flutter/material.dart';

// // ---------- CONSTANTS ----------

// const kPrimaryBlue = Color(0xFF2F6FED);
// const kDeepBlue = Color(0xFF1E4FC4);
// const kChatBg = Color(0xFFEAF1FF); // light blue chat background
// const kBubbleVendor = Colors.white;
// const kBubbleCustomer = kPrimaryBlue;
// const kTextDark = Color(0xFF1C1C1E);
// const kTextGrey = Color(0xFF8A8A8E);

// // ---------- MODELS ----------

// enum MsgType { text, image, quote }

// class ChatMessage {
//   final String text;
//   final bool isMe; // true = customer (me), false = vendor
//   final String time;
//   final MsgType type;
//   final bool seen;

//   const ChatMessage({
//     required this.text,
//     required this.isMe,
//     required this.time,
//     this.type = MsgType.text,
//     this.seen = false,
//   });
// }

// // ---------- SCREEN ----------

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   final List<ChatMessage> _messages = [
//     const ChatMessage(
//       text: 'Hi! I saw your request for electrical wiring repair. I can help you today.',
//       isMe: false,
//       time: '10:02 AM',
//     ),
//     const ChatMessage(
//       text: 'Hello! Great, thank you for responding so quickly.',
//       isMe: true,
//       time: '10:03 AM',
//       seen: true,
//     ),
//     const ChatMessage(
//       text: 'Could you share some photos of the wiring issue so I can prepare accordingly?',
//       isMe: false,
//       time: '10:04 AM',
//     ),
//     const ChatMessage(
//       text: 'Sure, sending it now.',
//       isMe: true,
//       time: '10:05 AM',
//       seen: true,
//     ),
//     const ChatMessage(
//       text: '📷 Photo',
//       isMe: true,
//       time: '10:05 AM',
//       type: MsgType.image,
//       seen: true,
//     ),
//     const ChatMessage(
//       text: "Got it. This looks like a loose junction box connection. I'll need about 45 minutes to fix this.",
//       isMe: false,
//       time: '10:07 AM',
//     ),
//     const ChatMessage(
//       text: 'My quote for this job would be ₹650, including parts.',
//       isMe: false,
//       time: '10:07 AM',
//       type: MsgType.quote,
//     ),
//     const ChatMessage(
//       text: 'That works for me. When can you come?',
//       isMe: true,
//       time: '10:09 AM',
//       seen: true,
//     ),
//     const ChatMessage(
//       text: 'I can be there today by 4:30 PM. Does that suit you?',
//       isMe: false,
//       time: '10:10 AM',
//     ),
//     const ChatMessage(
//       text: 'Perfect, see you then!',
//       isMe: true,
//       time: '10:11 AM',
//       seen: false,
//     ),
//   ];

//   @override
//   void dispose() {
//     _controller.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _sendMessage() {
//     final text = _controller.text.trim();
//     if (text.isEmpty) return;
//     setState(() {
//       _messages.add(ChatMessage(text: text, isMe: true, time: 'Now', seen: false));
//     });
//     _controller.clear();
//     Future.delayed(const Duration(milliseconds: 100), () {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kChatBg,
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildAppBar(),
//             Expanded(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: kChatBg,
//                 ),
//                 child: ListView.builder(
//                   controller: _scrollController,
//                   padding: const EdgeInsets.fromLTRB(14, 16, 14, 10),
//                   itemCount: _messages.length + 1,
//                   itemBuilder: (context, i) {
//                     if (i == 0) return _buildDateChip();
//                     final msg = _messages[i - 1];
//                     return _MessageBubble(msg: msg);
//                   },
//                 ),
//               ),
//             ),
//             _buildInputBar(),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---- App bar with vendor info, on a blue gradient background ----
//   Widget _buildAppBar() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [kDeepBlue, kPrimaryBlue],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       padding: const EdgeInsets.fromLTRB(6, 6, 16, 14),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () {},
//           ),
//           Stack(
//             children: [
//               const CircleAvatar(
//                 radius: 21,
//                 backgroundColor: Colors.white24,
//                 child: Icon(Icons.person, color: Colors.white, size: 24),
//               ),
//               Positioned(
//                 right: 0,
//                 bottom: 0,
//                 child: Container(
//                   width: 11,
//                   height: 11,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF33D375),
//                     shape: BoxShape.circle,
//                     border: Border.all(color: kPrimaryBlue, width: 2),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text(
//                   'Amit Electricals',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 15.5,
//                   ),
//                 ),
//                 SizedBox(height: 2),
//                 Text(
//                   'Online • Electrician',
//                   style: TextStyle(color: Colors.white70, fontSize: 11.5),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.call_outlined, color: Colors.white, size: 22),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.more_vert, color: Colors.white, size: 22),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDateChip() {
//     return Center(
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 14),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14),
//           boxShadow: [
//             BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2)),
//           ],
//         ),
//         child: const Text(
//           'Today',
//           style: TextStyle(fontSize: 11.5, color: kTextGrey, fontWeight: FontWeight.w500),
//         ),
//       ),
//     );
//   }

//   // ---- Bottom input bar ----
//   Widget _buildInputBar() {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2)),
//         ],
//       ),
//       child: SafeArea(
//         top: false,
//         child: Row(
//           children: [
//             IconButton(
//               icon: const Icon(Icons.add_circle_outline, color: kPrimaryBlue),
//               onPressed: () {},
//             ),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: kChatBg,
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _controller,
//                         minLines: 1,
//                         maxLines: 4,
//                         textCapitalization: TextCapitalization.sentences,
//                         decoration: const InputDecoration(
//                           hintText: 'Type a message...',
//                           hintStyle: TextStyle(color: kTextGrey, fontSize: 13.5),
//                           border: InputBorder.none,
//                           isCollapsed: true,
//                         ),
//                         style: const TextStyle(fontSize: 13.5),
//                       ),
//                     ),
//                     IconButton(
//                       padding: EdgeInsets.zero,
//                       constraints: const BoxConstraints(),
//                       icon: const Icon(Icons.camera_alt_outlined, size: 20, color: kTextGrey),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             GestureDetector(
//               onTap: _sendMessage,
//               child: Container(
//                 width: 42,
//                 height: 42,
//                 decoration: const BoxDecoration(
//                   color: kPrimaryBlue,
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(Icons.send_rounded, color: Colors.white, size: 19),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ---------- MESSAGE BUBBLE ----------

// class _MessageBubble extends StatelessWidget {
//   final ChatMessage msg;
//   const _MessageBubble({required this.msg});

//   @override
//   Widget build(BuildContext context) {
//     final isMe = msg.isMe;

//     if (msg.type == MsgType.quote) {
//       return _buildQuoteBubble(context);
//     }
//     if (msg.type == MsgType.image) {
//       return _buildImageBubble(context);
//     }

//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
//         margin: const EdgeInsets.only(bottom: 10),
//         padding: const EdgeInsets.fromLTRB(14, 10, 12, 8),
//         decoration: BoxDecoration(
//           color: isMe ? kBubbleCustomer : kBubbleVendor,
//           borderRadius: BorderRadius.only(
//             topLeft: const Radius.circular(16),
//             topRight: const Radius.circular(16),
//             bottomLeft: Radius.circular(isMe ? 16 : 4),
//             bottomRight: Radius.circular(isMe ? 4 : 16),
//           ),
//           boxShadow: [
//             BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2)),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               msg.text,
//               style: TextStyle(
//                 color: isMe ? Colors.white : kTextDark,
//                 fontSize: 13.5,
//                 height: 1.35,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   msg.time,
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: isMe ? Colors.white70 : kTextGrey,
//                   ),
//                 ),
//                 if (isMe) ...[
//                   const SizedBox(width: 3),
//                   Icon(
//                     Icons.done_all,
//                     size: 13,
//                     color: msg.seen ? const Color(0xFF7BE0FF) : Colors.white70,
//                   ),
//                 ],
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImageBubble(BuildContext context) {
//     final isMe = msg.isMe;
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         width: 160,
//         height: 130,
//         decoration: BoxDecoration(
//           color: isMe ? kBubbleCustomer.withOpacity(0.15) : Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: const Radius.circular(16),
//             topRight: const Radius.circular(16),
//             bottomLeft: Radius.circular(isMe ? 16 : 4),
//             bottomRight: Radius.circular(isMe ? 4 : 16),
//           ),
//           border: Border.all(color: const Color(0xFFDCE6FA)),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.image_outlined, size: 34, color: kPrimaryBlue),
//             const SizedBox(height: 6),
//             Text(
//               msg.time,
//               style: const TextStyle(fontSize: 10, color: kTextGrey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildQuoteBubble(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
//         margin: const EdgeInsets.only(bottom: 10),
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(16),
//             topRight: Radius.circular(16),
//             bottomRight: Radius.circular(16),
//             bottomLeft: Radius.circular(4),
//           ),
//           border: Border.all(color: const Color(0xFFDCE6FA)),
//           boxShadow: [
//             BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2)),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: const [
//                 Icon(Icons.receipt_long_outlined, size: 16, color: kPrimaryBlue),
//                 SizedBox(width: 6),
//                 Text(
//                   'Quote Sent',
//                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: kPrimaryBlue),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               msg.text,
//               style: const TextStyle(fontSize: 13.5, color: kTextDark, height: 1.35),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () {},
//                     style: OutlinedButton.styleFrom(
//                       side: const BorderSide(color: kPrimaryBlue),
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: const Text('Decline', style: TextStyle(color: kPrimaryBlue, fontSize: 12.5)),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: kPrimaryBlue,
//                       elevation: 0,
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: const Text('Accept', style: TextStyle(color: Colors.white, fontSize: 12.5)),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 6),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Text(
//                 msg.time,
//                 style: const TextStyle(fontSize: 10, color: kTextGrey),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:truxperts/screens/chat/chat_listScreen.dart';
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
                          fontSize: 13,
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
                    fontSize: 15,
                  ),
                ),
                Text(
                  widget.contact.isOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 11.5,
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
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  cursorColor: AppColors.orange,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
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
                fontSize: 14,
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
                    fontSize: 10.5,
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