import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../theme/app_theme.dart';

class ButtonShowcase extends StatefulWidget {
  const ButtonShowcase({super.key});

  @override
  State<ButtonShowcase> createState() => _ButtonShowcaseState();
}

class _ButtonShowcaseState extends State<ButtonShowcase> {
  bool _loading = false;

  void _simulateLoad() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Filled Buttons'),
          Wrap(spacing: 10, runSpacing: 10, children: [
            CustomButton(label: 'Primary', onPressed: () {}),
            CustomButton(label: 'With Icon', icon: Icons.add, onPressed: () {}),
            CustomButton(
                label: 'Loading',
                isLoading: _loading,
                onPressed: _simulateLoad),
          ]),
          const SizedBox(height: 24),
          _sectionTitle('Outlined Buttons'),
          Wrap(spacing: 10, runSpacing: 10, children: [
            CustomButton(
                label: 'Outlined',
                variant: ButtonVariant.outlined,
                onPressed: () {}),
            CustomButton(
                label: 'With Icon',
                variant: ButtonVariant.outlined,
                icon: Icons.edit,
                onPressed: () {}),
          ]),
          const SizedBox(height: 24),
          _sectionTitle('Text & Danger'),
          Wrap(spacing: 10, runSpacing: 10, children: [
            CustomButton(
                label: 'Text Button',
                variant: ButtonVariant.text,
                onPressed: () {}),
            CustomButton(
                label: 'Delete',
                variant: ButtonVariant.danger,
                icon: Icons.delete,
                onPressed: () {}),
          ]),
          const SizedBox(height: 24),
          _sectionTitle('Full Width'),
          CustomButton(
              label: 'Full Width Primary', fullWidth: true, onPressed: () {}),
          const SizedBox(height: 10),
          CustomButton(
              label: 'Full Width Outlined',
              variant: ButtonVariant.outlined,
              fullWidth: true,
              onPressed: () {}),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(text,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppTheme.textDark)),
      );
}