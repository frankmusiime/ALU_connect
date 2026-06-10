import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

// Helper: map event type or organizer to an icon
IconData getEventIcon(EventModel e) {
  switch (e.type) {
    case EventType.event:
      return Icons.calendar_today;
    case EventType.opportunity:
      return Icons.work;
    case EventType.workshop:
      return Icons.build;
    case EventType.competition:
      return Icons.emoji_events;
    case EventType.announcement:
      return Icons.campaign;
  }
}

// Helper: map community name to an icon
IconData getCommunityIcon(CommunityModel c) {
  final name = c.name.toLowerCase();
  if (name.contains('debate')) return Icons.mic;
  if (name.contains('entrepreneur') || name.contains('startup')) return Icons.rocket_launch;
  if (name.contains('design') || name.contains('product')) return Icons.palette;
  if (name.contains('climate') || name.contains('sustain')) return Icons.eco;
  if (name.contains('finance') || name.contains('investment')) return Icons.account_balance;
  if (name.contains('tech') || name.contains('innovation')) return Icons.computer;
  return Icons.group;
}

// ─── Avatar Widget ────────────────────────────────────────────────────────────
class AvatarWidget extends StatelessWidget {
  final String emoji;
  final Color color;
  final double size;
  final bool showBorder;

  const AvatarWidget({
    super.key,
    required this.emoji,
    required this.color,
    this.size = 40,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withAlpha((0.2 * 255).round()),
        shape: BoxShape.circle,
        border: showBorder
            ? Border.all(color: AppColors.amber, width: 2.5)
            : Border.all(
                color: color.withAlpha((0.4 * 255).round()),
                width: 1.5,
              ),
      ),
      child: Center(
        child: Text(emoji, style: TextStyle(fontSize: size * 0.45)),
      ),
    );
  }
}

