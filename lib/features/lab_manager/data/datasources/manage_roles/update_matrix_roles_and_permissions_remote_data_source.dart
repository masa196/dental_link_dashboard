import 'package:dental_link_dashboard/features/lab_manager/domain/entities/matrix_roles_entity/matrix_roles_entity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';


abstract class UpdateMatrixRolesAndPermissionsRemoteDataSource {
  Future<Map<String, dynamic>> updateMatrix(MatrixRolesEntity params);
}

@Injectable(as: UpdateMatrixRolesAndPermissionsRemoteDataSource)
class UpdateMatrixRolesAndPermissionsRemoteDataSourceImpl
    implements UpdateMatrixRolesAndPermissionsRemoteDataSource {
  UpdateMatrixRolesAndPermissionsRemoteDataSourceImpl(
    this.dioClient,
    this.authTokenStorage,
  );

  final DioClient dioClient;
  final AuthTokenStorage authTokenStorage;

  Dio get dio => dioClient.dio;

  @override
  Future<Map<String, dynamic>> updateMatrix(MatrixRolesEntity params) async {
    try {
      final token = authTokenStorage.token;

      final response = await dio.put(
        ApiEndpoints.matrixRolesAndPermissions, 
        data: {
          "matrix": params.matrix.map((e) => e.toJson()).toList(),
        },
        options: Options(
          headers: token == null || token.isEmpty
              ? null
              : {'Authorization': 'Bearer $token'},
        ),
      );

      final payload = _asMap(response.data);

      if (payload == null) {
        throw const AppException(message: 'Invalid response format');
      }

      final success = payload['success'] ?? false;

      if (success != true) {
        throw AppException.fromResponse(
          payload,
          fallbackStatusCode: response.statusCode,
          rawResponse: response.data,
        );
      }

      return payload;
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
      return raw.map((key, value) => MapEntry(key.toString(), value));
    }
    return null;
  }
}