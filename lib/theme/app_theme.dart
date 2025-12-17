import 'package:flutter/material.dart';

/// Kelas untuk mengelola tema aplikasi
class AppTheme {
  /// Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      fontFamily: 'Roboto',
      // AppBar
      appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
      // Card
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      // Divider
      dividerTheme: DividerThemeData(color: Colors.grey.shade200, space: 1),
      // ListTile
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  /// Dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      fontFamily: 'Roboto',
      // Scaffold
      scaffoldBackgroundColor: const Color(0xFF121212),
      // AppBar
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Color(0xFF1E1E1E),
      ),
      // Card
      cardTheme: CardThemeData(
        elevation: 0,
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade800),
        ),
      ),
      // Divider
      dividerTheme: DividerThemeData(color: Colors.grey.shade800, space: 1),
      // ListTile
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E1E),
      ),
    );
  }
}
