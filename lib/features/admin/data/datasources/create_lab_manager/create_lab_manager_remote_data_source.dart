import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart';

abstract class CreateLabManagerRemoteDataSource {
  Future<BaseResponseModel> createLabManager(CreateLabManagerEntity params);
}

@Injectable(as: CreateLabManagerRemoteDataSource)
class CreateLabManagerRemoteDataSourceImpl
    implements CreateLabManagerRemoteDataSource {
  CreateLabManagerRemoteDataSourceImpl(this.dioClient, this.authTokenStorage);

  final DioClient dioClient;
  final AuthTokenStorage authTokenStorage;

  Dio get dio => dioClient.dio;

  @override
  Future<BaseResponseModel> createLabManager(
    CreateLabManagerEntity params,
  ) async {
    try {
      final token = authTokenStorage.token;
      final formData = _buildFormData(params);

      final response = await dio.post(
        ApiEndpoints.createLabs,
        data: FormData.fromMap(formData),
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

  Map<String, dynamic> _buildFormData(CreateLabManagerEntity params) {
    final data = params.toJson();

    if (params.photo != null) {
      data['photo'] = MultipartFile.fromBytes(
        params.photo!,
        filename: params.photoName ?? 'lab_photo',
      );
    }

    return data;
  }
}
