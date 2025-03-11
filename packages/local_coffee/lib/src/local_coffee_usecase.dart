part of 'local_coffee_repository.dart';

class LocalCoffeeUsecase extends LocalCoffeeRepository {
  LocalCoffeeUsecase(SharedPreferences sharedPreferences)
    : _sharedPreferences = sharedPreferences;
  final SharedPreferences _sharedPreferences;
  @override
  List<Coffee> fetchAll() {
    return _sharedPreferences
            .getStringList(LocalEnums.coffee.name)
            ?.map((e) => Coffee.fromJson(e))
            .toList() ??
        [];
  }

  @override
  Future<void> save(Coffee coffee) {
    final coffees = fetchAll()..add(coffee);
    return _sharedPreferences.setStringList(
      LocalEnums.coffee.name,
      coffees.map((e) => e.toJson).toList(),
    );
  }

  @override
  Future<void> delete(Coffee coffee) {
    final coffees = fetchAll()..remove(coffee);
    return _sharedPreferences.setStringList(
      LocalEnums.coffee.name,
      coffees.map((e) => e.toJson).toList(),
    );
  }

  @override
  Coffee fetchRandom() {
    final coffees = fetchAll();
    return coffees[Random().nextInt(coffees.length)];
  }
}
