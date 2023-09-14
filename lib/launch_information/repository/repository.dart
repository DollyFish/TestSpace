import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/crew_model.dart';
import '../models/launchpad_model.dart';
import '../models/rocket_model.dart';

part 'provider.dart';

// get rocket data
class RocketRepository {
  final RocketDataProvider rocketDataProvider = RocketDataProvider();

  Future<Rocket> getRocket(String rocketID) async {
    final http.Response rawRocket =
        await rocketDataProvider.getRawRocketData(rocketID);
    final json = await jsonDecode(rawRocket.body);
    Rocket rocket = Rocket.fromJson(json);

    return rocket;
  }
}

// get crew data
class CrewRepository {
  final CrewDataProvider crewDataProvider = CrewDataProvider();

  Future<List<Crew>> getCrew(List crewList) async {
    var response = await Future.wait(List.generate(crewList.length, (index) {
      return crewDataProvider.getRawCrewData(crewList[index]['crew']);
    }));
    List<Crew> crew = [];
    for (int i = 0; i < response.length; i++) {
      final json = await jsonDecode(response[i].body);
      crew.add(Crew.fromJson(json, crewList[i]['role']));
    }

    return crew;
  }
}

// get launchpad data
class LaunchpadRepository {
  final LaunchpadDataProvider launchpadDataProvider = LaunchpadDataProvider();

  Future<Launchpad> getLaunchpad(String launchpadID) async {
    final http.Response rawLaunchpad =
        await launchpadDataProvider.getRawLaunchpadData(launchpadID);
    final json = await jsonDecode(rawLaunchpad.body);
    Launchpad launchpad = Launchpad.fromJson(json);

    return launchpad;
  }
}
