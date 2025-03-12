import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_client/http_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:models/models.dart';
import 'package:test/test.dart';

import 'coffee_api_client_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  HttpOverrides.global = _MyHttpOverrides();
  group('CoffeeApiClient', () {
    late MockDio mockDio;
    late CoffeeApiClient coffeeClient;

    setUpAll(() {
      mockDio = MockDio();
      coffeeClient = CoffeeApiClient(dio: mockDio);
    });

    test('fetchCoffee returns a coffee "fake_coffee"', () async {
      when(mockDio.get<Object>(EndpointsEnum.random.path)).thenAnswer(
        (_) async => Response(
          data: {'file': 'fake_coffee'},
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      final result = await coffeeClient.fetchCoffee();
      expect(result.$1, isNull);
      expect(result.$2, isNotNull);
      expect(result.$2, isA<Coffee>());
      expect(result.$2?.file, 'fake_coffee');
    });

    test('fetchCoffee returns error on DioException', () async {
      when(mockDio.get<Object>(EndpointsEnum.random.path)).thenThrow(
        DioException(
          error: 'This is a fake error',
          message: 'This is a fake error',
          requestOptions: RequestOptions(path: EndpointsEnum.random.path),
        ),
      );

      final result = await coffeeClient.fetchCoffee();
      expect(result.$1, isNotNull);
      expect(result.$2, isNull);
    });
  });
}

class _MyHttpOverrides extends HttpOverrides {}
