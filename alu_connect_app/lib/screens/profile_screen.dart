import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../services/app_state.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import 'event_details.dart';

class ProfileScreen extends StatefulWidget {
  final AppState appState;

  const ProfileScreen({super.key, required this.appState});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.appState.currentUser ?? MockData.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(child: _buildProfileHeader(user)),
          ],
          body: Column(
            children: [
              // Tab bar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: AppColors.amber,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.background,
                  unselectedLabelColor: AppColors.textSecondary,
                  labelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(text: 'Activity'),
                    Tab(text: 'Saved'),
                    Tab(text: 'Settings'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildActivityTab(),
                    _buildSavedTab(),
                    _buildSettingsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(UserModel user) {
    return Column(
      children: [
        // Top bar
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Profile card
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A3A5C), Color(0xFF0D1F35)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    AvatarWidget(
                      emoji: '👩🏾‍💼',
                      color: AppColors.amber,
                      size: 64,
                      showBorder: true,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Icon(
                                BootstrapIcons.geo_alt,
                                size: 13,
                                color: AppColors.textMuted,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                user.campus,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${user.major} • ${user.cohort}',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.amber.withAlpha((0.15 * 255).round()),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.amber.withAlpha((0.3 * 255).round()),
                        ),
                      ),
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.amber,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Stats
                Row(
                  children: [
                    _ProfileStat(count: user.eventsAttended, label: 'Events'),
                    _Divider(),
                    _ProfileStat(
                      count: user.communitiesJoined,
                      label: 'Communities',
                    ),
                    _Divider(),
                    _ProfileStat(count: user.connections, label: 'Connections'),
                  ],
                ),

                const SizedBox(height: 20),

                // Badges
                Wrap(
                  runSpacing: 8,
                  children: [
                    ...MockData.badges.map(
                      (b) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: b.color.withAlpha((0.12 * 255).round()),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: b.color.withAlpha((0.3 * 255).round()),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                b.emoji,
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                b.label,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: b.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Interests
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Interests',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: user.interests
                    .map((i) => TagChip(label: i, color: AppColors.amber))
                    .toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildActivityTab() {
    final myEvents = widget.appState.events
        .where((e) => e.rsvpStatus != RSVPStatus.none)
        .toList();

    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Text(
            'My RSVPs',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        ...myEvents.map((e) => _RSVPRow(event: e)),
        if (myEvents.isEmpty)
          Padding(
            padding: EdgeInsets.all(40),
            child: Center(
              child: Text(
                "No RSVPs yet. Explore events!",
                style: TextStyle(color: AppColors.textMuted, fontSize: 14),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSavedTab() {
    final saved = widget.appState.events.where((e) => e.isSaved).toList();

    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      children: saved.isEmpty
          ? [
              Padding(
                padding: EdgeInsets.all(40),
                child: Center(
                  child: Text(
                    'No saved items yet',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                  ),
                ),
              ),
            ]
          : saved
                .map(
                  (e) => CompactEventRow(
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
                )
                .toList(),
    );
  }

  Widget _buildSettingsTab() {
    final items = [
      ('My Posts', BootstrapIcons.file_text, AppColors.blue),
      ('Notifications', BootstrapIcons.bell, AppColors.purple),
      ('Account Settings', BootstrapIcons.person_badge, AppColors.teal),
      ('Help & Support', BootstrapIcons.question_circle, AppColors.amber),
      ('Sign Out', BootstrapIcons.box_arrow_right, AppColors.coral),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildThemeToggle(),
        ...items.map((item) {
        final (label, icon, color) = item;
        final isSignOut = label == 'Sign Out';
        return Material(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: ListTile(
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withAlpha((0.15 * 255).round()),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              title: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSignOut ? AppColors.coral : AppColors.textPrimary,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: AppColors.textMuted,
                size: 18,
              ),
              onTap: () {
                if (isSignOut) {
                  widget.appState.logout();
                }
              },
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        );
        }),
      ],
    );
  }

  Widget _buildThemeToggle() {
    final isDark = widget.appState.isDarkMode;
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: SwitchListTile(
          value: isDark,
          onChanged: (v) => widget.appState.toggleTheme(v),
          activeThumbColor: AppColors.amber,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14),
          secondary: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.amber.withAlpha((0.15 * 255).round()),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isDark ? BootstrapIcons.moon_stars : BootstrapIcons.sun,
              color: AppColors.amber,
              size: 18,
            ),
          ),
          title: Text(
            isDark ? 'Dark Mode' : 'Light Mode',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final int count;
  final String label;

  const _ProfileStat({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '$count',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 32, width: 1, color: AppColors.border);
  }
}

class _RSVPRow extends StatelessWidget {
  final EventModel event;

  const _RSVPRow({required this.event});

  @override
  Widget build(BuildContext context) {
    final isGoing = event.rsvpStatus == RSVPStatus.going;
    final statusColor = isGoing ? AppColors.teal : AppColors.amber;
    final statusLabel = isGoing ? 'Going' : 'Interested';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withAlpha((0.15 * 255).round()),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: statusColor.withAlpha((0.3 * 255).round()),
              ),
            ),
            child: Text(
              isGoing ? '✓' : '★',
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  '${_fmtDate(event.date)} • ${event.location}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: statusColor.withAlpha((0.12 * 255).round()),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: statusColor.withAlpha((0.3 * 255).round()),
              ),
            ),
            child: Text(
              statusLabel,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmtDate(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[d.month - 1]} ${d.day}';
  }
}
