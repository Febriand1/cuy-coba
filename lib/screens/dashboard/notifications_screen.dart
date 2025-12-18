import 'package:flutter/material.dart';

/// Notifications screen - halaman notifikasi
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final notifications = [
      {
        'title': 'Campaign "Summer Sale" reached 10K impressions',
        'time': '5 min ago',
        'icon': Icons.celebration,
        'color': Colors.green,
        'isRead': false,
      },
      {
        'title': 'Budget alert: Campaign "Product Launch" at 80%',
        'time': '1 hour ago',
        'icon': Icons.warning,
        'color': Colors.orange,
        'isRead': false,
      },
      {
        'title': 'New report available: Weekly Performance',
        'time': '3 hours ago',
        'icon': Icons.description,
        'color': Colors.blue,
        'isRead': true,
      },
      {
        'title': 'Campaign "Flash Sale" has been approved',
        'time': '5 hours ago',
        'icon': Icons.check_circle,
        'color': Colors.green,
        'isRead': true,
      },
      {
        'title': 'Performance alert: CTR dropped below 2%',
        'time': '1 day ago',
        'icon': Icons.trending_down,
        'color': Colors.red,
        'isRead': true,
      },
      {
        'title': 'New advertiser signed up via referral',
        'time': '2 days ago',
        'icon': Icons.person_add,
        'color': Colors.purple,
        'isRead': true,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Mark all as read'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Stay updated with your campaign activities',
            style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 24),

          // Notification List
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: theme.dividerColor),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notifications.length,
              separatorBuilder: (_, _) =>
                  Divider(height: 1, color: theme.dividerColor),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final isRead = notification['isRead'] as bool;

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (notification['color'] as Color).withValues(
                        alpha: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      notification['icon'] as IconData,
                      color: notification['color'] as Color,
                      size: 24,
                    ),
                  ),
                  title: Text(
                    notification['title'] as String,
                    style: TextStyle(
                      fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    notification['time'] as String,
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                  trailing: isRead
                      ? null
                      : Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
