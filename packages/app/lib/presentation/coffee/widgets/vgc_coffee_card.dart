import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';

class VgcCoffeeCard extends StatelessWidget {
  const VgcCoffeeCard({super.key, required Coffee coffee}) : _coffee = coffee;
  final Coffee _coffee;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: _coffee.file,
            cacheKey: '${_coffee.hashCode}',
          ),
          Text(_coffee.file),
        ],
      ),
    );
  }
}
