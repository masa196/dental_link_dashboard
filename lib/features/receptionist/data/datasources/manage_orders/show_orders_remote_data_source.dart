import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/orders_model/orders_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_orders/show_orders_entity.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract interface class ShowOrdersRemoteDataSource {
  Future<AllOrdersResponse> getOrders(ShowOrdersEntity parameters);
}

@Injectable(as: ShowOrdersRemoteDataSource)
class ShowOrdersRemoteDataSourceImpl implements ShowOrdersRemoteDataSource {
  const ShowOrdersRemoteDataSourceImpl(this._dioClient, this._tokenStorage);

  final DioClient _dioClient;
  final AuthTokenStorage _tokenStorage;

  @override
  Future<AllOrdersResponse> getOrders(ShowOrdersEntity parameters) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.orders,
      queryParameters: parameters.toQueryParameters(),
        options: Options(
          headers: {'Authorization': 'Bearer ${_tokenStorage.token}'},
        ),
      );

      return AllOrdersResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
