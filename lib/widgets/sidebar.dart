import 'package:flutter/material.dart';

/// Model untuk item sidebar
class SidebarItem {
  final IconData icon;
  final String label;
  final String? badge;
  final VoidCallback? onTap;

  const SidebarItem({
    required this.icon,
    required this.label,
    this.badge,
    this.onTap,
  });
}

/// Model untuk konfigurasi sidebar per halaman
class SidebarConfig {
  final String title;
  final List<SidebarItem> items;
  final Widget? header;
  final Widget? footer;

  const SidebarConfig({
    required this.title,
    required this.items,
    this.header,
    this.footer,
  });
}

/// Dynamic Sidebar component yang bisa berbeda tiap halaman
class CustomSidebar extends StatelessWidget {
  final SidebarConfig config;
  final int? selectedIndex;
  final ValueChanged<int>? onItemTap;
  final Color? backgroundColor;
  final Color? selectedColor;
  final double width;

  const CustomSidebar({
    super.key,
    required this.config,
    this.selectedIndex,
    this.onItemTap,
    this.backgroundColor,
    this.selectedColor,
    this.width = 280,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      width: width,
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          // Header
          _buildHeader(context),

          // Menu Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: config.items.length,
              itemBuilder: (context, index) {
                final item = config.items[index];
                final isSelected = index == selectedIndex;

                return _SidebarMenuItem(
                  item: item,
                  isSelected: isSelected,
                  selectedColor: selectedColor ?? theme.colorScheme.primary,
                  onTap: () {
                    item.onTap?.call();
                    onItemTap?.call(index);
                  },
                );
              },
            ),
          ),

          // Footer
          if (config.footer != null) config.footer!,
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    if (config.header != null) {
      return config.header!;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      decoration: BoxDecoration(color: theme.colorScheme.primaryContainer),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: theme.colorScheme.primary,
            child: Icon(
              Icons.admin_panel_settings,
              size: 32,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            config.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          Text(
            'Admin Panel',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimaryContainer.withValues(
                alpha: 0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarMenuItem extends StatelessWidget {
  final SidebarItem item;
  final bool isSelected;
  final Color selectedColor;
  final VoidCallback onTap;

  const _SidebarMenuItem({
    required this.item,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: isSelected
            ? selectedColor.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  color: isSelected
                      ? selectedColor
                      : theme.colorScheme.onSurfaceVariant,
                  size: 22,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected
                          ? selectedColor
                          : theme.colorScheme.onSurface,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (item.badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: selectedColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item.badge!,
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
