import 'package:app/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:app/presentation/favorites/view/favorites_view.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (bContext) => FavoritesCubit(
            coffeeRepository: bContext.read<CoffeeRepository>(),
          )..fetchFavorites(),
      child: const FavoritesView(),
    );
  }
}
