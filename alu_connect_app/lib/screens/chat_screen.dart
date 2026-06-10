import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../services/app_state.dart';
import '../models/models.dart';
import 'chat_screen_detail.dart';

class ChatsScreen extends StatefulWidget {
  final AppState appState;

  const ChatsScreen({super.key, required this.appState});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  String _searchQuery = '';

  List<ChatPreview> get _filteredChats {
    final query = _searchQuery.toLowerCase();
    if (query.isEmpty) return widget.appState.chats;
    return widget.appState.chats.where((chat) {
      return chat.name.toLowerCase().contains(query) ||
          chat.lastMessage.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final chats = _filteredChats;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Chats',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      color: AppColors.textSecondary,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
            AppSearchBar(
              hint: 'Search chats...',
              onChanged: (value) => setState(() => _searchQuery = value),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                itemCount: chats.length,
                separatorBuilder: (context, index) => const SizedBox(height: 4),
                itemBuilder: (context, i) {
                  return _ChatTile(
                    chat: chats[i],
                    onTap: () {
                      widget.appState.setSelectedChat(chats[i].id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreenDetail(
                            chatId: chats[i].id,
                            appState: widget.appState,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final ChatPreview chat;
  final VoidCallback onTap;

  const _ChatTile({required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: chat.unreadCount > 0 ? AppColors.card : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: chat.unreadCount > 0
                ? AppColors.amber.withAlpha((0.2 * 255).round())
                : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            NotifBadge(
              count: chat.unreadCount,
              child: AvatarWidget(
                emoji: chat.avatarEmoji,
                color: chat.avatarColor,
                size: 48,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: chat.unreadCount > 0
                                ? FontWeight.w700
                                : FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Text(
                        _formatTime(chat.timestamp),
                        style: TextStyle(
                          fontSize: 11,
                          color: chat.unreadCount > 0
                              ? AppColors.amber
                              : AppColors.textMuted,
                          fontWeight: chat.unreadCount > 0
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    chat.lastMessage,
                    style: TextStyle(
                      fontSize: 13,
                      color: chat.unreadCount > 0
                          ? AppColors.textSecondary
                          : AppColors.textMuted,
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

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[dt.weekday - 1];
  }
}
