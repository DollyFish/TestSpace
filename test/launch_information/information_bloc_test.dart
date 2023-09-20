import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testing/launch_information/bloc/information_bloc.dart';
import 'package:testing/launch_information/models/crew_model.dart';
import 'package:testing/launch_information/models/launchpad_model.dart';
import 'package:testing/launch_information/models/rocket_model.dart';
import 'package:testing/launch_information/repository/information_repository.dart';

void main() {
  late InformationBloc informationBloc;
  late RocketRepository rocketRepository;
  late CrewRepository crewRepository;
  late LaunchpadRepository launchpadRepository;

  group('InformationBloc test', () {
    setUp(() {
      EquatableConfig.stringify = true;
      rocketRepository = MockRocketRepository();
      crewRepository = MockCrewRepository();
      launchpadRepository = MockLaunchpadRepository();
      informationBloc = InformationBloc(
          rocketRepository, crewRepository, launchpadRepository);
    });

    tearDown(() {
      informationBloc.close();
    });

    blocTest<InformationBloc, InformationState>(
        'emit information request event',
        build: () {
          when(() => rocketRepository.getRocket(rocketID))
              .thenAnswer((_) => Future.value(mockRocket));
          when(() => crewRepository.getCrew(crewList))
              .thenAnswer((_) => Future.value(mockCrew));
          when(() => launchpadRepository.getLaunchpad(launchpadID))
              .thenAnswer((_) => Future.value(mockLaunchpad));
          return informationBloc;
        },
        act: (bloc) => bloc.add(InformationRequest(
            rocketID: rocketID, crewList: crewList, launchpadID: launchpadID)),
        expect: () => [
              informationBloc.state.copyWith(
                rocket: const Rocket(),
                crew: const [],
                launchpad: const Launchpad(),
                loading: true,
              ),
              informationBloc.state.copyWith(
                rocket: mockRocket,
                crew: mockCrew,
                launchpad: mockLaunchpad,
                loading: false,
              )
            ]);

    test('Check event true', () {
      expect(
          true,
          InformationRequest(
                  rocketID: rocketID,
                  crewList: crewList,
                  launchpadID: launchpadID) ==
              InformationRequest(
                  rocketID: rocketID,
                  crewList: crewList,
                  launchpadID: launchpadID));
    });

    test('Check event false', () {
      expect(
          false,
          InformationRequest(
                  rocketID: rocketID,
                  crewList: crewList,
                  launchpadID: launchpadID) ==
              InformationRequest(
                  rocketID: launchpadID,
                  crewList: crewList,
                  launchpadID: rocketID));
    });
  });
}

class MockRocketRepository extends Mock implements RocketRepository {}

class MockCrewRepository extends Mock implements CrewRepository {}

class MockLaunchpadRepository extends Mock implements LaunchpadRepository {}

const Rocket mockRocket = Rocket();

final List<Crew> mockCrew = [];

const Launchpad mockLaunchpad = Launchpad();

const String rocketID = "5e9d0d95eda69973a809d1ec";

const String launchpadID = "5e9e4502f509094188566f88";

final List crewList = [
  {"crew": "62dd7196202306255024d13c", "role": "Commander"},
  {"crew": "62dd71c9202306255024d13d", "role": "Pilot"},
  {"crew": "62dd7210202306255024d13e", "role": "Mission Specialist 1"},
  {"crew": "62dd7253202306255024d13f", "role": "Mission Specialist 2"}
];
