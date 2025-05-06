class Coordinates {
  final double lon;
  final double lat;

  Coordinates({required this.lon, required this.lat});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lon: json['lon']?.toDouble() ?? 0.0,
      lat: json['lat']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'lon': lon,
    'lat': lat,
  };
}