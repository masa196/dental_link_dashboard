import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

abstract class DeleteDepartmentRemoteDataSource {
  Future<BaseResponseModel> deleteDepartment(int departmentId);
}

@Injectable(as: DeleteDepartmentRemoteDataSource)
class DeleteDepartmentRemoteDataSourceImpl
    implements DeleteDepartmentRemoteDataSource {
  DeleteDepartmentRemoteDataSourceImpl(this.dioClient, this.authTokenStorage);

  final DioClient dioClient;
  final AuthTokenStorage authTokenStorage;

  Dio get dio => dioClient.dio;

  @override
  Future<BaseResponseModel> deleteDepartment(int departmentId) async {
    try {
      final token = authTokenStorage.token;
      final response = await dio.delete(
        '${ApiEndpoints.departments}/$departmentId',
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

      final model = BaseResponseModel.fromJson(payload);
      if (model.success != true) {
        throw AppException.fromDioException(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
          ),
        );
      }

      return model;
    } on DioException catch (error) {
      debugPrint('TYPE: ${error.type}');
      debugPrint('MESSAGE: ${error.message}');
      debugPrint('ERROR: ${error.error}');
      debugPrint('RESPONSE: ${error.response}');
      rethrow;
    }
  }

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return null;
  }
}
