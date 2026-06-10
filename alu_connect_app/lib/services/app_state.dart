import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../data/mock_data.dart';

/// Global app state management service for handling authentication, user data, and app state.
class AppState with ChangeNotifier {
  // Authentication state
  bool _isLoggedIn = false;
  UserModel? _currentUser;

  // Data state
  List<EventModel> _events = [];
  List<CommunityModel> _communities = [];
  List<ChatPreview> _chats = [];
  Map<String, List<MessageModel>> _chatMessages = {};

  // Navigation state
  int _selectedNavIndex = 0;
  String? _selectedChatId;

  // Getters
  bool get isLoggedIn => _isLoggedIn;
  UserModel? get currentUser => _currentUser;

  List<EventModel> get events => _events;
  List<CommunityModel> get communities => _communities;
  List<ChatPreview> get chats => _chats;
  int get selectedNavIndex => _selectedNavIndex;
  String? get selectedChatId => _selectedChatId;

  ChatPreview? get selectedChat => _selectedChatId != null
      ? _chats.firstWhere(
          (c) => c.id == _selectedChatId,
          orElse: () => _chats.first,
        )
      : null;

  AppState() {
    _initializeData();
  }

  /// Initialize app with mock data
  void _initializeData() {
    _events = List.from(MockData.events);
    _communities = List.from(MockData.communities);
    _chats = List.from(MockData.chats);
    _chatMessages = {
      for (var chat in _chats) chat.id: List.from(MockData.chatMessages),
    };
  }

  /// Login the user
  Future<void> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // For demo, accept any credentials
    _isLoggedIn = true;
    _currentUser = MockData.currentUser;
    notifyListeners();
  }

  /// Logout the user
  void logout() {
    _isLoggedIn = false;
    _currentUser = null;
    _selectedChatId = null;
    _selectedNavIndex = 0;
    notifyListeners();
  }

  /// Update user profile
  void updateUserProfile(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  /// RSVP to an event
  void updateEventRSVP(String eventId, RSVPStatus status) {
    final eventIndex = _events.indexWhere((e) => e.id == eventId);
    if (eventIndex != -1) {
      _events[eventIndex].rsvpStatus = status;
      notifyListeners();
    }
  }

  /// Save/unsave an event
  void toggleEventSaved(String eventId) {
    final eventIndex = _events.indexWhere((e) => e.id == eventId);
    if (eventIndex != -1) {
      _events[eventIndex].isSaved = !_events[eventIndex].isSaved;
      notifyListeners();
    }
  }

  /// Join/leave a community
  void toggleCommunityJoin(String communityId) {
    final communityIndex = _communities.indexWhere((c) => c.id == communityId);
    if (communityIndex != -1) {
      _communities[communityIndex].isJoined =
          !_communities[communityIndex].isJoined;
      notifyListeners();
    }
  }

  /// Get messages for a specific chat
  List<MessageModel> getChatMessages(String chatId) {
    return _chatMessages[chatId] ?? [];
  }

  /// Send a message to a chat
  void sendMessage(String chatId, String content) {
    if (_chatMessages[chatId] == null) {
      _chatMessages[chatId] = [];
    }

    final message = MessageModel(
      id: 'm_${DateTime.now().millisecondsSinceEpoch}',
      senderId: _currentUser?.id ?? 'user',
      senderName: _currentUser?.name ?? 'You',
      senderAvatar: '👤',
      content: content,
      timestamp: DateTime.now(),
      isMe: true,
    );

    _chatMessages[chatId]!.add(message);

    // Update chat preview last message
    final chatIndex = _chats.indexWhere((c) => c.id == chatId);
    if (chatIndex != -1) {
      _chats[chatIndex] = ChatPreview(
        id: _chats[chatIndex].id,
        name: _chats[chatIndex].name,
        avatarEmoji: _chats[chatIndex].avatarEmoji,
        avatarColor: _chats[chatIndex].avatarColor,
        lastMessage: content,
        timestamp: DateTime.now(),
        unreadCount: 0,
        isGroup: _chats[chatIndex].isGroup,
      );
    }

    notifyListeners();
  }

  /// Update navigation index
  void setSelectedNavIndex(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }

  /// Set selected chat
  void setSelectedChat(String chatId) {
    _selectedChatId = chatId;
    // Mark messages as read
    if (_chats.indexWhere((c) => c.id == chatId) != -1) {
      final chatIndex = _chats.indexWhere((c) => c.id == chatId);
      _chats[chatIndex] = ChatPreview(
        id: _chats[chatIndex].id,
        name: _chats[chatIndex].name,
        avatarEmoji: _chats[chatIndex].avatarEmoji,
        avatarColor: _chats[chatIndex].avatarColor,
        lastMessage: _chats[chatIndex].lastMessage,
        timestamp: _chats[chatIndex].timestamp,
        unreadCount: 0,
        isGroup: _chats[chatIndex].isGroup,
      );
    }
    notifyListeners();
  }

  /// Clear selected chat
  void clearSelectedChat() {
    _selectedChatId = null;
    notifyListeners();
  }

  /// Get events by user's RSVP status
  List<EventModel> getEventsByRsvpStatus(RSVPStatus status) {
    return _events.where((e) => e.rsvpStatus == status).toList();
  }

  /// Get user's communities
  List<CommunityModel> getUserCommunities() {
    return _communities.where((c) => c.isJoined).toList();
  }

  /// Get user's chats with unread messages
  int getTotalUnreadMessages() {
    return _chats.fold<int>(0, (sum, chat) => sum + chat.unreadCount);
  }
}
