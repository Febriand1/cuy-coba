import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'analytic/analytic.dart';

class AnalyticScreen extends StatefulWidget {
  const AnalyticScreen({super.key});

  @override
  State<AnalyticScreen> createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends State<AnalyticScreen> {
  int _sidebarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Analytic',
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
