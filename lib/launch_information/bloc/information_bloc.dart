import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:testing/launch_information/models/crew_model.dart';
import 'package:testing/launch_information/models/launchpad_model.dart';
import 'package:testing/launch_information/models/rocket_model.dart';
import 'package:testing/launch_information/repository/repository.dart';

part 'information_event.dart';
part 'information_state.dart';

class InformationBloc extends Bloc<InformationEvent, InformationState> {
  InformationBloc(
      this._rocketRepository, this._crewRepository, this._launchpadRepository)
      : super(const InformationState(
            rocket: Rocket(), crew: [], launchpad: Launchpad())) {
    on<InformationRequest>(_onGetRequest);
  }
  final RocketRepository _rocketRepository;
  final CrewRepository _crewRepository;
  final LaunchpadRepository _launchpadRepository;

  void _onGetRequest(
    InformationRequest event,
    Emitter<InformationState> emit,
  ) async {
    await _onInformationRequest(emit, event);
  }

  Future<void> _onInformationRequest(
    Emitter<InformationState> emit,
    InformationRequest event,
  ) async {
    emit(state.copyWith(loading: true));
    final rocket = _rocketRepository.getRocket(event.rocketID);
    final crew = _crewRepository.getCrew(event.crewList);
    final launchpad = _launchpadRepository.getLaunchpad(event.launchpadID);

    await Future.wait([rocket, crew, launchpad]).then((value) {
      emit(state.copyWith(
        rocket: value[0] as Rocket,
        crew: value[1] as List<Crew>,
        launchpad: value[2] as Launchpad,
        loading: false,
      ));
    });
  }
}
