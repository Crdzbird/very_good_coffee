import 'package:app/presentation/l10n/l10n.dart';
import 'package:app/presentation/widgets/parallax/parallax.dart';
import 'package:app/presentation/widgets/parallax/parallax_layer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FavoriteDetailScreen extends StatelessWidget {
  const FavoriteDetailScreen({super.key, required String url}) : _url = url;

  final String _url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.detailFavorite)),
      body: Parallax(
        layers: [
          Layer(
            sensitivity: 7,
            imageFit: BoxFit.fill,
            widget: Hero(
              tag: _url,
              transitionOnUserGestures: true,
              child: CachedNetworkImage(
                imageUrl: _url,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                cacheKey: '${_url.hashCode}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
