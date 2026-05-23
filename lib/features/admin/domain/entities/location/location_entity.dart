class LocationEntity {
  final String? name;
  final double? lat;
  final double? lng;
  final bool isSelected;

  const LocationEntity({
    this.name,
    this.lat,
    this.lng,
    this.isSelected = false,
  });

  LocationEntity copyWith({
    String? name,
    double? lat,
    double? lng,
    required bool isSelected,
  }) {
    return LocationEntity(
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      isSelected: isSelected,
    );
  }
}