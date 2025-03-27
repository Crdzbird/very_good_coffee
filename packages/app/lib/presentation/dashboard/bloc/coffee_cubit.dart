import 'package:bloc/bloc.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:models/models.dart';

part 'coffee_state.dart';

class CoffeeCubit extends Cubit<CoffeeState> {
  CoffeeCubit({required CoffeeRepository coffeeRepository})
    : _coffeeRepository = coffeeRepository,
      super(CoffeeLoading());

  final CoffeeRepository _coffeeRepository;

  Coffee get _coffee {
    if (state is CoffeeLoaded) {
      return (state as CoffeeLoaded).coffee;
    }
    return Coffee();
  }

  Future<void> fetchCoffee() async {
    emit(CoffeeLoading());
    final result = await _coffeeRepository.fetch();
    if (result.$1 != null) {
      return emit(CoffeeError(result.$1!));
    }
    emit(CoffeeLoaded(result.$2!));
  }

  void deleteCoffee(Coffee coffee) async {
    await _coffeeRepository.delete(coffee);
    emit(CoffeeLoaded(_coffee, isFavorite: false));
  }

  void saveCoffee(Coffee coffee) async {
    await Future.wait([_coffeeRepository.save(coffee), fetchCoffee()]);
    emit(CoffeeLoaded(_coffee, isFavorite: true));
  }
}
