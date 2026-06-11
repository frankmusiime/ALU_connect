# ALU Connect — Presentation Scripts

5 presenters · ~45–60 seconds each · Tap as you talk.

---

## 1. Home  🏠
> *Presenter intro:* "This is the **Home dashboard** — the first thing a student sees after signing in."

**Demo (tap in this order):**
1. Point to the personalized greeting — "Hi, [name]!".
2. Scroll the featured/upcoming events.
3. Use the search bar to filter events live.
4. Tap a quick shortcut into **Communities**.

**Say:**
- "Home pulls everything important into one feed — no more scattered WhatsApp groups or email threads."
- "Events are personalized and searchable in real time by title, organizer, or location."
- "It's the launchpad — from here you can jump straight to events or communities."

**Tech note:** Built with a `CustomScrollView` of slivers; the feed reads from a shared `AppState` so it stays in sync with every other screen.

---

## 2. Discover  🧭
> *Presenter intro:* "The **Discover (Explore)** tab is where students browse and filter everything happening on campus."

**Demo:**
1. Tap the filter chips: **All → Events → Opportunities → Workshops**.
2. Search for an event by name.
3. Tap a card to open **Event Details**, then RSVP (**Going / Interested**) and watch the capacity bar.
4. Show the empty state by searching for something that doesn't exist.

**Say:**
- "Color-coded cards and a left accent bar tell you the event type at a glance."
- "One tap to RSVP — the capacity bar shows how many spots are left."
- "Every list has a clean empty state, so the user is never stuck on a blank screen."

**Tech note:** Filtering is reactive `setState`; the RSVP status lives in `AppState`, so it's reflected in the user's profile and activity too.

---

## 3. Post  ➕
> *Presenter intro:* "The center **Post** button lets student leaders publish a new event or opportunity."

**Demo:**
1. Tap the center **+** in the nav bar — the Create Post form opens.
2. Toggle between **Event** and **Opportunity**.
3. Fill the title and description.
4. Pick a **category** and a **campus/location** (Kigali, Mauritius, Online, Both).
5. Hit publish and show the loading + confirmation snackbar.

**Say:**
- "Creating content is a guided form — type, title, category, and which campus it's for."
- "It supports both campuses, which matters for ALU's intercampus community."
- "Every action gives instant feedback through a snackbar."

**Tech note:** Opens as a modal route over the nav shell; form state is handled with `TextEditingController`s and validated before posting.

---

## 4. Chat  💬
> *Presenter intro:* "The **Chats** tab is our lightweight, real-time messaging."

**Demo:**
1. Show the chat list with unread badges.
2. Search for a conversation.
3. Open a chat room.
4. Type and send a message — it appears instantly and updates the list preview.

**Say:**
- "Group and direct chats keep event coordination in one place."
- "Unread counts surface right on the nav bar so nothing gets missed."
- "Sending a message updates both the conversation and the chat list in real time."

**Tech note:** Messages are stored per-chat in `AppState`; sending appends the message and rewrites the chat preview, then `notifyListeners()` repaints the UI.

---

## 5. Profile  👤
> *Presenter intro:* "The **Profile** tab is the student's identity and settings hub."

**Demo:**
1. Show the header — avatar, campus, class year, and stats (Events / Communities / Connections).
2. Point out the **engagement badges** and **interests**.
3. Switch tabs: **Activity → Saved → Settings**.
4. In **Settings**, flip the **Dark / Light mode** toggle — the whole app re-themes instantly.
5. Show **Sign Out**.

**Say:**
- "Profile shows your campus identity, engagement stats, and earned badges."
- "Activity tracks your RSVPs; Saved holds bookmarked events."
- "And we added a **light/dark mode toggle** — one switch re-themes every screen in the app."

**Tech note:** The theme switch flips a single flag in `AppState`; because `MaterialApp` is wrapped in an `AnimatedBuilder`, all colors rebuild from the active palette at once.

---

### Closing line (anyone)
> "Everything you saw runs on one shared state layer and a single design system — so it's consistent, fast, and ready to plug into a real backend like Firebase next."
