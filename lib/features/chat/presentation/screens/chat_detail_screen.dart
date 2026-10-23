import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});
  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}
class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController =
  TextEditingController();
  final ScrollController _scrollController =
  ScrollController();
  // ==================== MESSAGES ====================
  final List<Map<String, dynamic>> _messages = [
    { 'text': 'Hi! I\'m on my way. Should arrive in about 8 minutes. Do you have any specific tools or parts you need me to bring?', 'time': '10:23 AM', 'isMe': false, },
    { 'text': 'Please bring extra 16A socket replacements if you have them.', 'time': '10:24 AM', 'isMe': true, },
    { 'text': 'Got it! I have those in stock. See you soon 👍', 'time': '10:25 AM', 'isMe': false, },
  ];
  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // ==================== SEND MESSAGE ====================
  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      return;
    }
    setState(() {
      _messages.add({
        'text': message,
        'time': 'Now',
        'isMe': true,
      });
      _messageController.clear();
    });
    // Scroll to the latest message
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ==================== HANDLE ====================

                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                // ==================== TITLE ====================

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Share something',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ==================== OPTIONS ====================

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildAttachmentOption(
                      icon: Icons.camera_alt_outlined,
                      title: 'Camera',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),

                    _buildAttachmentOption(
                      icon: Icons.photo_library_outlined,
                      title: 'Gallery',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),

                    _buildAttachmentOption(
                      icon: Icons.insert_drive_file_outlined,
                      title: 'Document',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildAttachmentOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.inputBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ==================== APP BAR ====================

      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
          ),
          onPressed: () {
            context.pop();
          },
        ),

        title: Row(
          children: [
            // Avatar + Online Indicator
            Stack(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.inputBackground,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200',
                  ),
                ),

                Positioned(
                  bottom: 0,
                  right: 0,

                  child: Container(
                    width: 8,
                    height: 8,

                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.surface,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 10),

            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahmed Mostafa',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                SizedBox(height: 2),

                Text(
                  'Online • Senior Electrician',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.phone_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () {},
          ),

          const SizedBox(width: 8),
        ],
      ),

      // ==================== CHAT BODY ====================

      body: Column(
        children: [
          // Date Chip
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),

            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 4,
              ),

              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius: BorderRadius.circular(12),
              ),

              child: const Text(
                'Today',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),

          // ==================== MESSAGES ====================

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                if (message['isMe'] == true) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12, ),
                    child: _buildOutgoingMessage(
                      text: message['text'],
                      time: message['time'],
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: _buildIncomingMessage(
                    text: message['text'],
                    time: message['time'],
                  ),
                );
                },
            ),
          ),

          // ==================== MESSAGE INPUT ====================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),

            color: AppColors.surface,

            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.attach_file_rounded,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: _showAttachmentOptions,
                ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),

                    decoration: BoxDecoration(
                      color: AppColors.inputBackground,
                      borderRadius: BorderRadius.circular(24),
                    ),

                    child: TextField(
                      controller: _messageController,

                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.inputBackground,
                    shape: BoxShape.circle,
                  ),

                  child: IconButton(
                    icon: const Icon(
                      Icons.send_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== INCOMING MESSAGE ====================

  Widget _buildIncomingMessage({
    required String text,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const CircleAvatar(
          radius: 12,
          backgroundColor: AppColors.inputBackground,
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200',
          ),
        ),

        const SizedBox(width: 8),

        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(14),

                decoration: const BoxDecoration(
                  color: AppColors.surface,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),

                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                time,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 40),
      ],
    );
  }

  // ==================== OUTGOING MESSAGE ====================

  Widget _buildOutgoingMessage({
    required String text,
    required String time,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(width: 40),

        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(14),

                decoration: const BoxDecoration(
                  color: AppColors.primary,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                  ),
                ),

                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                time,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}