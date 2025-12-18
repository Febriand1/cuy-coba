import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

/// Performance screen - halaman metrics performa
class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Performance Metrics',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Key performance indicators for your campaigns',
            style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 24),

          // KPI Cards
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: [
              StatTrendCard(
                title: 'Click-Through Rate',
                value: '3.8%',
                change: 0.5,
                isUp: true,
                icon: Icons.mouse,
                color: Colors.blue,
              ),
              StatTrendCard(
                title: 'Cost Per Click',
                value: '\$0.45',
                change: 8.0,
                isUp: false,
                icon: Icons.attach_money,
                color: Colors.green,
              ),
              StatTrendCard(
                title: 'Cost Per Mille',
                value: '\$2.80',
                change: 15.0,
                isUp: true,
                icon: Icons.trending_up,
                color: Colors.orange,
              ),
              StatTrendCard(
                title: 'Return on Ad Spend',
                value: '4.2x',
                change: 3.0,
                isUp: true,
                icon: Icons.monetization_on,
                color: Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Performance Details
          _buildSectionTitle(context, 'Performance Details'),
          const SizedBox(height: 12),
          _buildPerformanceTable(context),
        ],
      ),
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

  Widget _buildPerformanceTable(BuildContext context) {
    final theme = Theme.of(context);
    final metrics = [
      {'metric': 'Total Spend', 'value': '\$12,450', 'benchmark': '\$15,000'},
      {'metric': 'Conversions', 'value': '1,234', 'benchmark': '1,000'},
      {'metric': 'Conversion Rate', 'value': '2.8%', 'benchmark': '2.5%'},
      {
        'metric': 'Avg. Session Duration',
        'value': '3m 45s',
        'benchmark': '3m 00s',
      },
      {'metric': 'Bounce Rate', 'value': '42%', 'benchmark': '45%'},
      {'metric': 'Pages Per Session', 'value': '4.2', 'benchmark': '3.5'},
    ];

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Metric',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Value',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Benchmark',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          // Data rows
          ...metrics.asMap().entries.map((entry) {
            final item = entry.value;
            final isLast = entry.key == metrics.length - 1;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : Border(bottom: BorderSide(color: theme.dividerColor)),
              ),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Text(item['metric']!)),
                  Expanded(
                    child: Text(
                      item['value']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item['benchmark']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
