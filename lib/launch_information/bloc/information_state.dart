part of 'information_bloc.dart';

@immutable
class InformationState extends Equatable {
  final Rocket rocket;
  final List<Crew> crew;
  final Launchpad launchpad;
  final bool loading;

  const InformationState({
    required this.rocket,
    required this.crew,
    required this.launchpad,
    this.loading = false,
  });

  InformationState copyWith({
    Rocket? rocket,
    List<Crew>? crew,
    Launchpad? launchpad,
    bool? loading,
  }) {
    return InformationState(
      rocket: rocket ?? this.rocket,
      crew: crew ?? this.crew,
      launchpad: launchpad ?? this.launchpad,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [
        rocket,
        crew,
        launchpad,
        loading,
      ];
}
