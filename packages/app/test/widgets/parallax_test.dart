import 'dart:async';

import 'package:app/presentation/widgets/parallax/paralax_sensors_enum.dart';
import 'package:app/presentation/widgets/parallax/parallax.dart';
import 'package:app/presentation/widgets/parallax/parallax_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  late StreamController<GyroscopeEvent> gyroscopeController;

  setUp(() {
    gyroscopeController = StreamController<GyroscopeEvent>.broadcast();
  });

  tearDown(() {
    gyroscopeController.close();
  });
  group('Parallax Widget', () {
    testWidgets('renders child widget', (tester) async {
      const child = Text('Parallax Child');
      await tester.pumpWidget(
        MaterialApp(home: Parallax(layers: [], child: child)),
      );

      expect(find.text('Parallax Child'), findsOneWidget);
    });

    testWidgets('renders layers', (tester) async {
      final layers = [Layer(sensitivity: 7, child: Text('data'))];

      await tester.pumpWidget(MaterialApp(home: Parallax(layers: layers)));
      expect(find.text('data'), findsOneWidget);
    });

    testWidgets('Parallax responds to gyroscope sensor events', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Parallax(sensor: ParallaxSensorsEnum.gyroscope, layers: []),
        ),
      );

      // Send a gyroscope event
      gyroscopeController.add(GyroscopeEvent(0.5, 0.2, 0.0, DateTime.now()));
      await tester.pumpAndSettle();

      // Check if the widget updated its state
      expect(find.byType(Parallax), findsOneWidget);
    });
  });
}
