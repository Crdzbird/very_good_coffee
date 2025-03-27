import 'package:app/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:app/presentation/favorites/widgets/favorite_gridview.dart';
import 'package:app/presentation/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteContent extends StatelessWidget {
  const FavoriteContent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          stretch: true,
          forceMaterialTransparency: true,
          title: Text(context.l10n.favorites),
        ),
        BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (bContext, state) {
            return switch (state) {
              FavoritesLoading() => FavoriteGridview.shimmer(),
              FavoritesLoaded() => FavoriteGridview(coffees: state.coffeeList),
            };
          },
        ),
      ],
    );
  }
}
