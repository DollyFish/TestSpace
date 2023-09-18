import 'package:equatable/equatable.dart';

class Launch extends Equatable {
  final String name;
  final String time;
  final Map image;
  final bool? success;
  final String rocketID;
  final String launchpadID;
  final List crew;
  const Launch(
      {this.name = '',
      this.time = '',
      this.image = const {},
      this.success,
      this.rocketID = '',
      this.launchpadID = '',
      this.crew = const <String>[]});

  factory Launch.fromJson(Map json) {
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

  @override
  List<Object> get props => [
        name,
        time,
        image,
        rocketID,
        launchpadID,
        crew,
      ];
}
