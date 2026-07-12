import 'package:flutter/material.dart';
import '../../widgets/bar_chart_widget.dart';
import '../../theme/app_theme.dart';

class GraphShowcase extends StatefulWidget {
  const GraphShowcase({super.key});

  @override
  State<GraphShowcase> createState() => _GraphShowcaseState();
}

class _GraphShowcaseState extends State<GraphShowcase> {
  String _selectedPeriod = 'Monthly';
  final List<String> _periods = ['Weekly', 'Monthly', 'Yearly'];

  List<BarData> get _expenseData {
    switch (_selectedPeriod) {
      case 'Weekly':
        return const [
          BarData(label: 'Mon', value: 45),
          BarData(label: 'Tue', value: 78),
          BarData(label: 'Wed', value: 32),
          BarData(label: 'Thu', value: 91),
          BarData(label: 'Fri', value: 67),
          BarData(label: 'Sat', value: 120),
          BarData(label: 'Sun', value: 55),
        ];
      case 'Yearly':
        return const [
          BarData(label: '2020', value: 2400),
          BarData(label: '2021', value: 3100),
          BarData(label: '2022', value: 2800),
          BarData(label: '2023', value: 3800),
          BarData(label: '2024', value: 4200),
        ];
      default:
        return const [
          BarData(label: 'Jan', value: 320),
          BarData(label: 'Feb', value: 450),
          BarData(label: 'Mar', value: 280),
          BarData(label: 'Apr', value: 510),
          BarData(label: 'May', value: 390),
          BarData(label: 'Jun', value: 620),
        ];
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
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.stat3,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(children: [
              Icon(Icons.bar_chart_rounded,
                  color: AppTheme.stat3Text, size: 28),
              SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Chart Components',
                    style: TextStyle(
                        color: AppTheme.stat3Text,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                Text('Animated & interactive charts',
                    style: TextStyle(
                        color: AppTheme.stat3Text, fontSize: 12)),
              ]),
            ]),
          ),
          const SizedBox(height: 20),

          // Dynamic chart with period selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Expense Overview',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.stat1,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _periods.map((p) {
                    final selected = _selectedPeriod == p;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedPeriod = p),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppTheme.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(p,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: selected
                                    ? Colors.white
                                    : AppTheme.textLight)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
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
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: BarChartWidget(
                key: ValueKey(_selectedPeriod),
                data: _expenseData,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Study hours chart
          const Text('Weekly Study Hours',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15)),
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
            child: BarChartWidget(
              height: 160,
              data: const [
                BarData(label: 'Mon', value: 3, color: AppTheme.success),
                BarData(label: 'Tue', value: 5, color: AppTheme.success),
                BarData(label: 'Wed', value: 2, color: AppTheme.warning),
                BarData(label: 'Thu', value: 6, color: AppTheme.success),
                BarData(label: 'Fri', value: 4, color: AppTheme.success),
                BarData(label: 'Sat', value: 1, color: AppTheme.error),
                BarData(label: 'Sun', value: 2, color: AppTheme.error),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Summary stats
          const Text('Summary',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 12),
          Row(children: [
            _summaryCard('Peak Day', 'Thursday', Icons.trending_up_rounded,
                AppTheme.stat1, AppTheme.stat1Text),
            const SizedBox(width: 10),
            _summaryCard('Avg/Day', '3.3 hrs', Icons.schedule_rounded,
                AppTheme.stat2, AppTheme.stat2Text),
            const SizedBox(width: 10),
            _summaryCard('Total', '23 hrs', Icons.done_all_rounded,
                AppTheme.stat3, AppTheme.stat3Text),
          ]),
        ],
      ),
    );
  }

  Widget _summaryCard(String label, String value, IconData icon,
      Color bg, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: color),
              textAlign: TextAlign.center),
          Text(label,
              style: const TextStyle(
                  fontSize: 10, color: AppTheme.textLight),
              textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}