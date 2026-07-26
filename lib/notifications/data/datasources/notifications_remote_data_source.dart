import 'package:dental_link_dashboard/notifications/data/models/show_notifications_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';

import '../models/device_token_request_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<void> createDeviceToken(DeviceTokenRequestModel params);
    Future<ShowNotificationResponse> showNotifications();
}

@Injectable(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  NotificationsRemoteDataSourceImpl(
    this.dioClient,
    this.authTokenStorage,
  );

  final DioClient dioClient;
  final AuthTokenStorage authTokenStorage;

  Dio get dio => dioClient.dio;

  @override
  Future<void> createDeviceToken(
    DeviceTokenRequestModel params,
  ) async {
    try {
      final token = authTokenStorage.token;

      debugPrint('========== Register Device Token ==========');
      debugPrint('Access Token Exists: ${token != null && token.isNotEmpty}');
      debugPrint('FCM Token: ${params.token}');
      debugPrint('Device Type: ${params.deviceType}');
      debugPrint('Endpoint: ${ApiEndpoints.createDeviceToken}');

      final response = await dio.post(
        ApiEndpoints.createDeviceToken,
        data: params.toJson(),
        options: Options(
          headers: token == null || token.isEmpty
              ? null
              : {
                  'Authorization': 'Bearer $token',
                },
        ),
      );

      debugPrint('Response Status: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      final payload = _asMap(response.data);

      if (payload == null) {
        debugPrint('Response payload is NULL');
        throw const AppException(
          message: 'Invalid response format',
        );
      }

      if (payload['success'] != true) {
        debugPrint('API returned success = false');
        throw AppException.fromDioException(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
          ),
        );
      }

      debugPrint('Device token registered successfully.');
    } on DioException catch (error) {
      debugPrint('========== Register Device Token ERROR ==========');
      debugPrint('Message: ${error.message}');
      debugPrint('Status Code: ${error.response?.statusCode}');
      debugPrint('Response: ${error.response?.data}');

      if (error.error is AppException) {
        throw error.error as AppException;
      }

      throw AppException.fromDioException(error);
    }
  }

  @override
Future<ShowNotificationResponse> showNotifications() async {
  try {
    final token = authTokenStorage.token;

    debugPrint('========== Show Notifications ==========');
    debugPrint('Access Token Exists: ${token != null && token.isNotEmpty}');
    debugPrint('Endpoint: ${ApiEndpoints.showNotifications}');

    final response = await dio.get(
      ApiEndpoints.showNotifications,
      options: Options(
        headers: token == null || token.isEmpty
            ? null
            : {
                'Authorization': 'Bearer $token',
              },
      ),
    );

    debugPrint('Response Status: ${response.statusCode}');
    debugPrint('Response Body: ${response.data}');

    final payload = _asMap(response.data);

    if (payload == null) {
      throw const AppException(
        message: 'Invalid response format',
      );
    }

    if (payload['success'] != true) {
      throw AppException.fromDioException(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ),
      );
    }

    return ShowNotificationResponse.fromJson(payload);
  } on DioException catch (error) {
    debugPrint('========== Show Notifications ERROR ==========');
    debugPrint('Message: ${error.message}');
    debugPrint('Status Code: ${error.response?.statusCode}');
    debugPrint('Response: ${error.response?.data}');

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