part of 'coffee_repository.dart';

/// Use case for [CoffeeRepository].
/// This class handles the business logic for fetching coffess from both local and remote sources.
/// [CoffeeApiClientDatasource] is used to fetch coffees from a remote source.
/// [LocalCoffeeDatasource] is used to fetch coffees from a local source.
class CoffeeUsecase extends CoffeeRepository {
  CoffeeUsecase({
    required CoffeeApiClientDatasource coffeeClient,
    required LocalCoffeeDatasource localCoffeeDatasource,
  }) : _coffeeClient = coffeeClient,
       _localCoffeeDatasource = localCoffeeDatasource;
  final CoffeeApiClientDatasource _coffeeClient;
  final LocalCoffeeDatasource _localCoffeeDatasource;

  /// Fetches a coffee from a remote source.
  /// If the coffee is not found, a random coffee from a local source is returned.
  /// Returns a tuple of error message and coffee.
  /// In case of an error on both sources, the error message is returned.
  /// In case of a successful fetch, the coffee is returned.
  /// If the coffee is not found, the error message is returned.
  @override
  Future<(String?, Coffee?)> fetch() async {
    final result = await _coffeeClient.fetchCoffee();
    if (result.$1 != null) {
      final randomLocalCoffee = _localCoffeeDatasource.fetchRandom();
      if (randomLocalCoffee.file.isEmpty) return result;
      return (null, randomLocalCoffee);
    }
    return result;
  }

  /// Fetches all coffees from a local source.
  /// Returns an empty list if no coffees are found.
  @override
  List<Coffee> fetchAllLocal() {
    return _localCoffeeDatasource.fetchAll();
  }

  /// Saves a coffee to a local source.
  @override
  Future<void> save(Coffee coffee) {
    return _localCoffeeDatasource.save(coffee);
  }

  /// Deletes a coffee from a local source.
  @override
  Future<void> delete(Coffee coffee) {
    return _localCoffeeDatasource.delete(coffee);
  }
}
