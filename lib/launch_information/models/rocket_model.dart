import 'package:equatable/equatable.dart';

class Rocket extends Equatable {
  final String name;
  final String company;
  final String description;

  const Rocket({
    this.name = '',
    this.company = '',
    this.description = '',
  });

  // create get data from json function
  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      name: json['name'],
      company: json['company'],
      description: json['description'],
    );
  }

  @override
  List<Object> get props => [
        name,
        company,
        description,
      ];
}
