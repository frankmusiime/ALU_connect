# ALU Connect App - Integration Architecture Guide

## Overview

This document describes the complete integration of the ALU Connect app, including authentication/onboarding, event management, RSVP handling, communities, chat functionality, user profiles, and navigation.

---

## 1. Application State Management

### AppState Service (`lib/services/app_state.dart`)

The centralized state management service handles:

- **Authentication**: Login/Logout state
- **User Management**: Current user data and profile updates
- **Events**: Event list, RSVP status, and saved events
- **Communities**: Community list and join/leave status
- **Chats**: Chat conversations and messaging
- **Navigation**: Selected tab index and chat selection

#### Key Methods:

```dart
// Authentication
Future<void> login(String email, String password)
void logout()

// RSVP Management
void updateEventRSVP(String eventId, RSVPStatus status)
void toggleEventSaved(String eventId)

// Community Management
void toggleCommunityJoin(String communityId)

// Messaging
void sendMessage(String chatId, String content)
List<MessageModel> getChatMessages(String chatId)

// Navigation
void setSelectedNavIndex(int index)
void setSelectedChat(String chatId)
```

---

## 2. Navigation Flow

### Authentication -> Main App

```
MyApp (root)
├── isLoggedIn = false → OnboardingScreen
│   ├── Onboarding Carousel (3 pages)
│   └── Login Form
│       └── On successful login → MainShell
│
└── isLoggedIn = true → MainShell (bottom navigation)
    ├── Home Tab (0)
    ├── Explore Tab (1)
    ├── Communities Tab (2)
    ├── Chats Tab (3)
    └── Profile Tab (4)
```

### Route Structure

- `/` → Home or OnboardingScreen (based on auth state)
- `/event-details?id={eventId}` → Event Details Screen
- `/chat?id={chatId}` → Chat Screen Detail

---

## 3. Screen Integration

### Onboarding Screen (`main.dart`)

**Purpose**: First-time user introduction and login

- **Features**:
  - 3-page carousel with app features
  - Email/password login form (demo accepts any credentials)
  - Direct navigation to MainShell on successful login
- **State Passed**: AppState instance
- **Navigation**: MainShell on login

### Main Shell (`lib/screens/main_shell.dart`)

**Purpose**: Bottom navigation container managing 5 primary screens

- **Navigation Items**:
  1. **Home** - Feed of personalized events
  2. **Explore** - Browse all events with filters
  3. **Communities** - View and join communities
  4. **Chats** - List of conversations
  5. **Profile** - User profile and settings
- **Features**:
  - Unread message badge on Chats tab
  - Back navigation handling
  - Persistent state across tab switches

### Home Screen (`lib/screens/home_screen.dart`)

**Purpose**: Personalized dashboard and event feed

- **Sections**:
  - Welcome header with user name
  - Search and notifications
  - Quick category filters
  - Featured events carousel
  - Opportunity list
  - Stats banner
- **State Integration**:
  - Displays `appState.currentUser` info
  - Shows `appState.events` in featured section
  - Navigates to EventDetailsScreenWrapper with AppState

### Explore Screen (`lib/screens/explore_screen.dart`)

**Purpose**: Browse all events with filtering and search

- **Features**:
  - Full-text search across events
  - Filter chips (All, Events, Opportunities, Workshops, Clubs)
  - Recommended section when no filters applied
  - Full event listing with compact rows
- **State Integration**:
  - Uses `appState.events` with client-side filtering
  - Navigates to EventDetailsScreenWrapper

### Event Details Screen (`lib/screens/event_details.dart`)

**Purpose**: Comprehensive event information and RSVP management

- **Features**:
  - Hero header with event type badge
  - Event statistics (going, interested, capacity)
  - Date, location, and organizer info
  - Event tags and description
  - RSVP buttons (Going/Interested)
  - Capacity progress bar
- **State Integration**:
  - Displays event from `appState.events`
  - RSVP button state tied to `event.rsvpStatus`
  - Save button updates `event.isSaved` via AppState
  - Used via EventDetailsScreenWrapper

### Communities Screen (`lib/screens/communities_screen.dart`)

**Purpose**: View and manage community memberships

- **Tabs**:
  - All Clubs - Browse all available communities
  - My Clubs - Communities user has joined
- **Features**:
  - Community cards with join/leave buttons
  - Member count display
  - Community description and tags
- **State Integration**:
  - Lists `appState.communities`
  - Toggle join via `appState.toggleCommunityJoin()`
  - Community join state stored in model

### Chats Screen (`lib/screens/chat_screen.dart`)

**Purpose**: List of active conversations

- **Features**:
  - Chat search functionality
  - Unread message count badges
  - Last message preview
  - Timestamp of last message
  - Highlight unread chats
- **State Integration**:
  - Displays `appState.chats` list
  - Shows unread count from each chat
  - Navigates to ChatScreenDetail with chatId and AppState
  - Marks chat as read via `appState.setSelectedChat()`

### Chat Screen Detail (`lib/screens/chat_screen_detail.dart`)

**Purpose**: Individual conversation thread

- **Features**:
  - Message history with timestamps
  - Sender name and avatar
  - Text input field with send button
  - Auto-scroll to latest message
  - Message bubbles with different styling for user vs others
  - File attachment indicators
- **State Integration**:
  - Displays messages via `appState.getChatMessages(chatId)`
  - Sends messages via `appState.sendMessage()`
  - Auto-updates message list on send
  - Back button clears selected chat

### Profile Screen (`lib/screens/profile_screen.dart`)

**Purpose**: User profile and account management

