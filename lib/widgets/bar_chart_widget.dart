import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BarData {
  final String label;
  final double value;
  final Color? color;
  const BarData({required this.label, required this.value, this.color});
}

class BarChartWidget extends StatelessWidget {
  final List<BarData> data;
  final String? title;
  final double height;

  const BarChartWidget({
    super.key,
    required this.data,
    this.title,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    final maxVal = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(title!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppTheme.textDark)),
          ),
        SizedBox(
          height: height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: data.map((item) {
              final ratio = maxVal > 0 ? item.value / maxVal : 0.0;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(item.value.toStringAsFixed(0),
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textDark)),
                      const SizedBox(height: 4),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeOut,
                        height: (height * 0.75) * ratio,
                        decoration: BoxDecoration(
                          color: item.color ?? AppTheme.primary,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(6)),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(item.label,
                          style: const TextStyle(
                              fontSize: 9, color: AppTheme.textLight),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}