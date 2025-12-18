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

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Dashboard',
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
      body: const OverviewScreen(),
    );
  }
}
