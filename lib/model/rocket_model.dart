class Rocket {
  final String name;
  final String country;
  final String company;
  final String description;
  final Map<String, dynamic> height;
  final Map<String, dynamic> mass;

  Rocket(this.name, this.country, this.company, this.description, this.height,
      this.mass);

  // create get data from json function
  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      json['name'],
      json['country'],
      json['company'],
      json['description'],
      json['height'],
      json['mass'],
    );
  }
}
