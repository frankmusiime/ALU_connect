import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/app_state.dart';
import 'create_post_screen.dart';
import 'home_screen.dart';
import 'explore_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';

/// Main navigation shell with bottom tab bar
class MainShell extends StatefulWidget {
  final AppState appState;

  const MainShell({super.key, required this.appState});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.appState.selectedNavIndex == 2
        ? 0
        : widget.appState.selectedNavIndex;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<void>(
      canPop: _selectedIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
            widget.appState.setSelectedNavIndex(0);
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  /// Build the body based on selected index
  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen(appState: widget.appState);
      case 1:
        return ExploreScreen(appState: widget.appState);
      case 3:
        return ChatsScreen(appState: widget.appState);
      case 4:
        return ProfileScreen(appState: widget.appState);
      default:
        return HomeScreen(appState: widget.appState);
    }
  }

  /// Build bottom navigation bar
  Widget _buildBottomNav() {
    final unreadCount = widget.appState.getTotalUnreadMessages();

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreatePostScreen()),
            );
            return;
          }

          setState(() {
            _selectedIndex = index;
            widget.appState.setSelectedNavIndex(index);
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(BootstrapIcons.house),
            selectedIcon: const Icon(BootstrapIcons.house_fill),
            label: 'Home',
          ),
          NavigationDestination(
            icon: const Icon(BootstrapIcons.compass),
            selectedIcon: const Icon(BootstrapIcons.compass_fill),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: const Icon(BootstrapIcons.plus_circle),
            selectedIcon: const Icon(BootstrapIcons.plus_circle),
            label: 'Post',
          ),
          NavigationDestination(
            icon: _buildChatBadge(unreadCount, BootstrapIcons.chat_dots),
            selectedIcon: _buildChatBadge(
              unreadCount,
              BootstrapIcons.chat_dots_fill,
            ),
            label: 'Chats',
          ),
          NavigationDestination(
            icon: const Icon(BootstrapIcons.person),
            selectedIcon: const Icon(BootstrapIcons.person_fill),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  /// Build chat icon with badge
  Widget _buildChatBadge(int unreadCount, IconData iconData) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(iconData),
        if (unreadCount > 0)
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.coral,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                unreadCount > 9 ? '9+' : '$unreadCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
