import 'package:cobain_dulu/utils/datas/dummy_activity.dart';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

/// Overview screen - halaman utama dashboard dengan stats dan activity
class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Cards
          _buildStatsRow(context),
          const SizedBox(height: 24),

          // Recent Activity
          _buildSectionTitle('Recent Activity'),
          const SizedBox(height: 12),
          _buildActivityList(context),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildActivityList(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dummyActivities.length,
        separatorBuilder: (_, _) =>
            Divider(height: 1, color: Theme.of(context).dividerColor),
        itemBuilder: (context, index) {
          final activity = dummyActivities[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                activity.icon,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(activity.title),
            subtitle: Text(
              activity.time,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          );
        },
      ),
    );
  }
}
