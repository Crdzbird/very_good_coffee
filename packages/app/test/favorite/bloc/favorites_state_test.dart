import 'package:app/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavoritesState Test', () {
    test('FavoritesLoading props are correct', () {
      final loading = FavoritesLoading();
      expect(loading.props, []);
    });

    test('FavoritesLoaded props are correct', () {
      final loaded = FavoritesLoaded([]);
      expect(loaded.props, [[]]);
    });
  });
}
