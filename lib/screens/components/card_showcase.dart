import 'package:flutter/material.dart';
import '../../widgets/info_card.dart';
import '../../theme/app_theme.dart';

class CardShowcase extends StatefulWidget {
  const CardShowcase({super.key});

  @override
  State<CardShowcase> createState() => _CardShowcaseState();
}

class _CardShowcaseState extends State<CardShowcase> {
  int _actionTaps = 0;

  void _showSnackbar(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppTheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
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
              color: AppTheme.stat2,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(children: [
              const Icon(Icons.credit_card_rounded,
                  color: AppTheme.stat2Text, size: 28),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Card Components',
                    style: TextStyle(
                        color: AppTheme.stat2Text,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                Text('$_actionTaps interactions',
                    style: const TextStyle(
                        color: AppTheme.stat2Text,
                        fontSize: 12)),
              ]),
            ]),
          ),
          const SizedBox(height: 20),

          _sectionHeader('Basic Cards', Icons.rectangle_outlined,
              'Simple information display'),
          const SizedBox(height: 12),
          InfoCard(
            title: 'Notification',
            subtitle: 'You have 3 unread messages.',
            icon: Icons.notifications_rounded,
            accentColor: AppTheme.primary,
          ),
          const SizedBox(height: 8),
          InfoCard(
            title: 'Profile Complete',
            subtitle: 'Your profile is 80% complete. Add more info!',
            icon: Icons.person_rounded,
            accentColor: AppTheme.success,
          ),
          const SizedBox(height: 8),
          InfoCard(
            title: 'New Update Available',
            subtitle: 'Version 2.0 is ready to install.',
            icon: Icons.system_update_rounded,
            accentColor: AppTheme.warning,
          ),
          const SizedBox(height: 20),

          _sectionHeader('Stat Cards', Icons.bar_chart_rounded,
              'Display key metrics'),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.4,
            children: [
              _statCard('1,240', 'Total Users',
                  Icons.people_rounded, AppTheme.stat1, AppTheme.stat1Text),
              _statCard('Rp 4.2M', 'Revenue',
                  Icons.trending_up_rounded, AppTheme.stat2, AppTheme.stat2Text),
              _statCard('38', 'Completed',
                  Icons.check_circle_rounded, AppTheme.stat3, AppTheme.stat3Text),
              _statCard('4.8 ⭐', 'Rating',
                  Icons.star_rounded,
                  const Color(0xFFFFEDD5),
                  const Color(0xFFEA580C)),
            ],
          ),
          const SizedBox(height: 20),

          _sectionHeader('Highlighted Cards', Icons.priority_high_rounded,
              'Draw attention to important info'),
          const SizedBox(height: 12),
          _highlightCard(
            title: 'Important Notice',
            subtitle: 'Please verify your email to continue using the app.',
            icon: Icons.warning_amber_rounded,
            color: AppTheme.warning,
            bg: const Color(0xFFFEF3C7),
          ),
          const SizedBox(height: 8),
          _highlightCard(
            title: 'Payment Successful',
            subtitle: 'Your transaction has been processed successfully.',
            icon: Icons.check_circle_rounded,
            color: AppTheme.success,
            bg: const Color(0xFFD1FAE5),
          ),
          const SizedBox(height: 8),
          _highlightCard(
            title: 'Connection Error',
            subtitle: 'Unable to connect. Please check your internet.',
            icon: Icons.wifi_off_rounded,
            color: AppTheme.error,
            bg: const Color(0xFFFEE2E2),
          ),
          const SizedBox(height: 20),

          _sectionHeader('Action Cards', Icons.touch_app_rounded,
              'Tappable navigation cards'),
          const SizedBox(height: 12),
          ...[
            {'title': 'Account Settings', 'subtitle': 'Manage your profile and preferences', 'icon': Icons.settings_rounded, 'color': AppTheme.primary},
            {'title': 'Notifications', 'subtitle': 'Configure your notification preferences', 'icon': Icons.notifications_rounded, 'color': AppTheme.stat2Text},
            {'title': 'Help & Support', 'subtitle': 'Get help from our support team', 'icon': Icons.help_outline_rounded, 'color': AppTheme.success},
            {'title': 'Privacy Policy', 'subtitle': 'Read our privacy policy', 'icon': Icons.privacy_tip_rounded, 'color': AppTheme.warning},
          ].map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InfoCard(
              title: item['title'] as String,
              subtitle: item['subtitle'] as String,
              icon: item['icon'] as IconData,
              accentColor: item['color'] as Color,
              onTap: () {
                setState(() => _actionTaps++);
                _showSnackbar('${item['title']} tapped!');
              },
            ),
          )),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon, String subtitle) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Icon(icon, color: AppTheme.primary, size: 18),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15)),
      ]),
      Padding(
        padding: const EdgeInsets.only(left: 26),
        child: Text(subtitle,
            style: const TextStyle(
                fontSize: 11, color: AppTheme.textLight)),
      ),
    ]);
  }

  Widget _statCard(String value, String label, IconData icon,
      Color bg, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 24),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: color)),
            Text(label,
                style: const TextStyle(
                    fontSize: 11, color: AppTheme.textLight)),
          ]),
        ],
      ),
    );
  }

  Widget _highlightCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color bg,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: color)),
              const SizedBox(height: 2),
              Text(subtitle,
                  style: TextStyle(
                      fontSize: 11,
                      color: color.withValues(alpha: 0.8))),
            ],
          ),
        ),
      ]),
    );
  }
}