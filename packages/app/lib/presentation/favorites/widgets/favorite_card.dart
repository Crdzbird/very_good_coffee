import 'package:app/presentation/extensions/string_extension.dart';
import 'package:app/presentation/extensions/widget_extension.dart';
import 'package:app/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:app/presentation/router/vgc_screen_enum.dart';
import 'package:app/presentation/widgets/parallax/parallax.dart';
import 'package:app/presentation/widgets/parallax/parallax_layer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, required Coffee coffee, bool shimmer = false})
    : _coffee = coffee,
      _shimmer = shimmer;

  factory FavoriteCard.shimmer() {
    return FavoriteCard(coffee: Coffee(), shimmer: true);
  }

  final Coffee _coffee;
  final bool _shimmer;

  @override
  Widget build(BuildContext context) {
    if (_shimmer) {
      return Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ).shimmer(context);
    }
    return InkWell(
      onTap:
          () => context.go(
            VgcScreenEnum.detailFavorite.path,
            extra: {'url': _coffee.file},
          ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _coffee.file.toColor(),
            width: 4,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Parallax(
              layers: [
                Layer(
                  sensitivity: 7,
                  imageFit: BoxFit.fill,
                  widget: Hero(
                    tag: _coffee.file,
                    transitionOnUserGestures: true,
                    child: CachedNetworkImage(
                      imageUrl: _coffee.file,
                      cacheKey: '${_coffee.hashCode}',
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 8,
              child: IconButton.filled(
                icon: Icon(Icons.delete),
                onPressed:
                    () =>
                        context.read<FavoritesCubit>().deleteFavorite(_coffee),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
