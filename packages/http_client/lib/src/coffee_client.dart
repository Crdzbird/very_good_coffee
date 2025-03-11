part of 'coffee_client_repository.dart';

/// HTTP client that fetches [Coffee] from a remote server.
/// - [_dio] is the [Dio] instance used to make HTTP requests.
class CoffeeClient extends CoffeeClientRepository {
  CoffeeClient({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: DartEnvs().baseUrl));

  /// The [Dio] instance used to make HTTP requests.
  final Dio _dio;

  /// Fetches a [Coffee] from a remote server.
  @override
  Future<(String? error, Coffee? success)> fetchCoffee() async {
    try {
      final result = await _dio.get<Object>(EndpointsEnum.random.path);
      return (null, Coffee.fromJson(result.data));
    } on DioException catch (e) {
      return (e.message, null);
    }
  }
}
