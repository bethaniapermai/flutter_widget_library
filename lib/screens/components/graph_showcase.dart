import 'package:flutter/material.dart';
import '../../widgets/bar_chart_widget.dart';
import '../../theme/app_theme.dart';

class GraphShowcase extends StatelessWidget {
  const GraphShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Bar Charts',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BarChartWidget(
                title: 'Monthly Expenses (Rp000)',
                data: const [
                  BarData(label: 'Jan', value: 320),
                  BarData(label: 'Feb', value: 450),
                  BarData(label: 'Mar', value: 280),
                  BarData(label: 'Apr', value: 510),
                  BarData(label: 'May', value: 390),
                  BarData(label: 'Jun', value: 620),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BarChartWidget(
                title: 'Weekly Study Hours',
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
          ),
        ],
      ),
    );
  }
}