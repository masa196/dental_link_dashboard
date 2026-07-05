import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/delivery_employees_model/delivery_employees_model.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/show_delivery_employees_entity.dart';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract interface class ShowDeliveryEmployeesRemoteDataSource {
  Future<DeliveryEmployeesResponse> getDeliveryEmployees(
    ShowDeliveryEmployeesEntity parameters,
  );
}



@Injectable(as: ShowDeliveryEmployeesRemoteDataSource)
class ShowDeliveryEmployeesRemoteDataSourceImpl
    implements ShowDeliveryEmployeesRemoteDataSource {
  const ShowDeliveryEmployeesRemoteDataSourceImpl(
    this._dioClient,
    this._tokenStorage,
  );

  final DioClient _dioClient;
  final AuthTokenStorage _tokenStorage;

  @override
  Future<DeliveryEmployeesResponse> getDeliveryEmployees(
    ShowDeliveryEmployeesEntity parameters,
  ) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.showDeliveryEmployees,
       queryParameters: {
  'per_page': parameters.perPage,
  'search': parameters.search,
},
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${_tokenStorage.token}',
          },
        ),
      );

      return DeliveryEmployeesResponse.fromJson(
        response.data,
      );
    } on DioException catch (e) {
      throw AppException.fromDioException(e);
    } catch (e) {
      throw AppException(
        message: e.toString(),
      );
    }
  }
}