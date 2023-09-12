import 'package:http/http.dart' as http;

// get launch data
class LaunchDataProvider {
  Future<http.Response> getRawLaunchData() async {
    http.Response rawLaunchData = await http.get(
      Uri.parse("https://api.spacexdata.com/latest/launches/past"),
    );

    return rawLaunchData;
  }
}

// get rocket data
class RocketDataProvider {
  Future<http.Response> getRawRocketData(String rocketID) async {
    http.Response rawRocketData = await http.get(
      Uri.parse("https://api.spacexdata.com/latest/rockets/$rocketID"),
    );

    return rawRocketData;
  }
}

// get crew data
class CrewDataProvider {
  Future<http.Response> getRawCrewData(String crewID) async {
    http.Response rawCrewData = await http.get(
      Uri.parse("https://api.spacexdata.com/latest/crew/$crewID"),
    );

    return rawCrewData;
  }
}

// get launchpad data
class LaunchpadDataProvider {
  Future<http.Response> getRawLaunchpadData(String launchpadID) async {
    http.Response rawLaunchpadData = await http.get(
      Uri.parse("https://api.spacexdata.com/latest/launchpads/$launchpadID"),
    );
    return rawLaunchpadData;
  }
}
