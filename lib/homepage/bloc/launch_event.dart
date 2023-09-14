part of 'launch_bloc.dart';

@immutable
class LaunchRequest extends LaunchEvent {
  const LaunchRequest();
}

abstract class LaunchEvent extends Equatable {
  const LaunchEvent();
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}
