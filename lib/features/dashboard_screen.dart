import 'package:ai_memory_admin/features/brand.dart' hide AppText;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/widgets/text/app_text.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(DashboardController());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _card(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: 'Hi, Good Morning',
                    fontSize: 15,
                    color: const Color(0xFFB6B6BE),
                  ),
                  const SizedBox(height: 6),
                  AppText(
                    data: c.adminName.value,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFFFFFF),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  data: "User's Overview",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFFFFFF),
                ),
                const SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final w = constraints.maxWidth;
                    final perRow = w >= 720 ? 3 : (w >= 460 ? 2 : 1);
                    const spacing = 16.0;
                    final cardW = (w - spacing * (perRow - 1)) / perRow;
                    return Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: [
                        for (final s in c.stats)
                          SizedBox(width: cardW, child: _statCard(s)),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final growth = _chartCard(
                title: 'User Growth',
                chart: _UserGrowthChart(c: c),
              );
              final revenue = _chartCard(
                title: 'Total revenue',
                chart: _RevenueChart(c: c),
              );
              if (constraints.maxWidth < 1000) {
                return Column(
                  children: [
                    growth,
                    const SizedBox(height: 20),
                    revenue,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: growth),
                  const SizedBox(width: 20),
                  Expanded(child: revenue),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0C11),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF20202A)),
      ),
      child: child,
    );
  }

  Widget _statCard(StatItem s) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF26262E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFF000000),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.bar_chart_rounded,
                color: Color(0xFFFFFFFF), size: 22),
          ),
          const SizedBox(height: 22),
          AppText(
            data: s.value,
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFFFFFFF),
          ),
          const SizedBox(height: 6),
          AppText(
            data: s.label,
            fontSize: 14,
            color: const Color(0xFFB6B6BE),
          ),
        ],
      ),
    );
  }

  Widget _chartCard({required String title, required Widget chart}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0C11),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF20202A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            data: title,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFFFFFFF),
          ),
          const SizedBox(height: 28),
          SizedBox(height: 300, child: chart),
        ],
      ),
    );
  }
}

class _UserGrowthChart extends StatelessWidget {
  final DashboardController c;
  const _UserGrowthChart({required this.c});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (c.growthValues.length - 1).toDouble(),
        minY: 0,
        maxY: 20,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 4,
          getDrawingHorizontalLine: (v) =>
              const FlLine(color: Color(0xFF3A3A45), strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 4,
              reservedSize: 36,
              getTitlesWidget: (v, meta) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  v.toInt().toString().padLeft(2, '0'),
                  style: const TextStyle(
                      color: Color(0xFF8A8A93), fontSize: 12),
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 28,
              getTitlesWidget: (v, meta) {
                final i = v.toInt();
                if (i < 0 || i >= c.growthMonths.length) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    c.growthMonths[i],
                    style: const TextStyle(
                        color: Color(0xFF8A8A93), fontSize: 12),
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int i = 0; i < c.growthValues.length; i++)
                FlSpot(i.toDouble(), c.growthValues[i]),
            ],
            isCurved: true,
            gradient: kBrandGradient,
            barWidth: 4,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}

class _RevenueChart extends StatelessWidget {
  final DashboardController c;
  const _RevenueChart({required this.c});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: 9000,
        alignment: BarChartAlignment.spaceAround,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 3000,
          getDrawingHorizontalLine: (v) => const FlLine(
            color: Color(0xFF3A3A45),
            strokeWidth: 1,
            dashArray: [5, 5],
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 3000,
              reservedSize: 48,
              getTitlesWidget: (v, meta) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  v == 0 ? '0' : '\$${(v / 1000).toInt()}000',
                  style: const TextStyle(
                      color: Color(0xFF8A8A93), fontSize: 11),
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 28,
              getTitlesWidget: (v, meta) {
                final i = v.toInt();
                if (i < 0 || i >= c.revenueMonths.length) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    c.revenueMonths[i],
                    style: const TextStyle(
                        color: Color(0xFF8A8A93), fontSize: 10),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (int i = 0; i < c.revenueValues.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: c.revenueValues[i],
                  width: 14,
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xFF6C8BF5), Color(0xFFB9A0F0)],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
