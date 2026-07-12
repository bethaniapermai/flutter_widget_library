import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class FormShowcase extends StatefulWidget {
  const FormShowcase({super.key});

  @override
  State<FormShowcase> createState() => _FormShowcaseState();
}

class _FormShowcaseState extends State<FormShowcase> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _rememberMe = false;
  bool _notifications = true;
  String _selectedGender = 'Male';
  double _sliderValue = 50;
  List<String> _selectedChips = [];
  final List<String> _chipOptions = ['Flutter', 'Dart', 'React', 'Python', 'Java', 'Swift'];

  void _showSnackbar(String msg, {Color? color}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color ?? AppTheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
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
              gradient: LinearGradient(
                colors: [AppTheme.primary, AppTheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(children: [
              Icon(Icons.text_fields_rounded, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Form Components',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                Text('Inputs, toggles, sliders & chips',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ]),
            ]),
          ),
          const SizedBox(height: 20),

          // Text Fields
          _sectionHeader('Text Fields', Icons.edit_rounded),
          const SizedBox(height: 12),
          _card(
            isDark: isDark,
            child: Form(
              key: _formKey,
              child: Column(children: [
                CustomTextField(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  prefixIcon: Icons.person_outline,
                  controller: _nameCtrl,
                  validator: (v) => v == null || v.isEmpty ? 'Name is required' : null,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  label: 'Email Address',
                  hint: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email is required';
                    if (!v.contains('@')) return 'Invalid email';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  label: 'Password',
                  hint: 'Enter password',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  controller: _passCtrl,
                  validator: (v) => v != null && v.length < 6 ? 'Min 6 characters' : null,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  label: 'Validate Form',
                  fullWidth: true,
                  icon: Icons.check_rounded,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showSnackbar('Form is valid! ✓', color: AppTheme.success);
                    }
                  },
                ),
              ]),
            ),
          ),
          const SizedBox(height: 20),

          // Toggles & Switches
          _sectionHeader('Toggles & Switches', Icons.toggle_on_rounded),
          const SizedBox(height: 12),
          _card(
            isDark: isDark,
            child: Column(children: [
              _switchTile(
                'Remember Me',
                'Stay logged in on this device',
                Icons.bookmark_rounded,
                _rememberMe,
                (v) => setState(() => _rememberMe = v),
                AppTheme.primary,
              ),
              const Divider(),
              _switchTile(
                'Notifications',
                'Receive push notifications',
                Icons.notifications_rounded,
                _notifications,
                (v) => setState(() => _notifications = v),
                AppTheme.success,
              ),
            ]),
          ),
          const SizedBox(height: 20),

          // Radio Buttons
          _sectionHeader('Radio Buttons', Icons.radio_button_checked_rounded),
          const SizedBox(height: 12),
          _card(
            isDark: isDark,
            child: Column(children: [
              _radioTile('Male', Icons.male_rounded, AppTheme.stat2Text),
              _radioTile('Female', Icons.female_rounded, AppTheme.error),
              _radioTile('Prefer not to say', Icons.person_rounded, AppTheme.textLight),
            ]),
          ),
          const SizedBox(height: 20),

          // Slider
          _sectionHeader('Slider', Icons.tune_rounded),
          const SizedBox(height: 12),
          _card(
            isDark: isDark,
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Volume', style: TextStyle(fontWeight: FontWeight.w600)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.stat1,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('${_sliderValue.toInt()}%',
                      style: const TextStyle(
                          color: AppTheme.stat1Text,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ),
              ]),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppTheme.primary,
                  inactiveTrackColor: AppTheme.accent.withValues(alpha: 0.3),
                  thumbColor: AppTheme.primary,
                  overlayColor: AppTheme.primary.withValues(alpha: 0.1),
                ),
                child: Slider(
                  value: _sliderValue,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  onChanged: (v) => setState(() => _sliderValue = v),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 20),

          // Filter Chips
          _sectionHeader('Filter Chips', Icons.label_rounded),
          const SizedBox(height: 12),
          _card(
            isDark: isDark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select your skills:',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _chipOptions.map((chip) {
                    final selected = _selectedChips.contains(chip);
                    return FilterChip(
                      label: Text(chip),
                      selected: selected,
                      onSelected: (v) {
                        setState(() {
                          if (v) {
                            _selectedChips.add(chip);
                          } else {
                            _selectedChips.remove(chip);
                          }
                        });
                      },
                      selectedColor: AppTheme.accent,
                      checkmarkColor: AppTheme.primary,
                      labelStyle: TextStyle(
                        color: selected ? AppTheme.primary : AppTheme.textLight,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),
                if (_selectedChips.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text('Selected: ${_selectedChips.join(', ')}',
                      style: const TextStyle(fontSize: 12, color: AppTheme.primary)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _switchTile(String title, String subtitle, IconData icon,
      bool value, Function(bool) onChanged, Color color) {
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
      Switch(
        value: value,
        onChanged: onChanged,
        activeColor: color,
      ),
    ]);
  }

  Widget _radioTile(String value, IconData icon, Color color) {
    return RadioListTile<String>(
      value: value,
      groupValue: _selectedGender,
      onChanged: (v) => setState(() => _selectedGender = v!),
      title: Row(children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Text(value, style: const TextStyle(fontSize: 13)),
      ]),
      activeColor: AppTheme.primary,
      contentPadding: EdgeInsets.zero,
    );
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