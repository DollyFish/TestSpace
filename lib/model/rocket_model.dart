class Rocket {
  final String name;
  final String country;
  final String company;
  final String description;
  final Map<String, dynamic> height;
  final Map<String, dynamic> mass;

  Rocket(
      {this.name = '',
      this.country = '',
      this.company = '',
      this.description = '',
      this.height = const <String, dynamic>{},
      this.mass = const <String, dynamic>{}});

  // create get data from json function
  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      name: json['name'],
      country: json['country'],
      company: json['company'],
      description: json['description'],
      height: json['height'],
      mass: json['mass'],
    );
  }
}
