import 'package:app/presentation/coffee/bloc/coffee_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

class VgcCoffeeCard extends StatelessWidget {
  const VgcCoffeeCard({
    super.key,
    required Coffee coffee,
    bool isFavorite = false,
  }) : _coffee = coffee,
       _isFavorite = isFavorite;
  final Coffee _coffee;
  final bool _isFavorite;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: _coffee.file,
            cacheKey: '${_coffee.hashCode}',
          ),
          ListTile(
            title: Text(_coffee.file),
            trailing: Switch.adaptive(
              value: _isFavorite,
              thumbIcon: WidgetStateProperty.fromMap({
                WidgetState.selected: Icon(Icons.favorite, color: Colors.red),
                WidgetState.any: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                ),
              }),
              onChanged: (value) {
                if (value) {
                  context.read<CoffeeCubit>().saveCoffee(_coffee);
                  return;
                }
                context.read<CoffeeCubit>().deleteCoffee(_coffee);
              },
            ),
          ),
        ],
      ),
    );
  }
}
