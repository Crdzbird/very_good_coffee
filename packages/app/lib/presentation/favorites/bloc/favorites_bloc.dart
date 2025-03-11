import 'package:coffee_repository/coffee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Cubit<FavoritesState> {
  FavoritesBloc({required CoffeeRepository coffeeRepository})
    : _coffeeRepository = coffeeRepository,
      super(FavoritesLoading());
  final CoffeeRepository _coffeeRepository;

  void fetchFavorites() async {
    emit(FavoritesLoading());
    final result = _coffeeRepository.fetchAllLocal();
    emit(FavoritesLoaded(result));
  }

  void deleteFavorite(Coffee coffee) async {
    await _coffeeRepository.delete(coffee);
    fetchFavorites();
  }
}
