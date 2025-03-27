import 'dart:ui';

import 'package:flutter/material.dart';

class Layer {
  Layer({
    required this.sensitivity,
    this.offset,
    this.widget,
    this.imageFit = BoxFit.cover,
    this.preventCrop = false,
    this.imageHeight,
    this.imageWidth,
    this.imageBlurValue,
    this.imageDarkenValue,
    this.opacity,
    this.child,
  });

  final double sensitivity;
  final Offset? offset;
  final Widget? widget;
  final BoxFit imageFit;
  final bool preventCrop;
  final double? imageHeight;
  final double? imageWidth;
  double? imageBlurValue;
  double? imageDarkenValue;
  double? opacity;
  final Widget? child;

  Widget build(
    BuildContext context,
    int animationDuration,
    double maxSensitivity,
    ValueNotifier<double> top,
    ValueNotifier<double> bottom,
    ValueNotifier<double> right,
    ValueNotifier<double> left,
  ) {
    return ValueListenableBuilder<double>(
      valueListenable: top,
      builder: (context, topValue, _) {
        return ValueListenableBuilder<double>(
          valueListenable: bottom,
          builder: (context, bottomValue, _) {
            return ValueListenableBuilder<double>(
              valueListenable: right,
              builder: (context, rightValue, _) {
                return ValueListenableBuilder<double>(
                  valueListenable: left,
                  builder: (context, leftValue, _) {
                    return AnimatedPositioned(
                      duration: Duration(milliseconds: animationDuration),
                      top: (preventCrop
                              ? (topValue - maxSensitivity) * sensitivity
                              : topValue * sensitivity +
                                  (MediaQuery.of(context).size.height -
                                          (imageHeight ??
                                              MediaQuery.of(context)
                                                  .size
                                                  .height)) /
                                      2) +
                          ((offset?.dy ?? 0) / 2),
                      bottom: (preventCrop
                              ? (bottomValue - maxSensitivity) * sensitivity
                              : bottomValue * sensitivity +
                                  (MediaQuery.of(context).size.height -
                                          (imageHeight ??
                                              MediaQuery.of(context)
                                                  .size
                                                  .height)) /
                                      2) -
                          ((offset?.dy ?? 0) / 2),
                      right: (preventCrop
                              ? (rightValue - maxSensitivity) * sensitivity
                              : rightValue * sensitivity +
                                  (MediaQuery.of(context).size.width -
                                          (imageWidth ??
                                              MediaQuery.of(context)
                                                  .size
                                                  .width)) /
                                      2) -
                          ((offset?.dx ?? 0) / 2),
                      left: (preventCrop
                              ? (leftValue - maxSensitivity) * sensitivity
                              : leftValue * sensitivity +
                                  (MediaQuery.of(context).size.width -
                                          (imageWidth ??
                                              MediaQuery.of(context)
                                                  .size
                                                  .width)) /
                                      2) +
                          ((offset?.dx ?? 0) / 2),
                      child: Opacity(
                        opacity: opacity ?? 1,
                        child: SizedBox(
                          height: imageHeight,
                          width: imageWidth,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              if (widget != null)
                                FittedBox(
                                  fit: imageFit,
                                  child: SizedBox(
                                    height: imageHeight,
                                    width: imageWidth,
                                    child: widget,
                                  ),
                                ),
                              if (imageBlurValue != null ||
                                  imageDarkenValue != null)
                                ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: imageBlurValue ?? 0,
                                      sigmaY: imageBlurValue ?? 0,
                                    ),
                                    child: Container(
                                      height: imageHeight,
                                      width: imageWidth,
                                      color: Colors.black.withValues(
                                        alpha: imageDarkenValue ?? 0,
                                      ),
                                    ),
                                  ),
                                ),
                              child ?? const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
