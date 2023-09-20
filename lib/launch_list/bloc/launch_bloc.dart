import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:testing/launch_list/models/launch_model.dart';
import 'package:testing/launch_list/repository/launch_repository.dart';

part 'launch_event.dart';
part 'launch_state.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  LaunchBloc(this._launchRepository) : super(const LaunchState(launch: [])) {
    on<LaunchRequest>(_onGetRequest);
  }
  final LaunchRepository _launchRepository;
  void _onGetRequest(
    LaunchRequest event,
    Emitter<LaunchState> emit,
  ) async {
    await _onLaunchRequest(emit);
  }

  Future<void> _onLaunchRequest(Emitter<LaunchState> emit) async {
    emit(state.copyWith(loading: true));
    final List<Launch> launch = await _launchRepository.getLaunch();
    emit(state.copyWith(loading: false, launch: launch));
  }
}
