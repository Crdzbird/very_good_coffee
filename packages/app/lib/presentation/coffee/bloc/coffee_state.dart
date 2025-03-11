part of 'coffee_bloc.dart';

sealed class CoffeeState extends Equatable {
  const CoffeeState();

  @override
  List<Object> get props => [];
}

final class CoffeeLoading extends CoffeeState {}

final class CoffeeLoaded extends CoffeeState {
  const CoffeeLoaded(this.coffee);

  final Coffee coffee;

  @override
  List<Object> get props => [coffee];
}

final class CoffeeError extends CoffeeState {
  const CoffeeError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