// ─── Tag Chip ──────────────────────────────────────────────────────────────────
class TagChip extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? bgColor;
  final double fontSize;

  const TagChip({
    super.key,
    required this.label,
    this.color,
    this.bgColor,
    this.fontSize = 11,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.textSecondary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor ?? c.withAlpha((0.15 * 255).round()),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.withAlpha((0.3 * 255).round())),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: c,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

// ─── Event Type Badge ──────────────────────────────────────────────────────────
class EventTypeBadge extends StatelessWidget {
  final EventModel event;

  const EventTypeBadge({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: event.typeBgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: event.typeColor.withAlpha((0.4 * 255).round()),
        ),
      ),
      child: Text(
        event.typeLabel,
        style: TextStyle(
          color: event.typeColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// ─── Section Header ────────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionLabel!,
                style: const TextStyle(
                  color: AppColors.amber,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Event Card (Featured / Large) ────────────────────────────────────────────
class FeaturedEventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback onTap;

  const FeaturedEventCard({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final gradients = [
      [const Color(0xFF1A3A5C), const Color(0xFF0D1F35)],
      [const Color(0xFF1A3D2E), const Color(0xFF0D2018)],
      [const Color(0xFF3D1F5C), const Color(0xFF1F0D35)],
      [const Color(0xFF5C2A1A), const Color(0xFF350D00)],
    ];
    final grad = gradients[event.id.hashCode % gradients.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: grad,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: event.imageUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: event.imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: AppColors.surfaceElevated,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: AppColors.amber,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Container(color: AppColors.surfaceElevated),
                            )
                          : Container(color: AppColors.surfaceElevated),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withAlpha((0.20 * 255).round()),
                              Colors.black.withAlpha((0.62 * 255).round()),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: EventTypeBadge(event: event),
                    ),
                    if (event.isSaved)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.amber,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.bookmark,
                            size: 14,
                            color: AppColors.background,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        BootstrapIcons.calendar,
                        size: 13,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _formatDate(event.date),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        BootstrapIcons.geo_alt,
                        size: 13,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          event.location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _statBubble(
                        '${event.goingCount}',
                        'going',
                        AppColors.teal,
                      ),
                      const SizedBox(width: 8),
                      _statBubble(
                        '${event.interestedCount}',
                        'interested',
                        AppColors.amber,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statBubble(String count, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha((0.12 * 255).round()),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha((0.3 * 255).round())),
      ),
      child: Text(
        '$count $label',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  String _formatDate(DateTime d) {
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
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
  }
}

// ─── Compact Event Row ─────────────────────────────────────────────────────────
class CompactEventRow extends StatelessWidget {
  final EventModel event;
  final VoidCallback onTap;

  const CompactEventRow({super.key, required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: event.typeColor.withAlpha((0.15 * 255).round()),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: event.typeColor.withAlpha((0.3 * 255).round()),
                ),
              ),
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: event.typeColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.lerp(event.typeColor, Colors.black, 0.12)!,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      getEventIcon(event),
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      EventTypeBadge(event: event),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        BootstrapIcons.calendar,
                        size: 12,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(event.date),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        BootstrapIcons.geo_alt,
                        size: 12,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d) {
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

// ─── Community Card ────────────────────────────────────────────────────────────
class CommunityCard extends StatefulWidget {
  final CommunityModel community;

  const CommunityCard({super.key, required this.community});

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: widget.community.accentColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.lerp(widget.community.accentColor, Colors.black, 0.12)!,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: widget.community.accentColor.withAlpha(
                  (0.28 * 255).round(),
                ),
              ),
            ),
            child: Center(
              child: Icon(
                  getCommunityIcon(widget.community),
                  color: Colors.white,
                  size: 24,
                ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.community.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${widget.community.memberCount} members',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.community.isJoined = !widget.community.isJoined;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: widget.community.isJoined
                    ? AppColors.surfaceElevated
                    : AppColors.amber,
                borderRadius: BorderRadius.circular(10),
                border: widget.community.isJoined
                    ? Border.all(color: AppColors.border)
                    : null,
              ),
              child: Text(
                widget.community.isJoined ? 'Joined' : 'Join',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: widget.community.isJoined
                      ? AppColors.textSecondary
                      : AppColors.background,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── RSVP Button ──────────────────────────────────────────────────────────────
class RSVPButton extends StatefulWidget {
  final EventModel event;
  final bool expanded;

  const RSVPButton({super.key, required this.event, this.expanded = false});

  @override
  State<RSVPButton> createState() => _RSVPButtonState();
}

class _RSVPButtonState extends State<RSVPButton> {
  @override
  Widget build(BuildContext context) {
    final isGoing = widget.event.rsvpStatus == RSVPStatus.going;
    final isInterested = widget.event.rsvpStatus == RSVPStatus.interested;

    if (widget.expanded) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  widget.event.rsvpStatus = isGoing
                      ? RSVPStatus.none
                      : RSVPStatus.going;
                });
              },
              icon: Icon(
                isGoing ? Icons.check_circle : Icons.check_circle_outline,
                size: 18,
              ),
              label: Text(isGoing ? "You're Going! ✓" : "RSVP – I'm Going"),
              style: ElevatedButton.styleFrom(
                backgroundColor: isGoing ? AppColors.teal : AppColors.amber,
                foregroundColor: AppColors.background,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  widget.event.rsvpStatus = isInterested
                      ? RSVPStatus.none
                      : RSVPStatus.interested;
                });
              },
              icon: Icon(
                isInterested ? Icons.star : Icons.star_border,
                size: 18,
              ),
              label: Text(
                isInterested ? 'Marked Interested' : 'Mark Interested',
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: isInterested
                    ? AppColors.amber
                    : AppColors.textSecondary,
                side: BorderSide(
                  color: isInterested ? AppColors.amber : AppColors.border,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isGoing
            ? AppColors.teal.withAlpha((0.2 * 255).round())
            : isInterested
            ? AppColors.amber.withAlpha((0.2 * 255).round())
            : AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isGoing
              ? AppColors.teal.withAlpha((0.5 * 255).round())
              : isInterested
              ? AppColors.amber.withAlpha((0.5 * 255).round())
              : AppColors.border,
        ),
      ),
      child: Text(
        isGoing
            ? 'Going ✓'
            : isInterested
            ? 'Interested ★'
            : 'RSVP',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: isGoing
              ? AppColors.teal
              : isInterested
              ? AppColors.amber
              : AppColors.textSecondary,
        ),
      ),
    );
  }
}

// ─── Notification Badge ────────────────────────────────────────────────────────
class NotifBadge extends StatelessWidget {
  final int count;
  final Widget child;

  const NotifBadge({super.key, required this.count, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (count > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.coral,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                count > 9 ? '9+' : '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
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

// ─── Responsive Button ──────────────────────────────────────────────────────
class ResponsiveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool fullWidth;
  final ButtonStyle? style;

  const ResponsiveButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.fullWidth = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    double vertical = 14;
    double fontSize = 15;
    if (w > 1000) {
      vertical = 18;
      fontSize = 17;
    } else if (w > 600) {
      vertical = 16;
      fontSize = 16;
    }

    final mergedStyle =
        style ??
        ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: vertical, horizontal: 20),
          textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        );

    Widget button = ElevatedButton(
      onPressed: onPressed,
      style: mergedStyle,
      child: child,
    );

    if (fullWidth) return SizedBox(width: double.infinity, child: button);
    return button;
  }
}

// ─── Gradient ALU Logo ─────────────────────────────────────────────────────────
class ALULogo extends StatelessWidget {
  final double size;
  const ALULogo({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.amber, AppColors.amberDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * 0.25),
      ),
      child: Center(
        child: Text(
          '∧',
          style: TextStyle(
            color: AppColors.background,
            fontSize: size * 0.55,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

// ─── Search Bar ────────────────────────────────────────────────────────────────
class AppSearchBar extends StatelessWidget {
  final String hint;
  final Function(String)? onChanged;
  final EdgeInsetsGeometry? margin;

  const AppSearchBar({
    super.key,
    this.hint = 'Search opportunities, events, people...',
    this.onChanged,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
          prefixIcon: const Icon(
            BootstrapIcons.search,
            color: AppColors.textMuted,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}

// ─── Filter Chips Row ──────────────────────────────────────────────────────────
class FilterChipsRow extends StatefulWidget {
  final List<String> options;
  final Function(String)? onSelected;

  const FilterChipsRow({super.key, required this.options, this.onSelected});

  @override
  State<FilterChipsRow> createState() => _FilterChipsRowState();
}

class _FilterChipsRowState extends State<FilterChipsRow> {
  String _selected = '';

  @override
  void initState() {
    super.initState();
    _selected = widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: widget.options.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final opt = widget.options[i];
          final isSelected = _selected == opt;
          return GestureDetector(
            onTap: () {
              setState(() => _selected = opt);
              widget.onSelected?.call(opt);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.amber : AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.amber : AppColors.border,
                ),
              ),
              child: Text(
                opt,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? AppColors.background
                      : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
