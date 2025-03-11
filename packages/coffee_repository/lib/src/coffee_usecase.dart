part of 'coffee_repository.dart';

final class CoffeeUsecase extends CoffeeRepository {
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
    _localCoffeeRepository.save(result.$2!);
    return result;
  }

  @override
  List<Coffee> fetchAllLocal() {
    return _localCoffeeRepository.fetchAll();
  }
}
