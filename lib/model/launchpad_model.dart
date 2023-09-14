//create class launchpad_model
class Launchpad {
  final String name;
  final String locality;
  final String region;

  Launchpad({
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
}
