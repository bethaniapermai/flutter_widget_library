import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';
import 'components/button_showcase.dart';
import 'components/card_showcase.dart';
import 'components/graph_showcase.dart';
import 'components/form_showcase.dart';
import 'components/feedback_showcase.dart';
import 'components/display_showcase.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final name = await AuthService.getUsername();
    setState(() => _username = name);
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.error,
                foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await AuthService.logout();
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  void _navigateTo(Widget screen, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _ShowcaseWrapper(title: title, child: screen),
      ),
    );
  }

  final List<Map<String, dynamic>> _allComponents = [
    {
      'title': 'Buttons',
      'subtitle': 'Filled, Outlined, Text, Danger variants',
      'icon': Icons.smart_button_rounded,
      'color': AppTheme.stat1Text,
      'bg': AppTheme.stat1,
      'screen': const ButtonShowcase(),
    },
    {
      'title': 'Cards',
      'subtitle': 'Basic, Stat, Action card styles',
      'icon': Icons.credit_card_rounded,
      'color': AppTheme.stat2Text,
      'bg': AppTheme.stat2,
      'screen': const CardShowcase(),
    },
    {
      'title': 'Graphs',
      'subtitle': 'Animated bar charts',
      'icon': Icons.bar_chart_rounded,
      'color': AppTheme.stat3Text,
      'bg': AppTheme.stat3,
      'screen': const GraphShowcase(),
    },
    {
      'title': 'Forms',
      'subtitle': 'Inputs, toggles, sliders, chips',
      'icon': Icons.text_fields_rounded,
      'color': AppTheme.primary,
      'bg': const Color(0xFFEDE9FE),
      'screen': const FormShowcase(),
    },
    {
      'title': 'Feedback',
      'subtitle': 'Dialogs, snackbars, progress',
      'icon': Icons.feedback_rounded,
      'color': Color(0xFFEA580C),
      'bg': const Color(0xFFFFEDD5),
      'screen': const FeedbackShowcase(),
    },
    {
      'title': 'Display',
      'subtitle': 'Avatars, badges, dividers, list tiles',
      'icon': Icons.dashboard_rounded,
      'color': AppTheme.success,
      'bg': const Color(0xFFD1FAE5),
      'screen': const DisplayShowcase(),
    },
  ];

  Widget _buildHome() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primary, AppTheme.secondary.withValues(alpha: 0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text('Hello, $_username! 👋',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('v1.0.0',
                        style: TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                ]),
                const SizedBox(height: 6),
                const Text('Explore the widget components below',
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 16),
                Row(children: [
                  _badgeChip('Flutter'),
                  const SizedBox(width: 8),
                  _badgeChip('Dart'),
                  const SizedBox(width: 8),
                  _badgeChip('Material 3'),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Stats
          Row(children: [
            _statCard('4', 'Buttons', AppTheme.stat1, AppTheme.stat1Text, Icons.smart_button_rounded),
            const SizedBox(width: 8),
            _statCard('3', 'Cards', AppTheme.stat2, AppTheme.stat2Text, Icons.credit_card_rounded),
            const SizedBox(width: 8),
            _statCard('6', 'Total', AppTheme.stat3, AppTheme.stat3Text, Icons.widgets_rounded),
          ]),
          const SizedBox(height: 20),

          const Text('All Components',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),

          ..._allComponents.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => _navigateTo(item['screen'] as Widget, item['title'] as String),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(14),
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
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: item['bg'] as Color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item['icon'] as IconData,
                        color: item['color'] as Color, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['title'] as String,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                        const SizedBox(height: 2),
                        Text(item['subtitle'] as String,
                            style: const TextStyle(
                                fontSize: 12, color: AppTheme.textLight)),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      size: 14, color: AppTheme.textLight),
                ]),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildMore() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final moreItems = _allComponents.sublist(3); // Forms, Feedback, Display
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primary, AppTheme.secondary.withValues(alpha: 0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('More Components',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                SizedBox(height: 4),
                Text('Forms, Feedback & Display widgets',
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...moreItems.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => _navigateTo(item['screen'] as Widget, item['title'] as String),
              borderRadius: BorderRadius.circular(16),
              child: Container(
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
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: item['bg'] as Color,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(item['icon'] as IconData,
                        color: item['color'] as Color, size: 26),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['title'] as String,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 4),
                        Text(item['subtitle'] as String,
                            style: const TextStyle(
                                fontSize: 12, color: AppTheme.textLight)),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      size: 14, color: AppTheme.textLight),
                ]),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label, Color bg, Color textColor, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(children: [
          Icon(icon, color: textColor, size: 22),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: textColor)),
          Text(label,
              style: const TextStyle(fontSize: 11, color: AppTheme.textLight)),
        ]),
      ),
    );
  }

  Widget _badgeChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 11)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    final screens = <Widget>[
      _buildHome(),
      _ShowcaseWrapper(title: 'Buttons', child: const ButtonShowcase()),
      _ShowcaseWrapper(title: 'Cards', child: const CardShowcase()),
      _ShowcaseWrapper(title: 'Graphs', child: const GraphShowcase()),
      _buildMore(),
    ];

    final titles = ['Dashboard', 'Buttons', 'Cards', 'Graphs', 'More'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex]),
        actions: [
          IconButton(
            icon: Icon(themeService.isDark
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded),
            onPressed: themeService.toggle,
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: _logout,
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: KeyedSubtree(
          key: ValueKey(_selectedIndex),
          child: screens[_selectedIndex],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        indicatorColor: AppTheme.accent,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.smart_button_outlined),
              selectedIcon: Icon(Icons.smart_button_rounded),
              label: 'Buttons'),
          NavigationDestination(
              icon: Icon(Icons.credit_card_outlined),
              selectedIcon: Icon(Icons.credit_card_rounded),
              label: 'Cards'),
          NavigationDestination(
              icon: Icon(Icons.bar_chart_outlined),
              selectedIcon: Icon(Icons.bar_chart_rounded),
              label: 'Graphs'),
          NavigationDestination(
              icon: Icon(Icons.more_horiz_rounded),
              selectedIcon: Icon(Icons.more_horiz_rounded),
              label: 'More'),
        ],
      ),
    );
  }
}

// Wrapper dengan Scaffold + AppBar + back button
class _ShowcaseWrapper extends StatelessWidget {
  final String title;
  final Widget child;

  const _ShowcaseWrapper({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    // Kalau dipush via Navigator, bungkus dengan Scaffold
    final isNested = ModalRoute.of(context)?.settings.name != null ||
        Navigator.of(context).canPop();

    if (isNested) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: child,
      );
    }
    return child;
  }
}