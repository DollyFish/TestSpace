//create class launchpad_model
import 'package:equatable/equatable.dart';

class Launchpad extends Equatable {
  final String name;
  final String locality;
  final String region;

  const Launchpad({
    this.name = '',
    this.locality = '',
    this.region = '',
  });

  factory Launchpad.fromJson(Map<String, dynamic> json) {
    return Launchpad(
      name: json['name'],
      locality: json['locality'],
      region: json['region'],
    );
  }

  @override
  List<Object> get props => [
        name,
        locality,
        region,
      ];
}
