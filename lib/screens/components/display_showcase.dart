import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class DisplayShowcase extends StatefulWidget {
  const DisplayShowcase({super.key});

  @override
  State<DisplayShowcase> createState() => _DisplayShowcaseState();
}

class _DisplayShowcaseState extends State<DisplayShowcase> {
  final List<Map<String, dynamic>> _users = [
    {'name': 'Bethania', 'role': 'Developer', 'online': true, 'color': AppTheme.primary},
    {'name': 'Pandu', 'role': 'Designer', 'online': true, 'color': AppTheme.success},
    {'name': 'Aldif', 'role': 'Backend', 'online': false, 'color': AppTheme.warning},
    {'name': 'Barth', 'role': 'QA', 'online': false, 'color': AppTheme.error},
  ];

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
              color: const Color(0xFFD1FAE5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(children: [
              Icon(Icons.dashboard_rounded, color: AppTheme.success, size: 28),
              SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Display Components',
                    style: TextStyle(color: AppTheme.success, fontWeight: FontWeight.bold, fontSize: 15)),
                Text('Avatars, badges, chips & more',
                    style: TextStyle(color: AppTheme.success, fontSize: 12)),
              ]),
            ]),
          ),
          const SizedBox(height: 20),

          // Avatars
          _sectionHeader('Avatars', Icons.face_rounded),
          const SizedBox(height: 12),
          _card(isDark: isDark, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('With Status Indicator',
                  style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
              const SizedBox(height: 12),
              Row(children: _users.map((u) => Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(children: [
                  Stack(children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: (u['color'] as Color).withValues(alpha: 0.2),
                      child: Text(
                        (u['name'] as String)[0],
                        style: TextStyle(
                          color: u['color'] as Color,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0, bottom: 0,
                      child: Container(
                        width: 14, height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: u['online'] == true ? AppTheme.success : AppTheme.textLight,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 6),
                  Text(u['name'] as String,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                  Text(u['role'] as String,
                      style: const TextStyle(fontSize: 10, color: AppTheme.textLight)),
                ]),
              )).toList()),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),
              const Text('Size Variants',
                  style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                _avatarWithLabel('XS', 16, AppTheme.primary),
                _avatarWithLabel('SM', 22, AppTheme.secondary),
                _avatarWithLabel('MD', 28, AppTheme.success),
                _avatarWithLabel('LG', 36, AppTheme.warning),
                _avatarWithLabel('XL', 44, AppTheme.error),
              ]),
            ],
          )),
          const SizedBox(height: 20),

          // Badges
          _sectionHeader('Badges', Icons.circle_notifications_rounded),
          const SizedBox(height: 12),
          _card(isDark: isDark, child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _badgeItem(Icons.notifications_rounded, '3', AppTheme.error),
              _badgeItem(Icons.message_rounded, '12', AppTheme.primary),
              _badgeItem(Icons.shopping_cart_rounded, '99+', AppTheme.warning),
              _badgeItem(Icons.mail_rounded, '5', AppTheme.success),
            ]),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Wrap(spacing: 8, runSpacing: 8, children: [
              _labelBadge('New', AppTheme.success),
              _labelBadge('Hot 🔥', AppTheme.error),
              _labelBadge('Sale', AppTheme.warning),
              _labelBadge('Popular', AppTheme.primary),
              _labelBadge('Beta', AppTheme.secondary),
            ]),
          ])),
          const SizedBox(height: 20),

          // Dividers
          _sectionHeader('Dividers & Separators', Icons.horizontal_rule_rounded),
          const SizedBox(height: 12),
          _card(isDark: isDark, child: Column(children: [
            const Text('Standard Divider', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            const Text('Thick Divider', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
            const SizedBox(height: 8),
            const Divider(thickness: 3, color: AppTheme.accent),
            const SizedBox(height: 8),
            const Text('With Label', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
            const SizedBox(height: 8),
            Row(children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('OR', style: TextStyle(fontSize: 12, color: AppTheme.primary, fontWeight: FontWeight.w600)),
                ),
              ),
              const Expanded(child: Divider()),
            ]),
          ])),
          const SizedBox(height: 20),

          // List Tiles
          _sectionHeader('List Tiles', Icons.list_rounded),
          const SizedBox(height: 12),
          _card(isDark: isDark, child: Column(
            children: _users.map((u) => Column(children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: (u['color'] as Color).withValues(alpha: 0.15),
                  child: Text((u['name'] as String)[0],
                      style: TextStyle(color: u['color'] as Color, fontWeight: FontWeight.bold)),
                ),
                title: Text(u['name'] as String,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                subtitle: Text(u['role'] as String,
                    style: const TextStyle(fontSize: 12)),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: u['online'] == true
                        ? AppTheme.success.withValues(alpha: 0.1)
                        : AppTheme.textLight.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    u['online'] == true ? 'Online' : 'Offline',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: u['online'] == true ? AppTheme.success : AppTheme.textLight,
                    ),
                  ),
                ),
              ),
              if (_users.indexOf(u) < _users.length - 1) const Divider(height: 1),
            ])).toList(),
          )),
        ],
      ),
    );
  }

  Widget _avatarWithLabel(String label, double radius, Color color) {
    return Column(children: [
      CircleAvatar(
        radius: radius,
        backgroundColor: color.withValues(alpha: 0.2),
        child: Text(
          'A',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: radius * 0.7,
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textLight)),
    ]);
  }

  Widget _badgeItem(IconData icon, String count, Color color) {
    return Column(children: [
      Stack(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 26),
        ),
        Positioned(
          right: 0, top: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(count,
                style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
      ]),
    ]);
  }

  Widget _labelBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(label,
          style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
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