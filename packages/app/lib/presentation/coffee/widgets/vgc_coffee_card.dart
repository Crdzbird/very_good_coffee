import 'package:app/presentation/coffee/widgets/like_switch.dart';
import 'package:app/presentation/dashboard/bloc/coffee_cubit.dart';
import 'package:app/presentation/extensions/build_context_extension.dart';
import 'package:app/presentation/extensions/widget_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

class VgcCoffeeCard extends StatelessWidget {
  const VgcCoffeeCard({
    super.key,
    required Coffee coffee,
    bool isFavorite = false,
    bool isShimmer = false,
  }) : _coffee = coffee,
       _isFavorite = isFavorite,
       _isShimmer = isShimmer;
  final Coffee _coffee;
  final bool _isFavorite;
  final bool _isShimmer;

  factory VgcCoffeeCard.coffee({
    required Coffee coffee,
    bool isFavorite = false,
  }) {
    return VgcCoffeeCard(coffee: coffee, isFavorite: isFavorite);
  }

  factory VgcCoffeeCard.shimmer() {
    return const VgcCoffeeCard(coffee: Coffee(), isShimmer: true);
  }

  @override
  Widget build(BuildContext context) {
    if (_isShimmer) return Card().shimmer(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: _coffee.file,
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
          cacheKey: '${_coffee.hashCode}',
        ),
        Positioned(
          top: context.safePadding.vertical,
          right: context.safePadding.horizontal + 8,
          child: FloatingActionButton.small(
            onPressed:
                _isFavorite
                    ? () => context.read<CoffeeCubit>().deleteCoffee(_coffee)
                    : () => context.read<CoffeeCubit>().saveCoffee(_coffee),
            child: LikeSwitch(liked: _isFavorite),
          ),
        ),
      ],
    );
  }
}
