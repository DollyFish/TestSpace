part of 'ship_bloc.dart';

@immutable
abstract class ShipState {}

class ShipInitial extends ShipState {}

class ShipLoading extends ShipState {}

class ShipLoaded extends ShipState {
  final List<Ship> ships;

  ShipLoaded(this.ships);
}

class ShipError extends ShipState {
  final String message;

  ShipError(this.message);
}
