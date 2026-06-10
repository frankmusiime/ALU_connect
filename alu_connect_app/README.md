# ALU Connect 🌍

> **Connect. Collaborate. Lead together.**

A mobile-first campus engagement platform for the African Leadership University ecosystem — built with Flutter.

---

## Overview

ALU Connect is a digital campus hub that centralizes student engagement, leadership opportunities, community participation, and communication within ALU. Instead of fragmented WhatsApp groups, email threads, and physical notice boards, students and leaders interact through one unified mobile experience.

The app mirrors the structure of the physical ALU campus, making navigation intuitive and contextually familiar. It is designed to increase event visibility, reduce communication delays, and foster meaningful connections across both Kigali and Mauritius campuses.

---

## Screenshots

| Onboarding | Home | Explore |
|---|---|---|
| Sign in & interest selection | Personalized dashboard | Filtered event feed |

| Event Detail | Communities | Chats |
|---|---|---|
| RSVP flow + capacity bar | Join/leave clubs | Real-time messaging |

| Create Post | Profile | My RSVPs |
|---|---|---|
| Event & opportunity creation | Stats, badges & settings | Activity tracker |

---

## Features

### ✅ Minimum Requirements
| Requirement | Implementation |
|---|---|
| Authentication / Onboarding | 3-page onboarding + login screen with ALU email, Google & Apple sign-in |
| Dynamic Feed | Personalized home dashboard + filterable explore feed |
| RSVP / Participation | Going / Interested states with capacity progress bar |
| Lightweight Chat | Group chat rooms with file attachments and real-time send |
| Profile / Identity | User profile with stats, badges, interests, and RSVP history |
| Navigation & State | Bottom nav shell + Provider-ready state across all screens |

### ⭐ Additional Features
- **Campus Directory** — Browse student leaders, club executives, and coaches
- **Engagement Badges** — Earned for community building, opportunity hunting, early adoption
- **Create Post flow** — Role-gated event and opportunity publishing with cover image, date picker, location and category selectors
- **Save & Share** — Bookmark any event; share from detail screen
- **Smart filter chips** — Filter explore feed by All / Events / Opportunities / Workshops / Clubs
- **Empty state handling** — Every list has a clear, actionable empty state
- **Snackbar feedback** — Every user action (save, RSVP, join, publish) gives immediate visual confirmation
- **Capacity bar** — Visual indicator of how many spots remain on each event

---

## Project Structure

```
lib/
├── main.dart                  # App entry point
├── theme/
│   └── app_theme.dart         # Color palette, typography, component themes
├── models/
│   └── models.dart            # Data models: User, Event, Community, Message, Chat
├── data/
│   └── mock_data.dart         # All mock data (users, events, communities, chats)
├── widgets/
│   └── shared_widgets.dart    # Reusable components (cards, chips, avatars, buttons)
└── screens/
    ├── onboarding_screen.dart  # 3-step onboarding + login
    ├── main_shell.dart         # Bottom nav shell + FAB
    ├── home_screen.dart        # Personalized dashboard
    ├── explore_screen.dart     # Searchable, filterable feed
    ├── event_detail_screen.dart# Full event view + RSVP
    ├── communities_screen.dart # All clubs / My clubs tabs
    ├── chats_screen.dart       # Chat list + chat room
    ├── create_post_screen.dart # Event / opportunity creation form
    └── profile_screen.dart     # Profile, saved, activity, settings
```

---

## Design System

### Color Palette
| Token | Hex | Usage |
|---|---|---|
| `background` | `#0D0F1A` | App background |
| `surface` | `#151829` | Cards, bottom nav |
| `surfaceElevated` | `#1C2035` | Inputs, dropdowns |
| `amber` | `#FFC107` | Primary accent, CTAs |
| `teal` | `#00BFA5` | Going status, success states |
| `purple` | `#7C4DFF` | Workshops, secondary accent |
| `coral` | `#FF5252` | Competitions, errors |
| `blue` | `#448AFF` | Events, links |

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
git clone https://github.com/your-team/alu-connect.git
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

> Each member should commit to their branch and open a pull request for review before merging to `main`.

---

## AI Usage Disclosure

AI tools were used in this project for:
- **Brainstorming** feature ideas and UX flows relevant to the ALU context
- **Boilerplate generation** for repetitive widget structures (e.g., list tiles, info cards)
- **Debugging** layout and state issues

All submitted code has been reviewed, understood, and is explainable by every team member. No AI-generated code was submitted without full comprehension of its logic and design rationale.

---

## Known Limitations & Roadmap

| Limitation | Planned Fix |
|---|---|
| Mock data only | Integrate Firestore for live events and messaging |
| No push notifications | Add Firebase Cloud Messaging |
| No image upload | Integrate Firebase Storage or Supabase Storage |
| No role-based auth | Implement role gating on `CreatePostScreen` |
| Chat is local state only | Migrate to Firestore real-time streams |

---

## License

This project was created as a formative assignment for the ALU Mobile Development course. All rights reserved by the team.
