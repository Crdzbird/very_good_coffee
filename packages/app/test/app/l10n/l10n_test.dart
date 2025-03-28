import 'package:app/presentation/l10n/l10n.dart';
import 'package:app/presentation/router/constants_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('l10n extension test', () {
    testWidgets('Localization english', (widgetTester) async {
      await widgetTester.pumpApp(SizedBox());
      expect(ConstantsRouter.rootNavigatorKey.currentContext?.l10n, isNotNull);
      expect(
        ConstantsRouter.rootNavigatorKey.currentContext?.l10n.coffees,
        'Coffees',
      );
      expect(
        ConstantsRouter.rootNavigatorKey.currentContext?.l10n.favorites,
        'Favorites',
      );
      expect(
        ConstantsRouter.rootNavigatorKey.currentContext?.l10n.detailFavorite,
        'Favorite Detail',
      );
    });

    testWidgets('Localization spanish', (widgetTester) async {
      await widgetTester.pumpApp(SizedBox(), customLocale: Locale('es'));
      expect(ConstantsRouter.rootNavigatorKey.currentContext?.l10n, isNotNull);
      expect(
        ConstantsRouter.rootNavigatorKey.currentContext?.l10n.coffees,
        'Cafés',
      );
      expect(
        ConstantsRouter.rootNavigatorKey.currentContext?.l10n.favorites,
        'Favoritos',
      );
      expect(
        ConstantsRouter.rootNavigatorKey.currentContext?.l10n.detailFavorite,
        'Detalle Favorito',
      );
    });
  });
}
