import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testing/launch_list/bloc/launch_bloc.dart';
import 'package:testing/launch_list/models/launch_model.dart';
import 'package:testing/launch_list/repository/launch_repository.dart';

void main() {
  late LaunchBloc launchBloc;
  late LaunchRepository launchRepository;
  group('LaunchBloc Test', () {
    setUp(() {
      EquatableConfig.stringify = true;
      launchRepository = MockLaunchRepository();
      launchBloc = LaunchBloc(launchRepository);
    });

    tearDown(() {
      launchBloc.close();
    });

    blocTest<LaunchBloc, LaunchState>(
      'emit launch request event',
      build: () {
        when(() => launchRepository.getLaunch())
            .thenAnswer((_) => Future.value([mockLaunch]));
        return launchBloc;
      },
      act: (bloc) => bloc.add(const LaunchRequest()),
      expect: () => [
        launchBloc.state.copyWith(loading: true, launch: const []),
        launchBloc.state.copyWith(launch: [mockLaunch])
      ],
    );
  }); // group
}

class MockLaunchRepository extends Mock implements LaunchRepository {}

const Launch mockLaunch = Launch();
