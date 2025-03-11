import 'package:app/presentation/l10n/arb/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'go_router.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget, {GoRouter? goRouter}) async {
    await pumpWidget(
      MockGoRouterProvider(
        goRouter: goRouter ?? MockGoRouter(),
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Material(child: widget),
        ),
      ),
    );
  }
}
