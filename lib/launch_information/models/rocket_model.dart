class Rocket {
  final String name;
  final String company;
  final String description;

  Rocket({
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
}
