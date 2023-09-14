import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testing/homepage/repository/repository.dart';
import 'package:testing/homepage/bloc/launch_bloc.dart';
import 'package:testing/homepage/models/launch_model.dart';

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

    blocTest<LaunchBloc, LaunchState>('emit launch request event',
        build: () {
          when(() => launchRepository.getLaunch())
              .thenAnswer((_) => Future.value([mockLaunch]));
          return launchBloc;
        },
        skip: 1,
        act: (bloc) => bloc.add(const LaunchRequest()),
        expect: () => [
              launchBloc.state.copyWith(loading: false, launch: [mockLaunch])
            ]);
  }); // group
}

class MockLaunchRepository extends Mock implements LaunchRepository {}

final Launch mockLaunch = Launch();
