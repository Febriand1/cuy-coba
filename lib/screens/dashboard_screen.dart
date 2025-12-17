import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'dashboard/dashboard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _sidebarIndex = 0;

  final List<Map<String, dynamic>> _itemsDashboard = [
    {'icon': Icons.dashboard_outlined, 'label': 'Dashboard'},
    {'icon': Icons.analytics_outlined, 'label': 'Analytics'},
    {'icon': Icons.bar_chart_outlined, 'label': 'Reports'},
    {'icon': Icons.trending_up_outlined, 'label': 'Performance'},
    {'icon': Icons.notifications_outlined, 'label': 'Notifications'},
  ];

  // Daftar screen yang sesuai dengan sidebar items
  final List<Widget> _screens = const [
    OverviewScreen(),
    AnalyticsScreen(),
    ReportsScreen(),
    PerformanceScreen(),
    NotificationsScreen(),
  ];

  // Sidebar khusus untuk Dashboard
  SidebarConfig get _sidebarConfig => SidebarConfig(
    title: 'Dashboard',
    items: _itemsDashboard.map((item) {
      return SidebarItem(icon: item['icon'], label: item['label']);
    }).toList(),
  );

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: _itemsDashboard[_sidebarIndex]['label'],
      sidebarConfig: _sidebarConfig,
      sidebarSelectedIndex: _sidebarIndex,
      onSidebarItemTap: (index) {
        setState(() => _sidebarIndex = index);
      },
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
        ),
      ],
      body: _screens[_sidebarIndex],
    );
  }
}
