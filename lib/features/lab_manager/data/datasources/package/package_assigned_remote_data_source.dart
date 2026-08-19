

import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/package/package_assigned_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class PackageAssignedRemoteDataSource {
  Future<PackageAssignedResponse> getPackageAssigned();

 
}

@Injectable(as: PackageAssignedRemoteDataSource)
class PackageAssignedRemoteDataSourceImpl
    implements PackageAssignedRemoteDataSource {
  PackageAssignedRemoteDataSourceImpl(
    this.dioClient,
    this.authTokenStorage,
  );

  final DioClient dioClient;
  final AuthTokenStorage authTokenStorage;

  Dio get dio => dioClient.dio;

  @override
  Future<PackageAssignedResponse> getPackageAssigned() async {
    try {
      final token = authTokenStorage.token;

      final response = await dio.get(
        ApiEndpoints.packageAssigned,
        options: Options(
          headers: token == null || token.isEmpty
              ? null
              : {
                  'Authorization': 'Bearer $token',
                },
        ),
      );

      final payload = _asMap(response.data);

      if (payload == null) {
        throw const AppException(
          message: 'Invalid response format',
        );
      }

      final model = PackageAssignedResponse.fromJson(payload);

      if (model.success != true) {
        throw AppException.fromResponse(
          payload,
          fallbackStatusCode: response.statusCode,
          rawResponse: response.data,
        );
      }

      return model;
    } on DioException catch (error) {
      if (error.error is AppException) {
        throw error.error as AppException;
      }

      throw AppException.fromDioException(error);
    }
  }

 

  Map<String, dynamic>? _asMap(Object? raw) {
    if (raw is Map<String, dynamic>) return raw;

    if (raw is Map) {
      return raw.map(
        (key, value) => MapEntry(
          key.toString(),
          value,
        ),
      );
    }

    return null;
  }
}