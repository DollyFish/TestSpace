class Launch {
  final String name;
  final String time;
  final Map<String, dynamic> image;
  final bool? success;
  final String rocketID;
  final String launchpadID;
  final List crew;
  Launch(this.name, this.time, this.image, this.success, this.rocketID,
      this.launchpadID, this.crew);

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      json['name'],
      json['date_utc'],
      json['links']['patch'],
      json['success'],
      json['rocket'],
      json['launchpad'],
      json['crew'],
    );
  }
}
