import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  EdgeInsets get safePadding =>
      MediaQuery.maybePaddingOf(this) ?? EdgeInsets.zero;

  bool get isApple =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS;

  (ThemeData dayMode, ThemeData darkMode) get themeModes => (
    ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    ),
    ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Colors.blue,
      ),
    ),
  );
}
