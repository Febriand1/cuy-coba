import 'package:cobain_dulu/utils/datas/dummy_analytics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

/// Analytics screen - halaman dengan charts analytics
class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Overview
          _buildStatsRow(),
          const SizedBox(height: 24),

          // Impressions Line Chart
          _buildSectionTitle(context, 'Impressions (Last 7 Days)'),
          const SizedBox(height: 12),
          _buildImpressionsChart(),
          const SizedBox(height: 24),

          // Clicks Line Chart
          _buildSectionTitle(context, 'Clicks (Last 7 Days)'),
          const SizedBox(height: 12),
          _buildClicksChart(),
          const SizedBox(height: 24),

          // Revenue Bar Chart
          _buildSectionTitle(context, 'Revenue (Last 6 Months)'),
          const SizedBox(height: 12),
          _buildRevenueChart(),
          const SizedBox(height: 24),

          // Campaign Status Pie Chart
          _buildSectionTitle(context, 'Campaign Status'),
          const SizedBox(height: 12),
          _buildCampaignStatusChart(),
          const SizedBox(height: 24),

          // Traffic Sources
          _buildSectionTitle(context, 'Traffic Sources'),
          const SizedBox(height: 12),
          _buildTrafficSourcesChart(),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        StatTrendCard(
          title: 'Total Impressions',
          value: '119.4K',
          change: 12.5,
          isUp: true,
          icon: Icons.visibility,
          color: Colors.blue,
        ),
        StatTrendCard(
          title: 'Total Clicks',
          value: '9.56K',
          change: 8.3,
          isUp: true,
          icon: Icons.touch_app,
          color: Colors.green,
        ),
        StatTrendCard(
          title: 'CTR',
          value: '3.8%',
          change: 0.5,
          isUp: true,
          icon: Icons.percent,
          color: Colors.orange,
        ),
        StatTrendCard(
          title: 'Revenue',
          value: '\$65.7K',
          change: 2.1,
          isUp: false,
          icon: Icons.attach_money,
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _buildImpressionsChart() {
    final spots = impressionsData.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        (entry.value['value'] as int).toDouble(),
      );
    }).toList();

    final labels = impressionsData.map((e) => e['day'] as String).toList();

    return AnalyticsLineChart(
      spots: spots,
      labels: labels,
      lineColor: Colors.indigo,
      gradientColor: Colors.indigo,
      height: 220,
    );
  }

  Widget _buildClicksChart() {
    final spots = clicksData.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        (entry.value['value'] as int).toDouble(),
      );
    }).toList();

    final labels = clicksData.map((e) => e['day'] as String).toList();

    return AnalyticsLineChart(
      spots: spots,
      labels: labels,
      lineColor: Colors.green,
      gradientColor: Colors.green,
      height: 220,
    );
  }

  Widget _buildRevenueChart() {
    final barGroups = revenueData.asMap().entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: (entry.value['value'] as int).toDouble(),
            color: Colors.indigo,
            width: 20,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
        ],
      );
    }).toList();

    final labels = revenueData.map((e) => e['month'] as String).toList();

    return AnalyticsBarChart(
      barGroups: barGroups,
      labels: labels,
      height: 220,
      maxY: 15000,
    );
  }

  Widget _buildCampaignStatusChart() {
    final total = campaignStatusData.fold<int>(
      0,
      (sum, item) => sum + (item['count'] as int),
    );

    final sections = campaignStatusData.map((item) {
      final percentage = (item['count'] as int) / total * 100;
      return PieChartSectionData(
        value: percentage,
        title: '${percentage.toStringAsFixed(0)}%',
        color: Color(item['color'] as int),
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    final legendData = campaignStatusData.map((item) {
      return {
        'label': item['status'] as String,
        'value': '${item['count']}',
        'color': item['color'] as int,
      };
    }).toList();

    return AnalyticsPieChart(
      sections: sections,
      height: 180,
      legendData: legendData,
    );
  }

  Widget _buildTrafficSourcesChart() {
    final sections = trafficSourceData.map((item) {
      return PieChartSectionData(
        value: item['percentage'] as double,
        title: '${(item['percentage'] as double).toStringAsFixed(0)}%',
        color: Color(item['color'] as int),
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    final legendData = trafficSourceData.map((item) {
      return {
        'label': item['source'] as String,
        'value': '${(item['percentage'] as double).toStringAsFixed(0)}%',
        'color': item['color'] as int,
      };
    }).toList();

    return AnalyticsPieChart(
      sections: sections,
      height: 180,
      legendData: legendData,
    );
  }
}
