import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testing/homepage/models/launch_model.dart';

part 'launch_provider.dart';

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
