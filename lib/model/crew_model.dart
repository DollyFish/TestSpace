class Crew {
  final String name;
  final String agency;

  Crew({
    this.name = '',
    this.agency = '',
  });

  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(
      name: json['name'],
      agency: json['agency'],
    );
  }
}
