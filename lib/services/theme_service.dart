import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_colors.dart';

enum ColorTheme {
  blue,
  green,
  purple,
  pink,
  orange,
  red,
  yellow,
  teal,
  indigo,
}

extension ColorThemeExtension on ColorTheme {
  Color get color {
    switch (this) {
      case ColorTheme.blue:
        return AppColors.blue;
      case ColorTheme.green:
        return AppColors.green;
      case ColorTheme.purple:
        return AppColors.purple;
      case ColorTheme.pink:
        return AppColors.pink;
      case ColorTheme.orange:
        return AppColors.orange;
      case ColorTheme.red:
        return AppColors.red;
      case ColorTheme.yellow:
        return AppColors.yellow;
      case ColorTheme.teal:
        return AppColors.teal;
      case ColorTheme.indigo:
        return AppColors.indigo;
    }
  }

  String get name {
    switch (this) {
      case ColorTheme.blue:
        return 'Blue';
      case ColorTheme.green:
        return 'Green';
      case ColorTheme.purple:
        return 'Purple';
      case ColorTheme.pink:
        return 'Pink';
      case ColorTheme.orange:
        return 'Orange';
      case ColorTheme.red:
        return 'Red';
      case ColorTheme.yellow:
        return 'Yellow';
      case ColorTheme.teal:
        return 'Teal';
      case ColorTheme.indigo:
        return 'Indigo';
    }
  }
}

class ThemeService extends ChangeNotifier {
  static const String _colorThemeKey = 'color_theme';
  ColorTheme _colorTheme = ColorTheme.blue;

  ColorTheme get colorTheme => _colorTheme;
  Color get primaryColor => _colorTheme.color;

  ThemeService() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_colorThemeKey) ?? 0;
    _colorTheme = ColorTheme.values[themeIndex];
    notifyListeners();
  }

  Future<void> setColorTheme(ColorTheme theme) async {
    _colorTheme = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_colorThemeKey, theme.index);
    notifyListeners();
  }
}
