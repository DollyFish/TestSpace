import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../API/data_repository.dart';
import '../../model/crew_model.dart';
import '../../model/launch_model.dart';
import '../../model/launchpad_model.dart';
import '../../model/rocket_model.dart';

part 'information_event.dart';
part 'information_state.dart';

class InformationBloc extends Bloc<InformationEvent, InformationState> {
  InformationBloc() : super(InformationInitial()) {
    on<InformationRequest>((event, emit) async {
      emit(InformationLoading());
      final rocket = RocketRepository().getRocket(event.launch.rocketID);
      final crew = CrewRepository().getCrew(event.launch.crew);
      final launchpad =
          LaunchpadRepository().getLaunchpad(event.launch.launchpadID);
      await Future.wait([rocket, crew, launchpad]).then((value) {
        emit(InformationLoaded(
            value[0] as Rocket, value[1] as List<Crew>, value[2] as Launchpad));
      });
    });
  }
}
