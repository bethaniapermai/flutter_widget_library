import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/custom_button.dart';
import '../../theme/app_theme.dart';

class ButtonShowcase extends StatefulWidget {
  const ButtonShowcase({super.key});

  @override
  State<ButtonShowcase> createState() => _ButtonShowcaseState();
}

class _ButtonShowcaseState extends State<ButtonShowcase> {
  bool _loading = false;
  int _clickCount = 0;

  void _showSnackbar(String message, {Color? color}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color ?? AppTheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showCodeDialog(String title, String code) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(children: [
          const Icon(Icons.code_rounded, color: AppTheme.primary),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 16)),
        ]),
        content: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1B4B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(code,
              style: const TextStyle(
                  color: Color(0xFFC4B5FD),
                  fontFamily: 'monospace',
                  fontSize: 12)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: code));
              Navigator.pop(context);
              _showSnackbar('Code copied to clipboard!');
            },
            child: const Text('Copy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _simulateLoad() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _loading = false);
      _showSnackbar('Action completed successfully! ✓',
          color: AppTheme.success);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Click counter card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primary, AppTheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(children: [
              const Icon(Icons.touch_app_rounded,
                  color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Interactive Demo',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                Text('Tap any button to see it in action',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12)),
              ]),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('$_clickCount taps',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ),
            ]),
          ),
          const SizedBox(height: 20),

          _sectionHeader('Filled Buttons', Icons.circle,
              'Primary action buttons', AppTheme.stat1, AppTheme.stat1Text),
          const SizedBox(height: 12),
          _buttonCard(
            label: 'Primary Button',
            description: 'Use for main call-to-action',
            child: CustomButton(
              label: 'Primary',
              onPressed: () {
                setState(() => _clickCount++);
                _showSnackbar('Primary button tapped!');
              },
            ),
            code: "CustomButton(\n  label: 'Primary',\n  onPressed: () {},\n)",
          ),
          const SizedBox(height: 10),
          _buttonCard(
            label: 'With Icon',
            description: 'Button with leading icon',
            child: CustomButton(
              label: 'Add Item',
              icon: Icons.add_rounded,
              onPressed: () {
                setState(() => _clickCount++);
                _showSnackbar('Item added! ✓', color: AppTheme.success);
              },
            ),
            code:
                "CustomButton(\n  label: 'Add Item',\n  icon: Icons.add,\n  onPressed: () {},\n)",
          ),
          const SizedBox(height: 10),
          _buttonCard(
            label: 'Loading State',
            description: 'Shows spinner during async operations',
            child: CustomButton(
              label: 'Submit',
              isLoading: _loading,
              onPressed: _simulateLoad,
            ),
            code:
                "CustomButton(\n  label: 'Submit',\n  isLoading: _loading,\n  onPressed: _submit,\n)",
          ),
          const SizedBox(height: 20),

          _sectionHeader('Outlined Buttons', Icons.radio_button_unchecked,
              'Secondary actions', AppTheme.stat2, AppTheme.stat2Text),
          const SizedBox(height: 12),
          _buttonCard(
            label: 'Outlined',
            description: 'Use for secondary actions',
            child: CustomButton(
              label: 'Cancel',
              variant: ButtonVariant.outlined,
              onPressed: () {
                setState(() => _clickCount++);
                _showSnackbar('Action cancelled');
              },
            ),
            code:
                "CustomButton(\n  label: 'Cancel',\n  variant: ButtonVariant.outlined,\n  onPressed: () {},\n)",
          ),
          const SizedBox(height: 10),
          _buttonCard(
            label: 'Outlined with Icon',
            description: 'Secondary action with icon',
            child: CustomButton(
              label: 'Edit',
              variant: ButtonVariant.outlined,
              icon: Icons.edit_rounded,
              onPressed: () {
                setState(() => _clickCount++);
                _showSnackbar('Edit mode activated ✏️');
              },
            ),
            code:
                "CustomButton(\n  label: 'Edit',\n  variant: ButtonVariant.outlined,\n  icon: Icons.edit,\n  onPressed: () {},\n)",
          ),
          const SizedBox(height: 20),

          _sectionHeader('Danger Button', Icons.warning_amber_rounded,
              'Destructive actions', AppTheme.stat3, AppTheme.stat3Text),
          const SizedBox(height: 12),
          _buttonCard(
            label: 'Danger',
            description: 'Use for destructive/irreversible actions',
            child: CustomButton(
              label: 'Delete',
              variant: ButtonVariant.danger,
              icon: Icons.delete_rounded,
              onPressed: () {
                setState(() => _clickCount++);
                _showSnackbar('Item deleted! 🗑️',
                    color: AppTheme.error);
              },
            ),
            code:
                "CustomButton(\n  label: 'Delete',\n  variant: ButtonVariant.danger,\n  icon: Icons.delete,\n  onPressed: () {},\n)",
          ),
          const SizedBox(height: 20),

          _sectionHeader('Full Width', Icons.width_full_rounded,
              'Stretch to container width', AppTheme.stat1, AppTheme.stat1Text),
          const SizedBox(height: 12),
          Container(
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
            child: Column(children: [
              CustomButton(
                label: 'Full Width Primary',
                fullWidth: true,
                icon: Icons.check_rounded,
                onPressed: () {
                  setState(() => _clickCount++);
                  _showSnackbar('Full width button tapped!');
                },
              ),
              const SizedBox(height: 10),
              CustomButton(
                label: 'Full Width Outlined',
                variant: ButtonVariant.outlined,
                fullWidth: true,
                onPressed: () {
                  setState(() => _clickCount++);
                  _showSnackbar('Outlined full width!');
                },
              ),
            ]),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon, String subtitle,
      Color bg, Color color) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      const SizedBox(width: 10),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15)),
        Text(subtitle,
            style: const TextStyle(
                fontSize: 11, color: AppTheme.textLight)),
      ]),
    ]);
  }

  Widget _buttonCard({
    required String label,
    required String description,
    required Widget child,
    required String code,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF16213E) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13)),
              Text(description,
                  style: const TextStyle(
                      fontSize: 11, color: AppTheme.textLight)),
              const SizedBox(height: 10),
              child,
            ],
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () => _showCodeDialog(label, code),
          icon: const Icon(Icons.code_rounded,
              color: AppTheme.primary, size: 20),
          tooltip: 'View code',
        ),
      ]),
    );
  }
}