part of 'launch_bloc.dart';

@immutable
class LaunchState extends Equatable {
  final List<Launch> launch;
  final bool loading;
  const LaunchState({
    required this.launch,
    this.loading = false,
  });
  LaunchState copyWith({
    List<Launch>? launch,
    bool? loading,
  }) {
    return LaunchState(
      launch: launch ?? this.launch,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [
        launch,
        loading,
      ];
}
