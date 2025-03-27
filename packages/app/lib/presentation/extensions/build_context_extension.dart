import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  EdgeInsets get safePadding =>
      MediaQuery.maybePaddingOf(this) ?? EdgeInsets.zero;
}
