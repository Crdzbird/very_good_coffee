part of 'coffee_client_repository.dart';

class CoffeeClient extends CoffeeClientRepository {
  CoffeeClient({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: DartEnvs().baseUrl));

  final Dio _dio;

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
