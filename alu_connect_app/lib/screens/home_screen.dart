import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../services/app_state.dart';
import '../models/models.dart';
import 'event_details.dart';

class HomeScreen extends StatefulWidget {
  final AppState appState;

  const HomeScreen({super.key, required this.appState});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  List<EventModel> get _filteredEvents {
    final query = _searchQuery.toLowerCase();
    if (query.isEmpty) return widget.appState.events;
    return widget.appState.events.where((e) {
      return e.title.toLowerCase().contains(query) ||
          e.organizer.toLowerCase().contains(query) ||
          e.location.toLowerCase().contains(query) ||
          e.description.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.appState.currentUser;
    final events = _filteredEvents;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ─── Header ─────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'Hi, ${user?.name.split(' ').first ?? 'there'}! ',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const TextSpan(
                                  text: '👋',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            "What's happening today?",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Notifications
                    NotifBadge(
                      count: 3,
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Icon(
                          BootstrapIcons.bell,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    AvatarWidget(
                      emoji: '👩🏾‍💼',
                      color: AppColors.amber,
                      size: 42,
                      showBorder: true,
                    ),
                  ],
                ),
              ),
            ),

            // ─── Search ──────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: AppSearchBar(
                hint: 'Search opportunities, events, people...',
                onChanged: (value) => setState(() => _searchQuery = value),
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
            ),

            // ─── Quick Category Grid ─────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                child: Row(
                  children: [
                    _QuickFilter(
                      icon: BootstrapIcons.calendar,
                      label: 'Events',
                      color: AppColors.blue,
                    ),
                    const SizedBox(width: 8),
                    _QuickFilter(
                      icon: BootstrapIcons.briefcase,
                      label: 'Opportunities',
                      color: AppColors.teal,
                    ),
                    const SizedBox(width: 8),
                    _QuickFilter(
                      icon: BootstrapIcons.people,
                      label: 'Clubs',
                      color: AppColors.purple,
                    ),
                    const SizedBox(width: 8),
                    _QuickFilter(
                      icon: BootstrapIcons.book,
                      label: 'Academics',
                      color: AppColors.coral,
                    ),
                  ],
                ),
              ),
            ),

            if (_searchQuery.isEmpty) ...[
              // ─── Featured Section ─────────────────────────────────────────
              SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Featured',
                  actionLabel: 'See all',
                  onAction: () {},
                ),
              ),
              SliverToBoxAdapter(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final eventsList = widget.appState.events;
                    final cols = constraints.maxWidth > 1000
                        ? 3
                        : constraints.maxWidth > 700
                        ? 2
                        : 1;
                    const spacing = 16.0;
                    final availableWidth =
                        constraints.maxWidth - 40 - spacing * (cols - 1);
                    final cardWidth = availableWidth / cols;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: eventsList.map((e) {
                          return SizedBox(
                            width: cardWidth,
                            child: FeaturedEventCard(
                              event: e,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EventDetailsScreenWrapper(
                                    event: e,
                                    appState: widget.appState,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ] else ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Text(
                    '${events.length} result${events.length == 1 ? '' : 's'}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, i) {
                  if (i >= events.length) return null;
                  return CompactEventRow(
                    event: events[i],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventDetailsScreenWrapper(
                          event: events[i],
                          appState: widget.appState,
                        ),
                      ),
                    ),
                  );
                }, childCount: events.length),
              ),
            ],

            // ─── Stats Banner ─────────────────────────────────────────────
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            const SliverToBoxAdapter(
              child: SectionHeader(title: 'Latest Opportunities'),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final opp = widget.appState.events
                      .where(
                        (e) =>
                            e.type == EventType.opportunity ||
                            e.type == EventType.competition,
                      )
                      .toList();
                  if (i >= opp.length) return null;
                  return CompactEventRow(
                    event: opp[i],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventDetailsScreenWrapper(
                          event: opp[i],
                          appState: widget.appState,
                        ),
                      ),
                    ),
                  );
                },
                childCount: widget.appState.events
                    .where(
                      (e) =>
                          e.type == EventType.opportunity ||
                          e.type == EventType.competition,
                    )
                    .length,
              ),
            ),

            // ─── Stats Banner ─────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1A3D2E), Color(0xFF0D2018)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.teal.withAlpha((0.3 * 255).round()),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text('🌍', style: TextStyle(fontSize: 28)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sustainable Solutions Challenge',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 3),
                            const Text(
                              'Apply by May 28, 2026 • Mauritius Campus',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.teal,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Competition',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ─── Latest Opportunities ─────────────────────────────────────
            const SliverToBoxAdapter(
              child: SectionHeader(title: 'Latest Opportunities'),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final opp = events
                      .where(
                        (e) =>
                            e.type == EventType.opportunity ||
                            e.type == EventType.competition,
                      )
                      .toList();
                  if (i >= opp.length) return null;
                  return CompactEventRow(
                    event: opp[i],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventDetailsScreenWrapper(
                          event: opp[i],
                          appState: widget.appState,
                        ),
                      ),
                    ),
                  );
                },
                childCount: events
                    .where(
                      (e) =>
                          e.type == EventType.opportunity ||
                          e.type == EventType.competition,
                    )
                    .length,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _QuickFilter extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _QuickFilter({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withAlpha((0.12 * 255).round()),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withAlpha((0.25 * 255).round())),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
