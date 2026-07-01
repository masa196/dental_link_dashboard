import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_entity/employee_entity.dart';

abstract class CreateEmployeeRemoteDataSource {
  Future<BaseResponseModel> createEmployee(EmployeeEntity params);
}

@Injectable(as: CreateEmployeeRemoteDataSource)
class CreateEmployeeRemoteDataSourceImpl
    implements CreateEmployeeRemoteDataSource {
  CreateEmployeeRemoteDataSourceImpl(this.dioClient, this.authTokenStorage);

  final DioClient dioClient;
  final AuthTokenStorage authTokenStorage;

  Dio get dio => dioClient.dio;

  @override
  Future<BaseResponseModel> createEmployee(EmployeeEntity params) async {
    try {
      final token = authTokenStorage.token;
      final formData = FormData.fromMap({
        'name': params.name,
        'email': params.email,
        'password': params.password,
        'password_confirmation': params.passwordConfirmation,
        'birthdate': params.birthdate,
        'joined_at': params.joinedAt,
        'role_id': params.roleId,
        'phone': params.phone,
        if (params.hasProfileImage)
          'profile_image': await _buildProfileImage(params),
      });

      for (final departmentId in params.departmentIds) {
        formData.fields.add(
          MapEntry('departments_ids[]', departmentId.toString()),
        );
      }

      final response = await dio.post(
        ApiEndpoints.employees,
        data: formData,
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
        throw AppException.fromResponse(
          payload,
          fallbackStatusCode: response.statusCode,
          rawResponse: response.data,
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

  Future<MultipartFile> _buildProfileImage(EmployeeEntity params) async {
    final bytes = params.profileImageBytes;
    final fileName = params.profileImageName ?? 'profile_image';

    if (bytes != null) {
      return MultipartFile.fromBytes(bytes, filename: fileName);
    }

    final path = params.profileImagePath;
    if (path != null && path.isNotEmpty) {
      return MultipartFile.fromFile(path, filename: fileName);
    }

    throw const AppException(message: 'Profile image is missing');
  }

  Map<String, dynamic>? _asMap(Object? raw) {
    if (raw is Map<String, dynamic>) return raw;
    if (raw is Map) {
      return raw.map((key, value) => MapEntry(key.toString(), value));
    }
    return null;
  }
}
