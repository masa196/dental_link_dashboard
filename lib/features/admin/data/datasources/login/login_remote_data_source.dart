import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/login/login_response_model.dart';
import 'package:dental_link_dashboard/features/admin/data/models/logout/logout_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/login_entity.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponseModel> login(LoginEntity params);
  Future<LogoutResponseModel> logout(String token);
}

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  LoginRemoteDataSourceImpl(this.dioClient);

  final DioClient dioClient;

  Dio get dio => dioClient.dio;

  @override
  Future<LoginResponseModel> login(LoginEntity params) async {
    try {
      final response = await dio.post(
        ApiEndpoints.login,
        data: FormData.fromMap(params.toJson()),
      );

      final payload = _asMap(response.data);
      if (payload == null) {
        try {
          log(
            'LoginRemoteDataSourceImpl: payload is null. response.statusCode=${response.statusCode}',
          );
          log('LoginRemoteDataSourceImpl raw response: ${response.data}');
        } catch (_) {}
        throw const AppException(message: 'Invalid response format');
      }

      final model = LoginResponseModel.fromJson(payload);
      if (model.success != true) {
        try {
          log(
            'LoginRemoteDataSourceImpl: login success==false. status=${response.statusCode}',
          );
          log('LoginRemoteDataSourceImpl payload: $payload');
        } catch (_) {}

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
      if (error.error is AppException) {
        throw error.error as AppException;
      }
      throw AppException.fromDioException(error);
    }
  }

  @override
  Future<LogoutResponseModel> logout(String token) async {
    try {
      final response = await dio.post(
        ApiEndpoints.logout,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final payload = _asMap(response.data);
      if (payload == null) {
        throw const AppException(message: 'Invalid response format');
      }

      final model = LogoutResponseModel.fromJson(payload);
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
