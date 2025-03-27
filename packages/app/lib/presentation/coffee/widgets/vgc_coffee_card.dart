import 'package:app/presentation/dashboard/bloc/coffee_cubit.dart';
import 'package:app/presentation/extensions/build_context_extension.dart';
import 'package:app/presentation/extensions/string_extension.dart';
import 'package:app/presentation/extensions/widget_extension.dart';
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
          child: SizedBox(
            height: context.height * .4,
            width: context.width * .7,
          ),
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
        child: Center(
          child: AnimatedContainer(
            duration:
                isDragging ? const Duration(milliseconds: 50) : Duration.zero,
            transform: Matrix4.identity()..translate(position.dx, position.dy),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widget._coffee.file.toColor(),
                width: 4,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            height: context.height * .4,
            width: context.width * .7,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                CachedNetworkImage(
                  imageUrl: widget._coffee.file,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                  cacheKey: '${widget._coffee.hashCode}',
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Text(
                    widget._coffee.file,
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
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
