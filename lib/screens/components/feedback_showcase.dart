import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';

class FeedbackShowcase extends StatefulWidget {
  const FeedbackShowcase({super.key});

  @override
  State<FeedbackShowcase> createState() => _FeedbackShowcaseState();
}

class _FeedbackShowcaseState extends State<FeedbackShowcase> {
  bool _isLoading = false;
  double _progress = 0.0;
  int _currentStep = 0;

  void _showSnackbar(String msg, {Color? color, IconData? icon}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          if (icon != null) ...[Icon(icon, color: Colors.white, size: 18), const SizedBox(width: 8)],
          Text(msg),
        ]),
        backgroundColor: color ?? AppTheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(children: [
          Icon(Icons.info_rounded, color: AppTheme.primary),
          SizedBox(width: 8),
          Text('Information'),
        ]),
        content: const Text('This is an alert dialog. Use it to show important information to users.'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary, foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(children: [
          Icon(Icons.warning_amber_rounded, color: AppTheme.warning),
          SizedBox(width: 8),
          Text('Confirm Action'),
        ]),
        content: const Text('Are you sure you want to proceed? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.error, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              _showSnackbar('Action confirmed!', color: AppTheme.error, icon: Icons.check);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Bottom Sheet',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            const Text('This is a modal bottom sheet. Great for additional options or forms.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.textLight, fontSize: 13)),
            const SizedBox(height: 20),
            ...[
              {'icon': Icons.share_rounded, 'label': 'Share', 'color': AppTheme.primary},
              {'icon': Icons.edit_rounded, 'label': 'Edit', 'color': AppTheme.success},
              {'icon': Icons.delete_rounded, 'label': 'Delete', 'color': AppTheme.error},
            ].map((item) => ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (item['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 20),
              ),
              title: Text(item['label'] as String,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.chevron_right, color: AppTheme.textLight),
              onTap: () {
                Navigator.pop(context);
                _showSnackbar('${item['label']} tapped!');
              },
            )),
          ],
        ),
      ),
    );
  }

  Future<void> _simulateProgress() async {
    setState(() => _progress = 0.0);
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) setState(() => _progress = i / 10);
    }
    if (mounted) _showSnackbar('Upload complete! ✓', color: AppTheme.success);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEDD5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(children: [
              Icon(Icons.feedback_rounded, color: Color(0xFFEA580C), size: 28),
              SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Feedback Components',
                    style: TextStyle(color: Color(0xFFEA580C), fontWeight: FontWeight.bold, fontSize: 15)),
                Text('Dialogs, snackbars & progress',
                    style: TextStyle(color: Color(0xFFEA580C), fontSize: 12)),
              ]),
            ]),
          ),
          const SizedBox(height: 20),

          // Dialogs
          _sectionHeader('Dialogs', Icons.open_in_new_rounded),
          const SizedBox(height: 12),
          _card(isDark: isDark, child: Column(children: [
            _actionRow(
              'Alert Dialog',
              'Show information to users',
              Icons.info_rounded,
              AppTheme.primary,
              'Show',
              _showAlertDialog,
            ),
            const Divider(),
            _actionRow(
              'Confirm Dialog',
              'Ask for user confirmation',
              Icons.warning_amber_rounded,
              AppTheme.warning,
              'Show',
              _showConfirmDialog,
            ),
            const Divider(),
            _actionRow(
              'Bottom Sheet',
              'Slide-up modal with options',
              Icons.vertical_align_bottom_rounded,
              AppTheme.success,
              'Show',
              _showBottomSheet,
            ),
          ])),
          const SizedBox(height: 20),

          // Snackbars
          _sectionHeader('Snackbars', Icons.notifications_rounded),
          const SizedBox(height: 12),
          _card(isDark: isDark, child: Column(children: [
            _actionRow('Success', 'Operation completed', Icons.check_circle_rounded,
                AppTheme.success, 'Show',
                () => _showSnackbar('Operation successful! ✓', color: AppTheme.success, icon: Icons.check_circle_rounded)),
            const Divider(),
            _actionRow('Error', 'Something went wrong', Icons.error_rounded,
                AppTheme.error, 'Show',
                () => _showSnackbar('Something went wrong! ✗', color: AppTheme.error, icon: Icons.error_rounded)),
            const Divider(),
            _actionRow('Warning', 'Proceed with caution', Icons.warning_amber_rounded,
                AppTheme.warning, 'Show',
                () => _showSnackbar('Warning: Please review!', color: AppTheme.warning, icon: Icons.warning_amber_rounded)),
            const Divider(),
            _actionRow('Info', 'General information', Icons.info_rounded,
                AppTheme.primary, 'Show',
                () => _showSnackbar('Here is some info for you!', icon: Icons.info_rounded)),
          ])),
          const SizedBox(height: 20),

          // Progress
          _sectionHeader('Progress Indicators', Icons.downloading_rounded),
          const SizedBox(height: 12),
          _card(isDark: isDark, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Linear Progress', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _progress,
                      minHeight: 10,
                      backgroundColor: AppTheme.accent.withValues(alpha: 0.3),
                      valueColor: const AlwaysStoppedAnimation(AppTheme.primary),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text('${(_progress * 100).toInt()}%',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary)),
              ]),
              const SizedBox(height: 10),
              CustomButton(
                label: 'Simulate Upload',
                fullWidth: true,
                icon: Icons.upload_rounded,
                onPressed: _simulateProgress,
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),
              const Text('Circular Progress', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(children: [
                  const SizedBox(
                    width: 50, height: 50,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      valueColor: AlwaysStoppedAnimation(AppTheme.primary),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Indeterminate', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                ]),
                Column(children: [
                  SizedBox(
                    width: 50, height: 50,
                    child: CircularProgressIndicator(
                      value: _progress,
                      strokeWidth: 5,
                      valueColor: const AlwaysStoppedAnimation(AppTheme.success),
                      backgroundColor: AppTheme.success.withValues(alpha: 0.2),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Determinate', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                ]),
                Column(children: [
                  const SizedBox(
                    width: 50, height: 50,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      valueColor: AlwaysStoppedAnimation(AppTheme.warning),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Loading', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                ]),
              ]),
            ],
          )),
          const SizedBox(height: 20),

          // Step Progress
          _sectionHeader('Step Progress', Icons.linear_scale_rounded),
          const SizedBox(height: 12),
          _card(isDark: isDark, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(4, (i) {
                final done = i < _currentStep;
                final active = i == _currentStep;
                return Row(children: [
                  GestureDetector(
                    onTap: () => setState(() => _currentStep = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: done
                            ? AppTheme.success
                            : active
                                ? AppTheme.primary
                                : AppTheme.accent.withValues(alpha: 0.3),
                      ),
                      child: Center(
                        child: done
                            ? const Icon(Icons.check, color: Colors.white, size: 16)
                            : Text('${i + 1}',
                                style: TextStyle(
                                    color: active ? Colors.white : AppTheme.textLight,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                      ),
                    ),
                  ),
                  if (i < 3)
                    Container(
                      width: 40, height: 2,
                      color: i < _currentStep
                          ? AppTheme.success
                          : AppTheme.accent.withValues(alpha: 0.3),
                    ),
                ]);
              })),
              const SizedBox(height: 12),
              Text(
                ['Personal Info', 'Account Setup', 'Preferences', 'Complete!'][_currentStep],
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Row(children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => _currentStep--),
                      child: const Text('Back'),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 10),
                if (_currentStep < 3)
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: Colors.white),
                      onPressed: () => setState(() => _currentStep++),
                      child: const Text('Next'),
                    ),
                  ),
                if (_currentStep == 3)
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.success,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        setState(() => _currentStep = 0);
                        _showSnackbar('Setup complete! 🎉', color: AppTheme.success);
                      },
                      child: const Text('Finish'),
                    ),
                  ),
              ]),
            ],
          )),
        ],
      ),
    );
  }

  Widget _actionRow(String title, String subtitle, IconData icon,
      Color color, String btnLabel, VoidCallback onTap) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          Text(subtitle, style: const TextStyle(fontSize: 11, color: AppTheme.textLight)),
        ],
      )),
      ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withValues(alpha: 0.1),
          foregroundColor: color,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(btnLabel, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ),
    ]);
  }

  Widget _sectionHeader(String title, IconData icon) {
    return Row(children: [
      Icon(icon, color: AppTheme.primary, size: 18),
      const SizedBox(width: 8),
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    ]);
  }

  Widget _card({required bool isDark, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF16213E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: child,
    );
  }
}