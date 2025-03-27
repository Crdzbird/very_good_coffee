import 'dart:async';

import 'package:app/presentation/dashboard/bloc/coffee_cubit.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required CoffeeRepository coffeeRepository,
    CoffeeCubit? coffeeCubit,
  }) : _coffeeRepository = coffeeRepository,
       super(FavoritesLoading()) {
    _coffeeSubscription = coffeeCubit?.stream.listen((state) {
      if (state is CoffeeLoaded && state.isFavorite) {
        fetchFavorites();
      }
    });
  }
  final CoffeeRepository _coffeeRepository;
  StreamSubscription<CoffeeState>? _coffeeSubscription;

  void fetchFavorites() async {
    emit(FavoritesLoading());
    final result = _coffeeRepository.fetchAllLocal();
    emit(FavoritesLoaded(result));
  }

  void deleteFavorite(Coffee coffee) async {
    await _coffeeRepository.delete(coffee);
    fetchFavorites();
  }

  @override
  Future<void> close() {
    _coffeeSubscription?.cancel();
    return super.close();
  }
}
