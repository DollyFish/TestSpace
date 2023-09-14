class Crew {
  final String name;
  final String agency;
  final String role;

  Crew({
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
}
