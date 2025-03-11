part of 'coffee_repository.dart';

class CoffeeUsecase extends CoffeeRepository {
  CoffeeUsecase({
    required CoffeeClientRepository coffeeSealed,
    required LocalCoffeeRepository localCoffeeRepository,
  }) : _coffeeSealed = coffeeSealed,
       _localCoffeeRepository = localCoffeeRepository;
  final CoffeeClientRepository _coffeeSealed;
  final LocalCoffeeRepository _localCoffeeRepository;
  @override
  Future<(String?, Coffee?)> fetch() async {
    final result = await _coffeeSealed.fetchCoffee();
    if (result.$1 != null) {
      final randomLocalCoffee = _localCoffeeRepository.fetchRandom();
      if (randomLocalCoffee.file.isEmpty) return result;
      return (null, randomLocalCoffee);
    }
    return result;
  }

  @override
  List<Coffee> fetchAllLocal() {
    return _localCoffeeRepository.fetchAll();
  }

  @override
  Future<void> save(Coffee coffee) {
    return _localCoffeeRepository.save(coffee);
  }

  @override
  Future<void> delete(Coffee coffee) {
    return _localCoffeeRepository.delete(coffee);
  }
}
