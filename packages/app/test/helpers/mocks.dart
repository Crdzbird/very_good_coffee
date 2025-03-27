import 'package:app/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:http_client/http_client.dart';
import 'package:local_coffee/local_coffee.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  CoffeeApiClient,
  LocalCoffeeUsecase,
  CoffeeUsecase,
  FavoritesCubit,
])
class GeneratedMocks {}
