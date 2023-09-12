class Launch {
  final String name;
  final String time;
  final String image;
  final bool? success;
  Launch(this.name, this.time, this.image, this.success);

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      json['name'],
      json['date_utc'],
      json['links']['patch']['small'],
      json['success'],
    );
  }
}
