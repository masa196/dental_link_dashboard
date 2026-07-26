

import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_delivery_time/order_delivery_time_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/order_delivery_time_entity/order_delivery_time_entity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class OrderDelivreyTimeRemoteDataSource {
  Future<OrderDeliveryTimeResponse> getDeliverySettings();

  Future<OrderDeliveryTimeResponse> updateDeliverySettings({
    required OrderDeliveryTimeEntity parameters,
  });
}


@Injectable(as: OrderDelivreyTimeRemoteDataSource)
class OrderDelivreyTimeRemoteDataSourceImpl
    implements OrderDelivreyTimeRemoteDataSource {
  OrderDelivreyTimeRemoteDataSourceImpl(
    this.dioClient,
    this.authTokenStorage,
  );

  final DioClient dioClient;
  final AuthTokenStorage authTokenStorage;

  Dio get dio => dioClient.dio;

  @override
  Future<OrderDeliveryTimeResponse> getDeliverySettings() async {
    try {
      final token = authTokenStorage.token;

      final response = await dio.get(
        ApiEndpoints.deliverySettings,
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

      final model = OrderDeliveryTimeResponse.fromJson(payload);

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

  @override
  Future<OrderDeliveryTimeResponse> updateDeliverySettings({
    required OrderDeliveryTimeEntity parameters,
  }) async {
    try {
      final token = authTokenStorage.token;

      final response = await dio.put(
        ApiEndpoints.deliverySettings,
        data: parameters.toJson(),
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

      final model = OrderDeliveryTimeResponse.fromJson(payload);

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