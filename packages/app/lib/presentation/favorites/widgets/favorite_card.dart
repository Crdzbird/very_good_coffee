import 'package:app/presentation/favorites/bloc/favorites_cubit.dart';
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
      child: Column(
        children: [
          CachedNetworkImage(imageUrl: _coffee.file),
          ListTile(
            title: Text(_coffee.file),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed:
                  () => context.read<FavoritesCubit>().deleteFavorite(_coffee),
            ),
          ),
        ],
      ),
    );
  }
}
