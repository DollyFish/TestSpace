class Launch {
  final String name;
  final String time;
  final Map<String, dynamic> image;
  final bool? success;
  final String rocketID;
  final String launchpadID;
  final List crew;
  Launch(
      {this.name = '',
      this.time = '',
      this.image = const <String, dynamic>{},
      this.success,
      this.rocketID = '',
      this.launchpadID = '',
      this.crew = const <String>[]});

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      name: json['name'],
      time: json['date_local'],
      image: json['links']['patch'],
      success: json['success'],
      rocketID: json['rocket'],
      launchpadID: json['launchpad'],
      crew: json['crew'],
    );
  }
}
