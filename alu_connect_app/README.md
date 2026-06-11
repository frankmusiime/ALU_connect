# ALU Connect 


A mobile-first campus engagement platform for the African Leadership University ecosystem built with Flutter.

---

## Overview

ALU Connect is a digital campus hub that centralizes student engagement, leadership opportunities, community participation, and communication within ALU. Instead of fragmented WhatsApp groups, email threads, and physical notice boards, students and leaders interact through one unified mobile experience.

The app mirrors the structure of the physical ALU campus, making navigation intuitive and contextually familiar. It is designed to increase event visibility, reduce communication delays, and foster meaningful connections across both Kigali and Mauritius campuses.

---

## Features

### Implemented Features
| Requirement | Implementation |
|---|---|
| Authentication / Onboarding | login screen with username, email, password, Google & Apple sign-in |
| Dynamic Feed | Personalized home dashboard + filterable explore feed |
| RSVP / Participation | Going / Interested states with capacity progress bar |
| Lightweight Chat | Group chat rooms with file attachments and real-time send |
| Profile / Identity | User profile with stats, badges, interests, and RSVP history |
| Navigation & State | Bottom nav shell + Provider-ready state across all screens |

---

## Project Structure

```
lib/
├── main.dart                  
├── theme/
│   └── app_theme.dart         
├── models/
│   └── models.dart            
├── data/
│   └── mock_data.dart         
├── widgets/
│   └── shared_widgets.dart    
└── screens/
    ├── onboarding_screen.dart  
    ├── main_shell.dart         
    ├── home_screen.dart        
    ├── explore_screen.dart     
    ├── event_detail_screen.dart
    ├── communities_screen.dart 
    ├── chats_screen.dart       
    ├── create_post_screen.dart 
    └── profile_screen.dart    
```

---

## Design System


### Typography
- **Display / Headings** — Weight 800, tight letter-spacing (`-0.5` to `-0.8`)
- **Body** — Weight 400–600, line-height `1.5–1.7`
- **Labels / Captions** — Weight 500–700, `10–12px`, uppercase-free

### Design Principles
1. **Dark-first** — Optimized for low-light use, common in evening campus events
2. **Amber as the single brand signal** — All primary actions use amber; accent colors are reserved for semantic meaning (status, category)
3. **Cards with left accent bars** — Used in explore feed to visually communicate event type at a glance
4. **Gradient hero tiles** — Featured event cards use color-coded gradient backgrounds derived from event type
5. **Animated state transitions** — Join/RSVP buttons animate between states using `AnimatedContainer`

---

## Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform mobile development |
| Dart | Programming language |
| Provider *(planned)* | App-wide state management |
| SharedPreferences *(planned)* | Persist RSVP state, saved events, user preferences |
| Firebase / Firestore *(optional)* | Authentication and real-time data |

---

## Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- Dart `>=3.0.0`
- Android Studio / Xcode / VS Code with Flutter extension

### Installation

```bash
# Clone the repository
git clone https://github.com/frankmusiime/ALU_connect.git
cd alu-connect

# Install dependencies
flutter pub get

# Run on connected device or emulator
flutter run
```

### Run on specific platform
```bash
flutter run -d android
flutter run -d ios
flutter run -d chrome   # Web (for development preview only)
```

---

## State Management Approach

Currently the app uses **local `setState`** for all interactive UI — RSVP toggles, join/leave communities, message sending, and filter selections. This was chosen to keep the codebase readable and self-contained during the prototype phase.

The architecture is ready to migrate to **Provider** or **Riverpod**:
- `models/models.dart` contains clean, mutable model classes
- Screens consume `MockData` as a single source of truth
- Replacing `MockData` with a `ChangeNotifier` provider requires only swapping the data layer

Planned persistent state (via `SharedPreferences`):
- RSVP status per event
- Saved / bookmarked events
- Joined communities
- Selected interests from onboarding

---

## Navigation Structure

```
App
└── OnboardingScreen  (unauthenticated)
    └── MainShell  (authenticated)
        ├── HomeScreen          [tab 0]
        ├── ExploreScreen       [tab 1]
        │   └── EventDetailScreen  (push)
        ├── CommunitiesScreen   [tab 2]  ← center tab (+ FAB)
        ├── ChatsScreen         [tab 3]
        │   └── ChatRoomScreen     (push)
        └── ProfileScreen       [tab 4]

FAB (center)
└── CreatePostScreen  (modal push)
```

---

## Team Contributions

| Member | Branch | Responsibilities |
|---|---|---|
| — | `feature/onboarding` | Onboarding, login screens |
| — | `feature/home` | Home dashboard, featured cards |
| — | `feature/explore` | Explore feed, filters, event detail |
| — | `feature/communities` | Community list, detail sheet |
| — | `feature/chats` | Chat list, chat room, messaging |
| — | `feature/profile` | Profile, RSVPs, settings |


---

## License

This project was created as a formative assignment for the ALU Mobile Development course. All rights reserved by the team.
