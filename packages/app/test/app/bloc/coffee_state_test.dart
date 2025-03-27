import 'package:app/presentation/dashboard/bloc/coffee_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  group('CoffeeState Test', () {
    test('CoffeeLoading props are correct', () {
      final loading = CoffeeLoading();
      expect(loading.props, []);
    });

    test('CoffeeLoaded props are correct', () {
      final loaded = CoffeeLoaded(Coffee(), isFavorite: true);
      expect(loaded.props, [Coffee(), true]);
    });

    test('CoffeeError props are correct', () {
      final error = CoffeeError('error');
      expect(error.props, ['error']);
    });
  });
}
