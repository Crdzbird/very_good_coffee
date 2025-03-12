import 'package:app/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:app/presentation/favorites/favorites_screen.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesProvider extends StatelessWidget {
  const FavoritesProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (bContext) => FavoritesCubit(
            coffeeRepository: bContext.read<CoffeeRepository>(),
          )..fetchFavorites(),
      child: const FavoritesScreen(),
    );
  }
}
