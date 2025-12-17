import 'package:flutter/material.dart';
import 'sidebar.dart';

/// Page Scaffold yang menggabungkan AppBar dan Sidebar
class PageScaffold extends StatelessWidget {
  final String title;
  final SidebarConfig sidebarConfig;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final int sidebarSelectedIndex;
  final ValueChanged<int>? onSidebarItemTap;

  const PageScaffold({
    super.key,
    required this.title,
    required this.sidebarConfig,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.sidebarSelectedIndex = 0,
    this.onSidebarItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
        actions: actions,
      ),
      drawer: CustomSidebar(
        config: sidebarConfig,
        selectedIndex: sidebarSelectedIndex,
        onItemTap: (index) {
          Navigator.pop(context); // Close drawer
          onSidebarItemTap?.call(index);
        },
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
