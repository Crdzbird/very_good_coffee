import 'package:dart_envs/dart_envs.dart';
import 'package:dio/dio.dart';
import 'package:http_client/http_client.dart';
import 'package:models/models.dart';

part 'coffee_client.dart';

sealed class CoffeeClientRepository {
  Future<(String? error, Coffee? success)> fetchCoffee();
}
