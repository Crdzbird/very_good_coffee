import 'package:app/presentation/favorites/widgets/favorite_content.dart';
import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FavoriteContent());
  }
}
