import 'package:flutter/material.dart';
import '../../widgets/info_card.dart';
import '../../theme/app_theme.dart';

class CardShowcase extends StatelessWidget {
  const CardShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Basic Cards'),
          const InfoCard(
              title: 'Notification',
              subtitle: 'You have 3 unread messages.',
              icon: Icons.notifications),
          const SizedBox(height: 8),
          const InfoCard(
              title: 'Profile',
              subtitle: 'Your profile is 80% complete.',
              icon: Icons.person,
              accentColor: AppTheme.success),
          const SizedBox(height: 20),
          _sectionTitle('Stat Cards'),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.3,
            children: const [
              InfoCard(
                  title: 'Total Users',
                  statValue: '1,240',
                  icon: Icons.people,
                  isStat: true),
              InfoCard(
                  title: 'Revenue',
                  statValue: 'Rp 4.2M',
                  icon: Icons.trending_up,
                  isStat: true,
                  accentColor: AppTheme.success),
              InfoCard(
                  title: 'Completed',
                  statValue: '38',
                  icon: Icons.check_circle,
                  isStat: true,
                  accentColor: AppTheme.warning),
              InfoCard(
                  title: 'Rating',
                  statValue: '4.8',
                  icon: Icons.star,
                  isStat: true,
                  accentColor: AppTheme.error),
            ],
          ),
          const SizedBox(height: 20),
          _sectionTitle('Action Cards'),
          InfoCard(
              title: 'Account Settings',
              subtitle: 'Manage your profile and preferences',
              icon: Icons.settings,
              onTap: () {}),
          const SizedBox(height: 8),
          InfoCard(
              title: 'Help & Support',
              subtitle: 'Get help from our support team',
              icon: Icons.help_outline,
              accentColor: AppTheme.secondary,
              onTap: () {}),
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