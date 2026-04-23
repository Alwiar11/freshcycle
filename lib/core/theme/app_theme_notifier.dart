import 'package:flutter/material.dart';

/// Simple UI-only theme controller.
/// Wrap MaterialApp dengan ValueListenableBuilder untuk reaktif.
class AppThemeNotifier extends ValueNotifier<ThemeMode> {
  AppThemeNotifier() : super(ThemeMode.light);

  static final instance = AppThemeNotifier();

  bool get isDark => value == ThemeMode.dark;

  void toggle() {
    value = isDark ? ThemeMode.light : ThemeMode.dark;
  }
}
