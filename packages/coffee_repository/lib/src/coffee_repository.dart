import 'package:http_client/http_client.dart';
import 'package:local_coffee/local_coffee.dart';
import 'package:models/models.dart';

part 'coffee_usecase.dart';

sealed class CoffeeRepository {
  Future<(String? error, Coffee? data)> fetch();
  Future<void> save(Coffee coffee);
  Future<void> delete(Coffee coffee);
  List<Coffee> fetchAllLocal();
}
