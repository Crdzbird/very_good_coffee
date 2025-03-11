import 'package:dart_envs/dart_envs.dart';
import 'package:dio/dio.dart';
import 'package:http_client/http_client.dart';
import 'package:models/models.dart';

part 'coffee_client.dart';

/// A repository that fetches [Coffee] from a remote server.
/// - [fetchCoffee] fetches a [Coffee].
sealed class CoffeeClientRepository {
  Future<(String? error, Coffee? success)> fetchCoffee();
}
