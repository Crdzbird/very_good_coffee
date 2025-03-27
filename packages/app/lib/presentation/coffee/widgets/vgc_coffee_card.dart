import 'package:app/presentation/dashboard/bloc/coffee_cubit.dart';
import 'package:app/presentation/extensions/build_context_extension.dart';
import 'package:app/presentation/extensions/widget_extension.dart';
import 'package:app/presentation/widgets/parallax/paralax_sensors_enum.dart';
import 'package:app/presentation/widgets/parallax/parallax.dart';
import 'package:app/presentation/widgets/parallax/parallax_layer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

class VgcCoffeeCard extends StatefulWidget {
  const VgcCoffeeCard({
    super.key,
    required Coffee coffee,
    bool isShimmer = false,
  }) : _coffee = coffee,
       _isShimmer = isShimmer;
  final Coffee _coffee;
  final bool _isShimmer;

  factory VgcCoffeeCard.coffee({
    required Coffee coffee,
    bool isFavorite = false,
  }) {
    return VgcCoffeeCard(coffee: coffee);
  }

  factory VgcCoffeeCard.shimmer() {
    return const VgcCoffeeCard(coffee: Coffee(), isShimmer: true);
  }

  @override
  State<VgcCoffeeCard> createState() => _VgcCoffeeCardState();
}

class _VgcCoffeeCardState extends State<VgcCoffeeCard>
    with TickerProviderStateMixin {
  late Offset position = Offset.zero;
  late bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    if (widget._isShimmer) {
      return Center(
        child: Card(
          child: SizedBox(height: context.height, width: context.width),
        ).shimmer(context),
      );
    }
    return GestureDetector(
      onPanStart:
          (_) => setState(() {
            isDragging = true;
            position = Offset.zero;
          }),
      onPanEnd: (detail) {
        if (position.dx > 100) {
          position = const Offset(500, 0);
          context.read<CoffeeCubit>().saveCoffee(widget._coffee);
        }
        if (position.dx < -100) {
          position = const Offset(-500, 0);
          context.read<CoffeeCubit>().fetchCoffee();
        }
        setState(() {
          isDragging = false;
          position = Offset.zero;
        });
      },
      onPanUpdate:
          (details) => setState(() {
            isDragging = true;
            position += details.delta;
          }),
      child: AnimatedRotation(
        turns: isDragging ? position.dx / 10000 : 0,
        duration: const Duration(milliseconds: 500),
        child: AnimatedContainer(
          duration:
              isDragging ? const Duration(milliseconds: 50) : Duration.zero,
          transform: Matrix4.identity()..translate(position.dx, position.dy),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: context.height,
              maxHeight: context.height,
              maxWidth: context.width,
              minWidth: context.width,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Parallax(
                  sensor: ParallaxSensorsEnum.gyroscope,
                  layers: [
                    Layer(
                      sensitivity: 7,
                      imageFit: BoxFit.fill,
                      child: CachedNetworkImage(
                        imageUrl: widget._coffee.file,
                        filterQuality: FilterQuality.high,
                        height: context.height,
                        width: context.width,
                        fit: BoxFit.fill,
                        cacheKey: '${widget._coffee.hashCode}',
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 8,
                  left: context.safePadding.left + 8,
                  right: context.safePadding.right + 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        heroTag: null,
                        onPressed: context.read<CoffeeCubit>().fetchCoffee,
                        child: Icon(Icons.close),
                      ),
                      const Spacer(),
                      FloatingActionButton(
                        heroTag: null,
                        child: Icon(Icons.favorite),
                        onPressed:
                            () => context.read<CoffeeCubit>().saveCoffee(
                              widget._coffee,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
