import 'package:app/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:app/presentation/widgets/parallax/parallax.dart';
import 'package:app/presentation/widgets/parallax/parallax_layer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, required Coffee coffee}) : _coffee = coffee;

  final Coffee _coffee;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.zero,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Parallax(
            layers: [
              Layer(
                sensitivity: 7,
                imageFit: BoxFit.fill,
                preventCrop: true,
                widget: CachedNetworkImage(
                  imageUrl: _coffee.file,
                  cacheKey: '${_coffee.hashCode}',
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 8,
            child: FloatingActionButton.small(
              child: Icon(Icons.delete),
              onPressed:
                  () => context.read<FavoritesCubit>().deleteFavorite(_coffee),
            ),
          ),
        ],
      ),
    );
  }
}
