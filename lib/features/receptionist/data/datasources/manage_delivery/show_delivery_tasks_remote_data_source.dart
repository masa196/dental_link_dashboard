import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/delivery_tasks_model/delivery_tasks_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/show_delivery_tasks_entity.dart';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract interface class ShowDeliveryTasksRemoteDataSource {
  Future<DeliveryTasksResponse> getDeliveryTasks(
    ShowDeliveryTasksEntity parameters,
  );
}



@Injectable(as: ShowDeliveryTasksRemoteDataSource)
class ShowDeliveryTasksRemoteDataSourceImpl
    implements ShowDeliveryTasksRemoteDataSource {
  const ShowDeliveryTasksRemoteDataSourceImpl(
    this._dioClient,
    this._tokenStorage,
  );

  final DioClient _dioClient;
  final AuthTokenStorage _tokenStorage;

  @override
  Future<DeliveryTasksResponse> getDeliveryTasks(
    ShowDeliveryTasksEntity parameters,
  ) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.showDeliveryTasks,
     queryParameters: parameters.toQueryParameters(),
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${_tokenStorage.token}',
          },
        ),
      );

      return DeliveryTasksResponse.fromJson(
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