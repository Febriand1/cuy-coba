import 'package:flutter/material.dart';
import 'widgets/widgets.dart';
import 'screens/screens.dart';
import 'providers/providers.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProviderWidget(
      builder: (context, themeProvider) {
        return MaterialApp(
          title: 'Ads Admin Platform',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.materialThemeMode,
          home: const AuthWrapper(),
        );
      },
    );
  }
}

/// Wrapper untuk handle authentication state
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

enum AuthScreen { login, register }

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoggedIn = false;
  AuthScreen _currentScreen = AuthScreen.login;

  void _handleLoginSuccess() {
    setState(() => _isLoggedIn = true);
  }

  void _handleRegisterSuccess() {
    setState(() => _isLoggedIn = true);
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
      _currentScreen = AuthScreen.login;
    });
  }

  void _goToRegister() {
    setState(() => _currentScreen = AuthScreen.register);
  }

  void _goToLogin() {
    setState(() => _currentScreen = AuthScreen.login);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return MainNavigationScreen(onLogout: _handleLogout);
    }

    switch (_currentScreen) {
      case AuthScreen.login:
        return LoginScreen(
          onLoginSuccess: _handleLoginSuccess,
          onGoToRegister: _goToRegister,
        );
      case AuthScreen.register:
        return RegisterScreen(
          onRegisterSuccess: _handleRegisterSuccess,
          onBackToLogin: _goToLogin,
        );
    }
  }
}

/// Main navigation screen dengan Bottom Navigation Bar
class MainNavigationScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const MainNavigationScreen({super.key, required this.onLogout});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Daftar item untuk Bottom Navigation Bar
  final List<BottomNavItem> _navItems = const [
    BottomNavItem(
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      label: 'Dashboard',
    ),
    BottomNavItem(
      icon: Icons.campaign_outlined,
      activeIcon: Icons.campaign,
      label: 'Campaigns',
    ),
    BottomNavItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  // Daftar halaman yang di-render
  late final List<Widget> _screens = [
    const DashboardScreen(),
    const CampaignsScreen(),
    SettingsScreen(onLogout: widget.onLogout),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        items: _navItems,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
