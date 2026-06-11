import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class MockData {
  static final currentUser = UserModel(
    id: 'u1',
    name: 'Aline Umuhoza',
    email: 'aline@example.com',
    campus: 'Kigali Campus',
    major: 'Entrepreneurial Leadership',
    cohort: 'Class of 2027',
    avatarUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=200&q=80',
    role: UserRole.student,
    interests: ['Entrepreneurship', 'Technology', 'Social Impact'],
    eventsAttended: 23,
    communitiesJoined: 5,
    connections: 87,
    badges: ['Community Builder', 'Opportunity Hunter', 'Early Adopter'],
  );

  static final List<EventModel> events = [
    EventModel(
      id: 'e1',
      title: 'ALU Entrepreneurship Pitch Night',
      description:
          'Showcase your idea, get feedback from industry mentors, and connect with investors. This is your chance to pitch your startup concept to a panel of experienced entrepreneurs and secure early-stage support.',
      location: 'Kigali Campus – Innovation Lab',
      date: DateTime(2026, 5, 24, 18, 0),
      organizer: 'Entrepreneurship Club',
      organizerAvatar: '🚀',
      type: EventType.competition,
      imageUrl:
          'https://images.unsplash.com/photo-1515169067865-5387ec356754?auto=format&fit=crop&w=900&q=80',
      goingCount: 48,
      interestedCount: 12,
      capacity: 100,
      tags: ['Startup', 'Pitching', 'Networking'],
      rsvpStatus: RSVPStatus.going,
    ),
    EventModel(
      id: 'e2',
      title: 'AI for Social Impact Workshop',
      description:
          'Learn how AI tools can be used to drive social impact in Africa. Hands-on sessions and group projects exploring practical applications of machine learning.',
      location: 'Mauritius Campus – Innovation Lab',
      date: DateTime(2026, 6, 5, 9, 0),
      organizer: 'Tech & Innovation Hub',
      organizerAvatar: '🤖',
      type: EventType.workshop,
      imageUrl:
          'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=900&q=80',
      goingCount: 34,
      interestedCount: 19,
      capacity: 50,
      tags: ['AI', 'Tech', 'Social Impact'],
      rsvpStatus: RSVPStatus.interested,
    ),
    EventModel(
      id: 'e3',
      title: 'Sustainable Solutions Challenge',
      description:
          'A 48-hour hackathon to design innovative solutions for sustainability challenges in Africa. Form teams, identify problems, and build prototypes that create lasting change.',
      location: 'Mauritius Campus',
      date: DateTime(2026, 5, 28, 8, 0),
      organizer: 'ALU Student Government',
      organizerAvatar: '🌍',
      type: EventType.competition,
      imageUrl:
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=80',
      goingCount: 62,
      interestedCount: 28,
      capacity: 120,
      tags: ['Hackathon', 'Sustainability', 'Innovation'],
    ),
    EventModel(
      id: 'e4',
      title: 'Build Your First MVP Workshop',
      description:
          'Step-by-step workshop on building your minimum viable product. Learn lean startup methodology, prototyping tools, and how to validate your idea quickly.',
      location: 'Kigali Campus – Tech Hub',
      date: DateTime(2026, 6, 2, 10, 0),
      organizer: 'ALU Ventures',
      organizerAvatar: '💡',
      type: EventType.workshop,
      imageUrl:
          'https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&w=900&q=80',
      goingCount: 27,
      interestedCount: 15,
      capacity: 40,
      tags: ['MVP', 'Startup', 'Product'],
    ),
    EventModel(
      id: 'e5',
      title: 'Campus Ambassador Program',
      description:
          'Join the ALU Campus Ambassador Program and become a student leader. Represent ALU in your community, organize outreach events, and build your leadership portfolio.',
      location: 'Online',
      date: DateTime(2026, 5, 22),
      organizer: 'ALU Admissions',
      organizerAvatar: '⭐',
      type: EventType.opportunity,
      imageUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=900&q=80',
      goingCount: 11,
      interestedCount: 45,
      capacity: 30,
      tags: ['Leadership', 'Ambassador', 'Opportunity'],
      isSaved: true,
    ),
    EventModel(
      id: 'e6',
      title: 'Design Thinking Bootcamp',
      description:
          'A 2-day intensive bootcamp on human-centered design thinking. Learn empathy mapping, ideation, prototyping, and user testing through real-world challenges.',
      location: 'Kigali Campus',
      date: DateTime(2026, 5, 30, 9, 0),
      organizer: 'Innovation Lab',
      organizerAvatar: '🎨',
      type: EventType.event,
      imageUrl:
          'https://images.unsplash.com/photo-1515879218367-8466d910aaa4?auto=format&fit=crop&w=900&q=80',
      goingCount: 19,
      interestedCount: 8,
      capacity: 35,
      tags: ['Design', 'Innovation', 'Bootcamp'],
      rsvpStatus: RSVPStatus.going,
    ),
  ];

  static final List<CommunityModel> communities = [
    CommunityModel(
      id: 'c1',
      name: 'ALU Debate Society',
      description:
          'Sharpening critical thinking and public speaking skills through competitive debate.',
      iconEmoji: '🎤',
      accentColor: AppColors.blue,
      memberCount: 124,
      tags: ['Debate', 'Communication'],
    ),
    CommunityModel(
      id: 'c2',
      name: 'Entrepreneurship Club',
      description:
          'Empowering student entrepreneurs to build, pitch, and grow their ventures.',
      iconEmoji: '🚀',
      accentColor: AppColors.amber,
      memberCount: 250,
      tags: ['Startup', 'Business'],
      isJoined: true,
    ),
    CommunityModel(
      id: 'c3',
      name: 'Women in Leadership',
      description:
          'Building a network of future female leaders through mentorship and action.',
      iconEmoji: '👑',
      accentColor: AppColors.purple,
      memberCount: 180,
      tags: ['Leadership', 'Community'],
      isJoined: true,
    ),
    CommunityModel(
      id: 'c4',
      name: 'Tech & Innovation Hub',
      description:
          'Where technologists, builders, and creators collaborate on future-forward projects.',
      iconEmoji: '💻',
      accentColor: AppColors.teal,
      memberCount: 210,
      tags: ['Tech', 'AI', 'Coding'],
    ),
    CommunityModel(
      id: 'c5',
      name: 'Social Impact Circle',
      description:
          'Students committed to creating meaningful change in African communities.',
      iconEmoji: '🌍',
      accentColor: AppColors.coral,
      memberCount: 93,
      tags: ['Impact', 'Volunteering'],
      isJoined: true,
    ),
    CommunityModel(
      id: 'c6',
      name: 'ALU Climate Action',
      description:
          'Taking collective action on climate and sustainability within our campus and beyond.',
      iconEmoji: '🌱',
      accentColor: const Color(0xFF4CAF50),
      memberCount: 67,
      tags: ['Climate', 'Sustainability'],
    ),
    CommunityModel(
      id: 'c7',
      name: 'Design & Product Club',
      description: 'Designers and product thinkers building beautiful products.',
      iconEmoji: '🎨',
      accentColor: const Color(0xFFFF6B82),
      memberCount: 89,
      tags: ['Design', 'Product'],
    ),
    CommunityModel(
      id: 'c8',
      name: 'Climate Innovators',
      description: 'Students working on climate-tech and sustainability projects.',
      iconEmoji: '🌿',
      accentColor: const Color(0xFF44D7C9),
      memberCount: 54,
      tags: ['Climate', 'Innovation'],
    ),
    CommunityModel(
      id: 'c9',
      name: 'Finance & Investment Club',
      description: 'Learning and practicing investing, VC, and financial analysis.',
      iconEmoji: '💼',
      accentColor: const Color(0xFFFFC85C),
      memberCount: 132,
      tags: ['Finance', 'Investing'],
    ),
  ];

  static final List<ChatPreview> chats = [
    ChatPreview(
      id: 'ch1',
      name: 'Entrepreneurship Club',
      avatarEmoji: '🚀',
      avatarColor: AppColors.amber,
      lastMessage: "David: Don't forget the meeting at 3PM",
      timestamp: DateTime.now().subtract(const Duration(minutes: 12)),
      unreadCount: 3,
      isGroup: true,
    ),
    ChatPreview(
      id: 'ch2',
      name: 'AI Workshop Group',
      avatarEmoji: '🤖',
      avatarColor: AppColors.teal,
      lastMessage: 'Fatima: Shared a file',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      unreadCount: 2,
      isGroup: true,
    ),
    ChatPreview(
      id: 'ch3',
      name: 'Campus Leaders',
      avatarEmoji: '⭐',
      avatarColor: AppColors.purple,
      lastMessage: 'Jean: See you there!',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      unreadCount: 0,
      isGroup: true,
    ),
    ChatPreview(
      id: 'ch4',
      name: 'Travel Buddies',
      avatarEmoji: '✈️',
      avatarColor: AppColors.blue,
      lastMessage: 'Sarah: Any updates?',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
      isGroup: true,
    ),
    ChatPreview(
      id: 'ch5',
      name: 'ALU Debate Society',
      avatarEmoji: '🎤',
      avatarColor: AppColors.coral,
      lastMessage: 'Emmanuel: Great job!',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      unreadCount: 0,
      isGroup: true,
    ),
  ];

  static final List<MessageModel> chatMessages = [
    MessageModel(
      id: 'm1',
      senderId: 'u2',
      senderName: 'Fatima',
      senderAvatar: '👩🏾',
      content:
          "Hey team! Don't forget our session tomorrow at 9am. See you all there 🎉",
      timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 10)),
      isMe: false,
    ),
    MessageModel(
      id: 'm2',
      senderId: 'u3',
      senderName: 'David',
      senderAvatar: '👨🏿',
      content: "Got it! I'll bring my laptop.",
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
      isMe: false,
    ),
    MessageModel(
      id: 'm3',
      senderId: 'u1',
      senderName: 'Aline',
      senderAvatar: '👩🏾‍💼',
      content: "Can't wait! 🙌",
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 48)),
      isMe: true,
    ),
    MessageModel(
      id: 'm4',
      senderId: 'u2',
      senderName: 'Fatima',
      senderAvatar: '👩🏾',
      content: '',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 20)),
      isMe: false,
      attachmentName: 'Workshop Materials.pdf',
    ),
    MessageModel(
      id: 'm5',
      senderId: 'u3',
      senderName: 'David',
      senderAvatar: '👨🏿',
      content: 'Thanks, downloading now!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
      isMe: false,
    ),
  ];

  static final List<BadgeModel> badges = [
    BadgeModel(emoji: '🏗️', label: 'Community Builder', color: AppColors.teal),
    BadgeModel(
      emoji: '🔍',
      label: 'Opportunity Hunter',
      color: AppColors.amber,
    ),
    BadgeModel(emoji: '🌟', label: 'Early Adopter', color: AppColors.purple),
  ];
}
