import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../API/data_repository.dart';
import '../../model/launch_model.dart';

part 'launch_event.dart';
part 'launch_state.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  final _launchRepository = LaunchRepository();

  LaunchBloc() : super(LaunchInitial()) {
    on<LaunchRequest>((event, emit) async {
      emit(LaunchLoading());
      try {
        final List<Launch> launch = await _launchRepository.getLaunch();
        emit(LaunchLoaded(launch));
      } catch (e) {
        emit(LaunchError(e.toString()));
      }
    });
  }
}
