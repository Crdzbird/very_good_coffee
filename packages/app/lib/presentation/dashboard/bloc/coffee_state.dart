part of 'coffee_cubit.dart';

sealed class CoffeeState extends Equatable {
  const CoffeeState();

  @override
  List<Object> get props => [];
}

final class CoffeeLoading extends CoffeeState {}

final class CoffeeLoaded extends CoffeeState {
  const CoffeeLoaded(this.coffee, {this.isFavorite = false});

  final Coffee coffee;
  final bool isFavorite;

  @override
  List<Object> get props => [coffee, isFavorite];
}

final class CoffeeError extends CoffeeState {
  const CoffeeError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
