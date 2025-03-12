part of 'favorites_cubit.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded(this.coffeeList);

  final List<Coffee> coffeeList;

  @override
  List<Object> get props => [coffeeList];
}
