import 'package:app/presentation/l10n/arb/app_localizations.dart';
import 'package:app/presentation/router/constants_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'go_router.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    GoRouter? goRouter,
    Locale? customLocale,
  }) async {
    await pumpWidget(
      MockGoRouterProvider(
        goRouter: goRouter ?? MockGoRouter(),
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: customLocale,
          navigatorKey: ConstantsRouter.rootNavigatorKey,
          home: Material(child: widget),
        ),
      ),
    );
  }
}
