import 'dart:math';

import 'package:local_coffee/local_coffee.dart';
import 'package:models/models.dart';

part 'local_coffee_usecase.dart';

/// A repository that stores [Coffee] locally.
/// - [save] saves a [Coffee] locally.
/// - [fetchAll] fetches all [Coffee]s.
/// - [fetchRandom] fetches a random [Coffee].
sealed class LocalCoffeeRepository {
  Future<void> save(Coffee coffee);
  List<Coffee> fetchAll();
  Coffee fetchRandom();
  Future<void> delete(Coffee coffee);
}
