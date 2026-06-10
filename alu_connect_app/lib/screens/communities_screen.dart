import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../services/app_state.dart';
import '../models/models.dart';

class CommunitiesScreen extends StatefulWidget {
  final AppState appState;

  const CommunitiesScreen({super.key, required this.appState});

  @override
  State<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends State<CommunitiesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allCommunities = widget.appState.communities;
    final myCommunities = allCommunities.where((c) => c.isJoined).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Communities',
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
                      color: AppColors.amber,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.background,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),

            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
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
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'All Clubs'),
                  Tab(text: 'My Clubs'),
                ],
              ),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // All communities
                  _buildCommunityList(allCommunities),
                  // My communities
                  myCommunities.isEmpty
                      ? _buildEmptyJoined()
                      : _buildCommunityList(myCommunities),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityList(List<CommunityModel> communities) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: communities.length,
      itemBuilder: (context, i) {
        final c = communities[i];
        return GestureDetector(
          onTap: () => _showCommunityDetail(c),
          child: CommunityCard(community: c),
        );
      },
    );
  }

  Widget _buildEmptyJoined() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
              ),
              child: const Center(
                child: Text('👥', style: TextStyle(fontSize: 32)),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No communities yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore and join communities that match your interests',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showCommunityDetail(CommunityModel community) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _CommunityDetailSheet(community: community),
    );
  }
}

class _CommunityDetailSheet extends StatefulWidget {
  final CommunityModel community;

  const _CommunityDetailSheet({required this.community});

  @override
  State<_CommunityDetailSheet> createState() => _CommunityDetailSheetState();
}

class _CommunityDetailSheetState extends State<_CommunityDetailSheet> {
  @override
  Widget build(BuildContext context) {
    final c = widget.community;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: c.accentColor.withAlpha((0.15 * 255).round()),
              shape: BoxShape.circle,
              border: Border.all(
                color: c.accentColor.withAlpha((0.3 * 255).round()),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(c.iconEmoji, style: const TextStyle(fontSize: 32)),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            c.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${c.memberCount} members',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            c.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: c.tags
                .map((t) => TagChip(label: t, color: c.accentColor))
                .toList(),
          ),
          const SizedBox(height: 24),
          ResponsiveButton(
            fullWidth: true,
            onPressed: () {
              setState(() {
                c.isJoined = !c.isJoined;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: c.isJoined
                  ? AppColors.surfaceElevated
                  : c.accentColor,
              foregroundColor: c.isJoined
                  ? AppColors.textPrimary
                  : Colors.white,
              side: c.isJoined
                  ? const BorderSide(color: AppColors.border)
                  : null,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(c.isJoined ? 'Leave Community' : 'Join Community'),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
