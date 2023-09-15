import 'package:equatable/equatable.dart';

class Crew extends Equatable {
  final String name;
  final String agency;
  final String role;

  const Crew({
    this.name = '',
    this.agency = '',
    this.role = '',
  });

  factory Crew.fromJson(Map<String, dynamic> json, String role) {
    return Crew(
      name: json['name'],
      agency: json['agency'],
      role: role,
    );
  }

  @override
  List<Object> get props => [
        name,
        agency,
        role,
      ];
}
