import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/info_card.dart';
import 'login_screen.dart';
import 'components/button_showcase.dart';
import 'components/card_showcase.dart';
import 'components/graph_showcase.dart';

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
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

  Widget _buildHome() {
    final items = [
      {
        'title': 'Button Showcase',
        'subtitle': 'Filled, Outlined, Text, Danger variants',
        'icon': Icons.smart_button,
        'color': AppTheme.primary,
        'index': 1,
      },
      {
        'title': 'Card Showcase',
        'subtitle': 'Basic, Stat, Action card styles',
        'icon': Icons.credit_card,
        'color': AppTheme.success,
        'index': 2,
      },
      {
        'title': 'Graph Showcase',
        'subtitle': 'Animated bar charts with dynamic data',
        'icon': Icons.bar_chart,
        'color': AppTheme.warning,
        'index': 3,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.primary, Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello, $_username! 👋',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('Explore the widget components below',
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Stats
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.95,
            children: const [
              InfoCard(
                  title: 'Buttons',
                  statValue: '4',
                  icon: Icons.smart_button,
                  isStat: true,
                  accentColor: AppTheme.primary),
              InfoCard(
                  title: 'Cards',
                  statValue: '3',
                  icon: Icons.credit_card,
                  isStat: true,
                  accentColor: AppTheme.success),
              InfoCard(
                  title: 'Charts',
                  statValue: '2',
                  icon: Icons.bar_chart,
                  isStat: true,
                  accentColor: AppTheme.warning),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Components',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InfoCard(
                  title: item['title'] as String,
                  subtitle: item['subtitle'] as String,
                  icon: item['icon'] as IconData,
                  accentColor: item['color'] as Color,
                  onTap: () =>
                      setState(() => _selectedIndex = item['index'] as int),
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      _buildHome(),
      const ButtonShowcase(),
      const CardShowcase(),
      const GraphShowcase(),
    ];

    final titles = ['Dashboard', 'Buttons', 'Cards', 'Graphs'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex]),
        leading: _selectedIndex != 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => setState(() => _selectedIndex = 0))
            : null,
        actions: [
          IconButton(
              icon: const Icon(Icons.logout), onPressed: _logout, tooltip: 'Logout'),
        ],
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex == 0 ? 0 : 0,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: AppTheme.textLight,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.smart_button), label: 'Buttons'),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card), label: 'Cards'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Graphs'),
        ],
        onTap: (i) => setState(() => _selectedIndex = i),
      ),
    );
  }
}