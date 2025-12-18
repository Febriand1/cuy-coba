import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../providers/providers.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback? onLogout;

  const SettingsScreen({super.key, this.onLogout});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _sidebarIndex = 0;
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;

  final List<Map<String, dynamic>> _itemsSetting = [
    {'icon': Icons.person_outline, 'label': 'Profile'},
    {'icon': Icons.security_outlined, 'label': 'Security'},
    {'icon': Icons.notifications_outlined, 'label': 'Notifications'},
    {'icon': Icons.palette_outlined, 'label': 'Appearance'},
    {'icon': Icons.language_outlined, 'label': 'Language'},
    {'icon': Icons.help_outline, 'label': 'Help & Support'},
    {'icon': Icons.info_outline, 'label': 'About'},
  ];

  // Sidebar khusus untuk Settings
  SidebarConfig get _sidebarConfig => SidebarConfig(
    title: 'Settings',
    items: _itemsSetting.map((item) {
      return SidebarItem(
        icon: item['icon'],
        label: item['label'],
        onTap: () => _showSnackBar(item['label']),
      );
    }).toList(),
  );

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navigating to $message')));
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Settings',
      sidebarConfig: _sidebarConfig,
      sidebarSelectedIndex: _sidebarIndex,
      onSidebarItemTap: (index) {
        setState(() => _sidebarIndex = index);
      },
      body: _buildSettingsContent(),
    );
  }

  Widget _buildSettingsContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          _buildProfileCard(),
          const SizedBox(height: 24),

          // Preferences Section
          _buildSectionTitle('Preferences'),
          const SizedBox(height: 12),
          _buildPreferencesCard(),
          const SizedBox(height: 24),

          // Account Section
          _buildSectionTitle('Account'),
          const SizedBox(height: 12),
          _buildAccountCard(),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admin User',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'admin@adsplatform.com',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Super Admin',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _buildPreferencesCard() {
    final themeProvider = ThemeProviderWidget.of(context);
    final isDark =
        themeProvider.themeMode == AppThemeMode.dark ||
        (themeProvider.themeMode == AppThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive push notifications'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() => _notificationsEnabled = value);
            },
          ),
          Divider(height: 1, color: Theme.of(context).dividerColor),
          _buildThemeSelector(themeProvider, isDark),
          Divider(height: 1, color: Theme.of(context).dividerColor),
          SwitchListTile(
            title: const Text('Email Notifications'),
            subtitle: const Text('Receive email updates'),
            value: _emailNotifications,
            onChanged: (value) {
              setState(() => _emailNotifications = value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSelector(ThemeProvider themeProvider, bool isDark) {
    return ListTile(
      title: const Text('Theme'),
      subtitle: Text(_getThemeModeText(themeProvider.themeMode)),
      trailing: SegmentedButton<AppThemeMode>(
        segments: const [
          ButtonSegment(
            value: AppThemeMode.system,
            icon: Icon(Icons.settings_brightness),
            label: Text('System'),
          ),
          ButtonSegment(
            value: AppThemeMode.light,
            icon: Icon(Icons.light_mode),
            label: Text('Light'),
          ),
          ButtonSegment(
            value: AppThemeMode.dark,
            icon: Icon(Icons.dark_mode),
            label: Text('Dark'),
          ),
        ],
        selected: {themeProvider.themeMode},
        onSelectionChanged: (Set<AppThemeMode> newSelection) {
          themeProvider.setThemeMode(newSelection.first);
        },
      ),
    );
  }

  String _getThemeModeText(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.system:
        return 'Follow system';
      case AppThemeMode.light:
        return 'Light mode';
      case AppThemeMode.dark:
        return 'Dark mode';
    }
  }

  Widget _buildAccountCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Divider(height: 1, color: Theme.of(context).dividerColor),
          ListTile(
            leading: const Icon(Icons.devices_outlined),
            title: const Text('Manage Devices'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Divider(height: 1, color: Theme.of(context).dividerColor),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red.shade400),
            title: Text('Logout', style: TextStyle(color: Colors.red.shade400)),
            onTap: widget.onLogout,
          ),
        ],
      ),
    );
  }
}
