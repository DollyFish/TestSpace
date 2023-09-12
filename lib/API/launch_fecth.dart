import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/launch_model.dart';

class LaunchDataProvider {
  Future<http.Response> getRawLaunchData() async {
    http.Response rawLaunchData = await http.get(
      Uri.parse("https://api.spacexdata.com/latest/launches/past"),
    );

    return rawLaunchData;
  }
}

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