- **Tabs**:
  - Activity - Events attended and saved
  - Saved - Bookmarked events
  - Settings - Account preferences
- **Features**:
  - User header with avatar, name, role
  - Stats display (events attended, communities joined, connections)
  - Badges/achievements
  - Tab-based organization
- **State Integration**:
  - Displays `appState.currentUser` profile
  - Logout button via `appState.logout()`
  - References saved and attended events

---

## 4. Data Models

### Core Models (` lib/models/models.dart`)

```dart
UserModel - User profile and credentials
EventModel - Event details with RSVP status
CommunityModel - Community info with join status
ChatPreview - Chat conversation preview
MessageModel - Individual message
```

### Enums

```dart
EventType: event, opportunity, workshop, competition, announcement
RSVPStatus: none, interested, going, attended
UserRole: student, clubLeader, coach, entrepreneur, academicLeader, admin
```

---

## 5. State Flow Examples

### Example 1: User RSVP Flow

```
1. User sees event in HomeScreen or ExploreScreen
2. Taps event → EventDetailsScreenWrapper opens
3. RSVPButton displayed with current status
4. User taps "Going" button
5. RSVPButton.onPressed → appState.updateEventRSVP(eventId, RSVPStatus.going)
6. AppState updates model and notifies listeners
7. EventDetailsScreen rebuilds with new RSVP status
8. Tapping "Mark Interested" changes status
9. Navigator.pop() returns to previous screen
```

### Example 2: Message Sending Flow

```
1. User taps chat in ChatsScreen
2. appState.setSelectedChat(chatId) - marks as read
3. ChatScreenDetail(chatId, appState) opens
4. User types message and taps send
5. _sendMessage() → appState.sendMessage(chatId, content)
6. AppState creates MessageModel and adds to messages list
7. ChatScreenDetail rebuilds with new message
8. ListView auto-scrolls to bottom
9. Message timestamp formatted and displayed
```

### Example 3: Community Join Flow

```
1. User views CommunitiesScreen
2. Taps "Join" button on community card
3. CommunityCard.onTap → appState.toggleCommunityJoin(communityId)
4. AppState toggles community.isJoined status
5. CommunityCard rebuilds with "Joined" state
6. Color and text of button change
7. Community moves to "My Clubs" tab
```

---

## 6. Key Integration Points

### Authentication Flow

- **Trigger**: User on OnboardingScreen presses "Let's Get Started" → login form
- **Action**: `appState.login(email, password)` simulates auth (accepts any credentials)
- **Result**: `isLoggedIn = true` → MainShell displays
- **Logout**: ProfileScreen settings tab has logout button → `appState.logout()`

### Navigation Between Screens

- All navigation uses AppState to pass data
- EventDetailsScreenWrapper pattern ensures AppState is available
- ChatScreenDetail receives chatId and AppState separately
- MainShell automatically switches tabs on nav index change

### Real-Time Updates

- AppState uses ChangeNotifier pattern
- Screens listening to AppState state changes
- notifyListeners() called after state modifications
- Minimal rebuilds through targeted listeners

### Unread Messages Badge

- MainShell.bottomNav shows total unread via `getTotalUnreadMessages()`
- Badge updates when ChatsScreen navigates to ChatScreenDetail
- Chat marked as read: `unreadCount = 0`

---

## 7. Mock Data Integration

- Mock data in `lib/data/mock_data.dart` loaded on app start
- AppState.\_initializeData() populates default state
- Modifications persist during app session (except app restart)
- No persistent storage - next app launch loads fresh mock data

---

## 8. File Structure

```
lib/
├── main.dart                          # App entry + Auth flow
├── services/
│   └── app_state.dart                # Centralized state
├── screens/
│   ├── main_shell.dart               # Bottom navigation
│   ├── home_screen.dart
│   ├── explore_screen.dart
│   ├── communities_screen.dart
│   ├── chat_screen.dart
│   ├── chat_screen_detail.dart       # Individual chats
│   ├── profile_screen.dart
│   ├── event_details.dart            # Event detail + wrapper
│   └── screens.dart                  # (legacy - mostly replaced)
├── models/
│   └── models.dart
├── theme/
│   └── app_theme.dart
├── widgets/
│   └── shared_widgets.dart
└── data/
    └── mock_data.dart
```

---

## 9. Features Implemented

✅ **Authentication/Onboarding**

- Carousel introduction
- Login form
- Session persistence during app lifetime

✅ **Dynamic Event Feed**

- Home screen with personalized recommendations
- Explore screen with search and filters
- Featured events carousel
- Opportunity listings

✅ **RSVP Management**

- Going/Interested/None status
- Visual status indicators
- Capacity tracking
- Save to list functionality

✅ **Chat/Communication**

- Chat preview list with unread badges
- Message threads
- Real-time message display
- Timestamp formatting
- Sender identification

✅ **Profile/Identity**

- User header with avatar
- Stats display (events, communities, connections)
- Badges and achievements
- Multiple profile tabs (Activity, Saved, Settings)
- Logout functionality

✅ **Navigation & State**

- Bottom tab navigation
- Cross-screen state sharing via AppState
- Back navigation handling
- Persistent state across tabs
- Deep linking capability

---

## 10. Next Steps for Enhancement

- [ ] Add Provider package for improved state management
- [ ] Implement persistent storage (Hive/SQLite)
- [ ] Add real API integration
- [ ] Implement push notifications for messages
- [ ] Add image/file upload to messages
- [ ] Add user search and direct messaging
- [ ] Implement event calendar view
- [ ] Add notification system
- [ ] Multi-language support
- [ ] Offline capability
