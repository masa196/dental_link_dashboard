import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/features/admin/data/models/location/location_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart';

abstract class BaseLocationRemoteDataSource {
  Future<List<LocationModel>> searchLocation(CreateLabManagerEntity data);

  Future<LocationModel> reverseLocation(CreateLabManagerEntity data);
}

@Injectable(as: BaseLocationRemoteDataSource)
class LocationRemoteDataSource implements BaseLocationRemoteDataSource {
  final DioClient dioClient;

  LocationRemoteDataSource(this.dioClient);

  Dio get dio => dioClient.dio;

  @override
  Future<List<LocationModel>> searchLocation(
    CreateLabManagerEntity data,
  ) async {
    final response = await dio.get(
      ApiEndpoints.searchLocation,
      queryParameters: {
        "q": data.location!.name,
        "format": "json",
        "limit": 5,
        "countrycodes": "sy",
        'accept-language': 'ar',
      },
      options: Options(
        headers: {"User-Agent": "flutter-app", 'Accept-Language': 'ar'},
      ),
    );

    final list = response.data as List;

    return list.map((e) {
      return LocationModel(
        name: e['display_name'],
        lat: double.parse(e['lat']),
        lng: double.parse(e['lon']),
      );
    }).toList();
  }

  @override
  Future<LocationModel> reverseLocation(CreateLabManagerEntity data) async {
    final response = await dio.get(
      ApiEndpoints.reverseLocation,
      queryParameters: {
        "lat": data.location!.lat,
        "lon": data.location!.lng,
        "format": "json",
        'accept-language': 'ar',
      },
      options: Options(
        headers: {"User-Agent": "flutter-app", 'Accept-Language': 'ar'},
      ),
    );

    final data1 = response.data;

    return LocationModel(
      name: data1['display_name'],
      lat: double.parse(data1['lat']),
      lng: double.parse(data1['lon']),
    );
  }
}
