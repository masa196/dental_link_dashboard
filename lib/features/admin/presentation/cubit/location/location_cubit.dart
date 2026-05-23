
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/admin/data/models/location/location_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import '../../../domain/entities/location/location_entity.dart';

import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {

  LocationCubit() : super(const LocationInitial());

  /// 🔥 جلب موقع المستخدم
  Future<void> getUserLocation() async {
    emit(const LocationLoading());

    try {
      // 1. Permission
      final permission = await Permission.location.request();

      if (permission.isDenied) {
        emit(const LocationError("تم رفض صلاحية الموقع"));
        return;
      }

      if (permission.isPermanentlyDenied) {
        await openAppSettings();
        emit(const LocationError("يجب تفعيل الصلاحية من الإعدادات"));
        return;
      }

      // 2. GPS
      final location = Location();
      bool serviceEnabled = await location.serviceEnabled();

      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();

        if (!serviceEnabled) {
          emit(const LocationError("GPS غير مفعل"));
          return;
        }
      }

      // 3. Get position
      final position = await Geolocator.getCurrentPosition();

      final latLng = LatLng(position.latitude, position.longitude);

      // 🔥 4. Reverse Geocoding
      final reverseUseCase =
      locator<BaseUseCase<LocationModel, CreateLabManagerEntity>>(
        instanceName: 'ReverseLocation',
      );

      final result = await reverseUseCase(
        CreateLabManagerEntity(
          location: LocationEntity(
            lat: latLng.latitude,
            lng: latLng.longitude,
          ),
        ),
      );
      result.fold(
        (failure) {
          emit(LocationError(failure.message));
        },
        (location) {
          emit(
            LocationLoaded(
              currentLocation: latLng,
              selectedLocation: latLng,
              locationName: location.name,
            ),
          );
        },
      );
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  /// 🔥 اختيار موقع من الخريطة
  Future<void> selectLocation(LatLng point) async {
    final currentState = state;

    if (currentState is LocationLoaded) {
      try {
        // 🔥 نطلب اسم المكان
        final reverseUseCase =
        locator<BaseUseCase<LocationModel, CreateLabManagerEntity>>(
          instanceName: 'ReverseLocation',
        );

        final result = await reverseUseCase(
          CreateLabManagerEntity(
            location: LocationEntity(
              lat: point.latitude,
              lng: point.longitude,
            ),
          ),
        );
        result.fold(
          (failure) {
            emit(LocationError(failure.message));
          },
          (location) {
            emit(
              LocationLoaded(
                currentLocation: point,
                selectedLocation: point,
                locationName: location.name,
              ),
            );
          },
        );
      } catch (e) {
        emit(const LocationError("فشل جلب اسم الموقع"));
      }
    }
  }
}