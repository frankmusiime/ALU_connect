import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
//import '../models/models.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String _selectedType = 'Event';
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedCategory = 'Select category';
  String _selectedLocation = 'Kigali Campus';
  bool _isPosting = false;

  final List<String> _categories = [
    'Entrepreneurship',
    'Technology',
    'Leadership',
    'Academics',
    'Social Impact',
    'Arts & Culture',
    'Sports',
    'Other',
  ];

  final List<String> _locations = [
    'Kigali Campus',
    'Mauritius Campus',
    'Online',
    'Both Campuses',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Create Post'),
        leading: IconButton(
          icon: const Icon(Icons.close, size: 22),
          onPressed: () => Navigator.pop(context),
          color: AppColors.textSecondary,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: _isPosting
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.amber,
                      strokeWidth: 2,
                    ),
                  )
                : GestureDetector(
                    onTap: _publish,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Publish',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.border),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type Toggle
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: ['Event', 'Opportunity'].map((type) {
                  final isSelected = _selectedType == type;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedType = type),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.amber
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text(
                          type,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? AppColors.background
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // Cover image
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.border,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.amber.withAlpha((0.15 * 255).round()),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add_photo_alternate_outlined,
                        color: AppColors.amber,
                        size: 26,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Add cover image',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'PNG, JPG up to 5MB',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            _FormLabel(label: 'Title'),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: 'e.g. Leadership Workshop',
                filled: true,
                fillColor: AppColors.surfaceElevated,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.amber,
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            _FormLabel(label: 'Description'),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              maxLines: 4,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: 'Tell people more about this event...',
                filled: true,
                fillColor: AppColors.surfaceElevated,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.amber,
                    width: 1.5,
                  ),
                ),
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 16),

            // Date & Time
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FormLabel(label: 'Date & Time'),
                      const SizedBox(height: 8),
                      _DropdownButton(
                        icon: BootstrapIcons.calendar,
                        value: 'June 5, 2026',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _FormLabel(label: 'Location'),
            const SizedBox(height: 8),
            _DropdownSelector(
              icon: BootstrapIcons.geo_alt,
              selected: _selectedLocation,
              options: _locations,
              onSelected: (v) => setState(() => _selectedLocation = v),
            ),

            const SizedBox(height: 16),

            _FormLabel(label: 'Category'),
            const SizedBox(height: 8),
            _DropdownSelector(
              icon: BootstrapIcons.tag,
              selected: _selectedCategory,
              options: _categories,
              onSelected: (v) => setState(() => _selectedCategory = v),
            ),

            const SizedBox(height: 32),

              ResponsiveButton(
                fullWidth: true,
                onPressed: _publish,
                child: const Text('Publish'),
              ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _publish() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please add a title'),
          backgroundColor: AppColors.coral,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }
    setState(() => _isPosting = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isPosting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('🎉 Your post is live!'),
          backgroundColor: AppColors.teal,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      Navigator.pop(context);
    }
  }
}

class _FormLabel extends StatelessWidget {
  final String label;

  const _FormLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    );
  }
}

class _DropdownButton extends StatelessWidget {
  final IconData icon;
  final String value;
  final VoidCallback onTap;

  const _DropdownButton({
    required this.icon,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textMuted, size: 18),
            const SizedBox(width: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textMuted,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownSelector extends StatelessWidget {
  final IconData icon;
  final String selected;
  final List<String> options;
  final Function(String) onSelected;

  const _DropdownSelector({
    required this.icon,
    required this.selected,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (ctx) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              ...options.map(
                (o) => ListTile(
                  title: Text(
                    o,
                    style: TextStyle(
                      color: o == selected
                          ? AppColors.amber
                          : AppColors.textPrimary,
                      fontWeight: o == selected
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                  trailing: o == selected
                      ? const Icon(
                          Icons.check,
                          color: AppColors.amber,
                          size: 18,
                        )
                      : null,
                  onTap: () {
                    onSelected(o);
                    Navigator.pop(ctx);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textMuted, size: 18),
            const SizedBox(width: 10),
            Text(
              selected,
              style: TextStyle(
                fontSize: 14,
                color: selected.startsWith('Select')
                    ? AppColors.textMuted
                    : AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textMuted,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
