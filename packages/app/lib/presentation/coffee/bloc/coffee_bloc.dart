import 'package:bloc/bloc.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:models/models.dart';

part 'coffee_state.dart';

class CoffeeBloc extends Cubit<CoffeeState> {
  CoffeeBloc({required CoffeeRepository coffeeRepository})
    : _coffeeRepository = coffeeRepository,
      super(CoffeeLoading());

  final CoffeeRepository _coffeeRepository;

  void fetchCoffee() async {
    emit(CoffeeLoading());
    final result = await _coffeeRepository.fetch();
    if (result.$1 != null) {
      return emit(CoffeeError(result.$1!));
    }
    emit(CoffeeLoaded(result.$2!));
  }
}
