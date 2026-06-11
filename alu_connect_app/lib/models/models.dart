import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum EventType { event, opportunity, workshop, competition, announcement }
enum RSVPStatus { none, interested, going, attended }
enum UserRole { student, clubLeader, coach, entrepreneur, academicLeader, admin }

class UserModel {
  final String id;
  final String name;
  final String email;
  final String campus;
  final String major;
  final String cohort;
  final String avatarUrl;
  final UserRole role;
  final List<String> interests;
  final int eventsAttended;
  final int communitiesJoined;
  final int connections;
  final List<String> badges;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.campus,
    required this.major,
    required this.cohort,
    required this.avatarUrl,
    required this.role,
    required this.interests,
    required this.eventsAttended,
    required this.communitiesJoined,
    required this.connections,
    required this.badges,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? campus,
    String? major,
    String? cohort,
    String? avatarUrl,
    UserRole? role,
    List<String>? interests,
    int? eventsAttended,
    int? communitiesJoined,
    int? connections,
    List<String>? badges,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      campus: campus ?? this.campus,
      major: major ?? this.major,
      cohort: cohort ?? this.cohort,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      interests: interests ?? this.interests,
      eventsAttended: eventsAttended ?? this.eventsAttended,
      communitiesJoined: communitiesJoined ?? this.communitiesJoined,
      connections: connections ?? this.connections,
      badges: badges ?? this.badges,
    );
  }
}

class EventModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime date;
  final String organizer;
  final String organizerAvatar;
  final EventType type;
  final String imageUrl;
  final int goingCount;
  final int interestedCount;
  final int capacity;
  final List<String> tags;
  RSVPStatus rsvpStatus;
  bool isSaved;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.organizer,
    required this.organizerAvatar,
    required this.type,
    required this.imageUrl,
    required this.goingCount,
    required this.interestedCount,
    required this.capacity,
    required this.tags,
    this.rsvpStatus = RSVPStatus.none,
    this.isSaved = false,
  });

  Color get typeColor {
    switch (type) {
      case EventType.event: return AppColors.blue;
      case EventType.opportunity: return AppColors.teal;
      case EventType.workshop: return AppColors.purple;
      case EventType.competition: return AppColors.coral;
      case EventType.announcement: return AppColors.amber;
    }
  }

  /// Soft, theme-adaptive tint derived from [typeColor] — a quiet pill fill
  /// that reads well on both light and dark surfaces.
  Color get typeBgColor => typeColor.withAlpha(28);

  String get typeLabel {
    switch (type) {
      case EventType.event: return 'Event';
      case EventType.opportunity: return 'Opportunity';
      case EventType.workshop: return 'Workshop';
      case EventType.competition: return 'Competition';
      case EventType.announcement: return 'Announcement';
    }
  }
}

class CommunityModel {
  final String id;
  final String name;
  final String description;
  final String iconEmoji;
  final Color accentColor;
  final int memberCount;
  final List<String> tags;
  bool isJoined;

  CommunityModel({
    required this.id,
    required this.name,
    required this.description,
    required this.iconEmoji,
    required this.accentColor,
    required this.memberCount,
    required this.tags,
    this.isJoined = false,
  });
}

class MessageModel {
  final String id;
  final String senderId;
  final String senderName;
  final String senderAvatar;
  final String content;
  final DateTime timestamp;
  final bool isMe;
  final String? attachmentName;

  const MessageModel({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderAvatar,
    required this.content,
    required this.timestamp,
    required this.isMe,
    this.attachmentName,
  });
}

class ChatPreview {
  final String id;
  final String name;
  final String avatarEmoji;
  final Color avatarColor;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final bool isGroup;

  const ChatPreview({
    required this.id,
    required this.name,
    required this.avatarEmoji,
    required this.avatarColor,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
    required this.isGroup,
  });
}

class BadgeModel {
  final String emoji;
  final String label;
  final Color color;

  const BadgeModel({required this.emoji, required this.label, required this.color});
}