part of 'repository.dart';

// get launch data
class LaunchDataProvider {
  Future<http.Response> getRawLaunchData() async {
    http.Response rawLaunchData = await http.get(
      Uri.parse("https://api.spacexdata.com/latest/launches/past"),
    );

    return rawLaunchData;
  }
}
