part of 'local_coffee_datasource.dart';

class LocalCoffeeUsecase extends LocalCoffeeDatasource {
  LocalCoffeeUsecase(SharedPreferences sharedPreferences)
    : _sharedPreferences = sharedPreferences;
  final SharedPreferences _sharedPreferences;

  /// Fetches all [Coffee]s.
  /// Returns an empty list if no [Coffee]s are found.
  @override
  List<Coffee> fetchAll() {
    return _sharedPreferences
            .getStringList(LocalEnums.coffee.name)
            ?.map((e) => Coffee.fromJson(e))
            .toList() ??
        [];
  }

  /// Saves a [Coffee] locally.
  @override
  Future<void> save(Coffee coffee) {
    final coffees = fetchAll()..add(coffee);
    return _sharedPreferences.setStringList(
      LocalEnums.coffee.name,
      coffees.map((e) => e.toJson).toList(),
    );
  }

  /// Deletes a [Coffee] locally.
  @override
  Future<void> delete(Coffee coffee) {
    final coffees = fetchAll()..remove(coffee);
    return _sharedPreferences.setStringList(
      LocalEnums.coffee.name,
      coffees.map((e) => e.toJson).toList(),
    );
  }

  /// Fetches a random [Coffee].
  /// Returns an empty [Coffee] if no [Coffee]s are found.
  @override
  Coffee fetchRandom() {
    final coffees = fetchAll();
    return coffees[Random().nextInt(coffees.length)];
  }
}
