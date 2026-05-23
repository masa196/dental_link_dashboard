import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

/// الحالة الابتدائية
class LocationInitial extends LocationState {
  const LocationInitial();
}

/// أثناء التحميل
class LocationLoading extends LocationState {
  const LocationLoading();
}

/// نجاح جلب الموقع
class LocationLoaded extends LocationState {
  final LatLng currentLocation;
  final LatLng selectedLocation;
  final String locationName; // 🔥 جديد

  const LocationLoaded({
    required this.currentLocation,
    required this.selectedLocation,
    required this.locationName,
  });

  @override
  List<Object?> get props => [
    currentLocation,
    selectedLocation,
    locationName, // 🔥 مهم
  ];
}
/// خطأ
class LocationError extends LocationState {
  final String message;

  const LocationError(this.message);

  @override
  List<Object?> get props => [message];
}