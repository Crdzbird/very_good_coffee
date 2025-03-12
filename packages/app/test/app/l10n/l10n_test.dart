import 'package:app/presentation/l10n/l10n.dart';
import 'package:app/presentation/router/constants_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  // Test the l10n module.
  group('l10n extension test', () {
    testWidgets('Localization english', (widgetTester) async {
      await widgetTester.pumpApp(SizedBox());
      expect(ConstantsRouter.rootNavigatorKey.currentContext?.l10n, isNotNull);
      expect(
        ConstantsRouter
            .rootNavigatorKey
            .currentContext
            ?.l10n
            .counterAppBarTitle,
        'Counter',
      );
    });

    testWidgets('Localization spanish', (widgetTester) async {
      await widgetTester.pumpApp(SizedBox(), customLocale: Locale('es'));
      expect(ConstantsRouter.rootNavigatorKey.currentContext?.l10n, isNotNull);
      expect(
        ConstantsRouter
            .rootNavigatorKey
            .currentContext
            ?.l10n
            .counterAppBarTitle,
        'Contador',
      );
    });
  });
}
