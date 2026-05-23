class LocationModel {
  final String name;
  final double lat;
  final double lng;

  LocationModel({
    required this.name,
    required this.lat,
    required this.lng,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['display_name'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['lon']),
    );
  }
}