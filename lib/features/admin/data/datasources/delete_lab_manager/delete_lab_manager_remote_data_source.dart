import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/delete_lab_manager/delete_lab_manager_entity.dart';

abstract class DeleteLabManagerRemoteDataSource {
  Future<BaseResponseModel> deleteLabManager(DeleteLabManagerEntity params);
}

@Injectable(as: DeleteLabManagerRemoteDataSource)
class DeleteLabManagerRemoteDataSourceImpl
    implements DeleteLabManagerRemoteDataSource {
  DeleteLabManagerRemoteDataSourceImpl(this.dioClient, this.authTokenStorage);

  final DioClient dioClient;
  final AuthTokenStorage authTokenStorage;

  Dio get dio => dioClient.dio;

  @override
  Future<BaseResponseModel> deleteLabManager(
    DeleteLabManagerEntity params,
  ) async {
    try {
      final token = authTokenStorage.token;
      final endpoint = '${ApiEndpoints.deleteLabs}/${params.labId}';

      final response = await dio.delete(
        endpoint,
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
