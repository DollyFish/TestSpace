part of 'information_bloc.dart';

@immutable
abstract class InformationState {}

class InformationInitial extends InformationState {}

class InformationLoading extends InformationState {}

class InformationLoaded extends InformationState {
  final Rocket rocket;
  final List<Crew> crew;
  final Launchpad launchpad;

  InformationLoaded(this.rocket, this.crew, this.launchpad);
}

class InformationError extends InformationState {
  final String message;

  InformationError(this.message);
}
