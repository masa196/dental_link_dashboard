import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_entity/employee_entity.dart';

abstract class UpdateEmployeeRemoteDataSource {
  Future<BaseResponseModel> updateEmployee(EmployeeEntity params);
}

@Injectable(as: UpdateEmployeeRemoteDataSource)
class UpdateEmployeeRemoteDataSourceImpl implements UpdateEmployeeRemoteDataSource {
  UpdateEmployeeRemoteDataSourceImpl(this.dioClient, this.authTokenStorage);

  final DioClient dioClient;
  final AuthTokenStorage authTokenStorage;

  Dio get dio => dioClient.dio;

  @override
  Future<BaseResponseModel> updateEmployee(EmployeeEntity params) async {
    try {
      final token = authTokenStorage.token;
      if (params.id == null) {
        throw const AppException(
          message: 'Employee ID is required for updating.',
        );
      }

      final Map<String, dynamic> bodyData = {
        'name': params.name,
        'email': params.email,
        'birthdate': params.birthdate,
        'joined_at': params.joinedAt,
        'role_id': params.roleId,
        'phone': params.phone,
      };

      // إضافة كلمة المرور فقط إذا تم تعديلها ولم تكن فارغة
      if (params.password.trim().isNotEmpty) {
        bodyData['password'] = params.password;
        bodyData['password_confirmation'] = params.passwordConfirmation;
      }

      final formData = FormData.fromMap(bodyData);

      // 💡 الحل الجذري للصورة: لا نرفع أي ملف إلا إذا كانت البايتس موجودة (صورة جديدة)
      // المسار القديم (profileImagePath) نتجاهله تماماً هنا لكي لا يظنه كود الـ Multipart ملفاً محلياً
      if (params.profileImageBytes != null) {
        formData.files.add(
          MapEntry(
            'profile_image', // تأكد من مطابقة هذا الاسم مع ما يتوقعه السيرفر
            MultipartFile.fromBytes(
              params.profileImageBytes!,
              filename: params.profileImageName ?? 'profile_image.jpg',
            ),
          ),
        );
      }

      // إضافة مصفوفة الأقسام بالشكل الصحيح لـ Laravel / Backend
      for (final departmentId in params.departmentIds) {
        formData.fields.add(
          MapEntry('departments_ids[]', departmentId.toString()),
        );
      }

      final response = await dio.post(
        '${ApiEndpoints.employees}/${params.id}',
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