import 'package:flutter/material.dart';

/// Enum untuk mode tema aplikasi
enum AppThemeMode {
  system, // Mengikuti tema sistem
  light, // Selalu terang
  dark, // Selalu gelap
}

/// Provider untuk mengelola tema aplikasi
class ThemeProvider extends ChangeNotifier {
  AppThemeMode _themeMode = AppThemeMode.system;

  AppThemeMode get themeMode => _themeMode;

  /// Mengatur mode tema
  void setThemeMode(AppThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }

  /// Toggle antara light dan dark mode (tidak termasuk system)
  void toggleTheme() {
    if (_themeMode == AppThemeMode.light) {
      _themeMode = AppThemeMode.dark;
    } else {
      _themeMode = AppThemeMode.light;
    }
    notifyListeners();
  }

  /// Mendapatkan ThemeMode untuk MaterialApp
  ThemeMode get materialThemeMode {
    switch (_themeMode) {
      case AppThemeMode.system:
        return ThemeMode.system;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
    }
  }

  /// Mengecek apakah dark mode aktif berdasarkan konteks
  bool isDarkMode(BuildContext context) {
    if (_themeMode == AppThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return _themeMode == AppThemeMode.dark;
  }
}

/// InheritedWidget untuk menyediakan ThemeProvider ke seluruh widget tree
class ThemeProviderWidget extends StatefulWidget {
  final Widget Function(BuildContext context, ThemeProvider themeProvider)
  builder;

  const ThemeProviderWidget({super.key, required this.builder});

  static ThemeProvider of(BuildContext context) {
    final _ThemeProviderInherited? inherited = context
        .dependOnInheritedWidgetOfExactType<_ThemeProviderInherited>();
    assert(inherited != null, 'No ThemeProviderWidget found in context');
    return inherited!.provider;
  }

  @override
  State<ThemeProviderWidget> createState() => _ThemeProviderWidgetState();
}

class _ThemeProviderWidgetState extends State<ThemeProviderWidget> {
  late final ThemeProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = ThemeProvider();
    _provider.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    _provider.removeListener(_onThemeChanged);
    _provider.dispose();
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _ThemeProviderInherited(
      provider: _provider,
      child: widget.builder(context, _provider),
    );
  }
}

class _ThemeProviderInherited extends InheritedWidget {
  final ThemeProvider provider;

  const _ThemeProviderInherited({required this.provider, required super.child});

  @override
  bool updateShouldNotify(_ThemeProviderInherited oldWidget) {
    return true;
  }
}
