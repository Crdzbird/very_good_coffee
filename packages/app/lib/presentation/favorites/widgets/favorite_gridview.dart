import 'package:app/presentation/favorites/widgets/empty_favorite.dart';
import 'package:app/presentation/favorites/widgets/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';

class FavoriteGridview extends StatelessWidget {
  const FavoriteGridview({
    super.key,
    List<Coffee> coffees = const [],
    bool shimmer = false,
  }) : _coffees = coffees,
       _shimmer = shimmer;

  factory FavoriteGridview.shimmer() {
    return const FavoriteGridview(shimmer: true);
  }

  final List<Coffee> _coffees;
  final bool _shimmer;

  @override
  Widget build(BuildContext context) {
    if (_shimmer) {
      return SliverGrid.builder(
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) => FavoriteCard.shimmer(),
      );
    }
    if (_coffees.isEmpty) {
      return SliverFillRemaining(child: EmptyFavorite());
    }
    return SliverGrid.builder(
      itemCount: _coffees.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) => FavoriteCard(coffee: _coffees[index]),
    );
  }
}
