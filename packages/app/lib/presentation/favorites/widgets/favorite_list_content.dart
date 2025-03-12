import 'package:app/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:app/presentation/favorites/widgets/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteListContent extends StatelessWidget {
  const FavoriteListContent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (bContext, state) {
            return switch (state) {
              FavoritesLoading() => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator.adaptive()),
              ),
              FavoritesLoaded() => SliverList.separated(
                itemCount: state.coffeeList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 6),
                itemBuilder:
                    (context, index) =>
                        FavoriteCard(coffee: state.coffeeList[index]),
              ),
            };
          },
        ),
      ],
    );
  }
}
