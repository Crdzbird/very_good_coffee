import 'dart:async';

import 'package:app/presentation/widgets/parallax/paralax_sensors_enum.dart';
import 'package:app/presentation/widgets/parallax/parallax_layer.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Parallax extends StatefulWidget {
  const Parallax({
    required this.layers,
    super.key,
    this.sensor = ParallaxSensorsEnum.gyroscope,
    this.reverseVerticalAxis = false,
    this.reverseHorizontalAxis = false,
    this.lockVerticalAxis = false,
    this.lockHorizontalAxis = false,
    this.animationDuration = 300,
    this.child,
  });

  final ParallaxSensorsEnum sensor;
  final List<Layer> layers;
  final bool reverseVerticalAxis;
  final bool reverseHorizontalAxis;
  final bool lockVerticalAxis;
  final bool lockHorizontalAxis;
  final int animationDuration;
  final Widget? child;

  @override
  State<Parallax> createState() => _ParallaxState();
}

class _ParallaxState extends State<Parallax> {
  StreamSubscription<GyroscopeEvent>? _gyroscopeSensorEvent;

  final ValueNotifier<double> _top = ValueNotifier<double>(0);
  final ValueNotifier<double> _bottom = ValueNotifier<double>(0);
  final ValueNotifier<double> _right = ValueNotifier<double>(0);
  final ValueNotifier<double> _left = ValueNotifier<double>(0);
  double _maxSensitivity = 0;
  DateTime _lastUpdate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.sensor == ParallaxSensorsEnum.gyroscope) {
      _gyroscopeSensorEvent = gyroscopeEventStream().listen((
        GyroscopeEvent event,
      ) {
        _maxSensitivity = 10;
        processSensorEvent(event.y, event.x);
      });
    }
  }

  void processSensorEvent(double x, double y) {
    final now = DateTime.now();
    if (now.difference(_lastUpdate).inMilliseconds > 100) {
      _lastUpdate = now;
      if (_shouldUpdateValues(x, y)) {
        _top.value =
            widget.lockVerticalAxis
                ? 0
                : widget.reverseVerticalAxis
                ? -y
                : y;
        _bottom.value =
            widget.lockVerticalAxis
                ? 0
                : widget.reverseVerticalAxis
                ? y
                : -y;
        _right.value =
            widget.lockHorizontalAxis
                ? 0
                : widget.reverseHorizontalAxis
                ? -x
                : x;
        _left.value =
            widget.lockHorizontalAxis
                ? 0
                : widget.reverseHorizontalAxis
                ? x
                : -x;
        setState(() {});
      }
    }
  }

  bool _shouldUpdateValues(double x, double y) {
    const threshold = 0.1;
    return (x - _left.value).abs() > threshold ||
        (y - _top.value).abs() > threshold;
  }

  @override
  void dispose() {
    _gyroscopeSensorEvent?.cancel();
    _top.dispose();
    _bottom.dispose();
    _right.dispose();
    _left.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children:
              widget.layers
                  .map(
                    (layer) => layer.build(
                      context,
                      widget.animationDuration,
                      _maxSensitivity,
                      _top,
                      _bottom,
                      _right,
                      _left,
                    ),
                  )
                  .toList(),
        ),
        widget.child ?? Container(),
      ],
    );
  }
}
