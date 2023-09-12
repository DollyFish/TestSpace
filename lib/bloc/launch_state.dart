part of 'launch_bloc.dart';

@immutable
abstract class LaunchState {}

class LaunchInitial extends LaunchState {}

class LaunchLoading extends LaunchState {}

class LaunchLoaded extends LaunchState {
  final List<Launch> launch;

  LaunchLoaded(this.launch);
}

class LaunchError extends LaunchState {
  final String message;

  LaunchError(this.message);
}
