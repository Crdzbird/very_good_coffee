part of 'coffee_api_client_datasource.dart';

/// HTTP client that fetches [Coffee] from a remote server.
/// - [_dio] is the [Dio] instance used to make HTTP requests.
class CoffeeApiClient extends CoffeeApiClientDatasource {
  CoffeeApiClient({Dio? dio})
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
