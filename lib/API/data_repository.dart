import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/crew_model.dart';
import '../model/launch_model.dart';
import '../model/launchpad_model.dart';
import '../model/rocket_model.dart';
import 'data_provider.dart';

// get launch data
class LaunchRepository {
  final LaunchDataProvider launchDataProvider = LaunchDataProvider();

  Future<List<Launch>> getLaunch() async {
    final http.Response rawLaunch = await launchDataProvider.getRawLaunchData();
    final json = await jsonDecode(rawLaunch.body);
    List<Launch> launchList = [];
    for (var itemJson in json) {
      launchList.add(Launch.fromJson(itemJson));
    }

    return launchList;
  }
}

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
    for (var item in response) {
      final json = await jsonDecode(item.body);
      crew.add(Crew.fromJson(json));
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
