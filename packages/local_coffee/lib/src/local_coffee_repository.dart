import 'dart:math';

import 'package:local_coffee/local_coffee.dart';
import 'package:models/models.dart';

part 'local_coffee_usecase.dart';

sealed class LocalCoffeeRepository {
  Future<void> save(Coffee coffee);
  List<Coffee> fetchAll();
  Coffee fetchRandom();
  Future<void> delete(Coffee coffee);
}
