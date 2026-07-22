import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_orders/update_order_status_entity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';

import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';

abstract class UpdateOrderStatusRemoteDataSource {
  Future<BaseResponseModel> updateStatus(UpdateOrderStatusEntity parameters);
  Future<BaseResponseModel> lockOrder(int orderId);
  Future<BaseResponseModel> unLockOrder(int orderId);

}

@Injectable(as: UpdateOrderStatusRemoteDataSource)
class UpdateOrderStatusRemoteDataSourceImpl
    implements UpdateOrderStatusRemoteDataSource {
  UpdateOrderStatusRemoteDataSourceImpl(this.dioClient, this.authTokenStorage);

  final DioClient dioClient;
  final AuthTokenStorage authTokenStorage;

  Dio get dio => dioClient.dio;

  @override
  Future<BaseResponseModel> updateStatus(
    UpdateOrderStatusEntity parameters,
  ) async {
    final token = authTokenStorage.token;

    try {
      final response = await dio.post(
        ApiEndpoints.updateOrderStatus(parameters.orderId),
        data: {
          'status': parameters.status,
          if (parameters.notes != null && parameters.notes!.trim().isNotEmpty)
            'notes': parameters.notes,
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

      return BaseResponseModel.fromJson(payload);
    } on DioException {
      rethrow;
    }
  }

    @override
  Future<BaseResponseModel> lockOrder(
    int orderId,
  ) async {
    final token = authTokenStorage.token;

    try {
      final response = await dio.post(
        ApiEndpoints.lockOrder(orderId),
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

      return BaseResponseModel.fromJson(payload);
    } on DioException {
      rethrow;
    }
  }


   @override
  Future<BaseResponseModel> unLockOrder(
    int orderId,
  ) async {
    final token = authTokenStorage.token;

    try {
      final response = await dio.post(
        ApiEndpoints.unLockOrder(orderId),
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

      return BaseResponseModel.fromJson(payload);
    } on DioException {
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
