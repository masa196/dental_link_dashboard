import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/manage_delivery/create_delivery_assignment_entity.dart';

abstract interface class CreateDeliveryAssignmentRemoteDataSource {
  Future<BaseResponseModel> createDeliveryAssignment(
    CreateDeliveryAssignmentEntity parameters,
  );
}

@Injectable(
  as: CreateDeliveryAssignmentRemoteDataSource,
)
class CreateDeliveryAssignmentRemoteDataSourceImpl
    implements CreateDeliveryAssignmentRemoteDataSource {
  const CreateDeliveryAssignmentRemoteDataSourceImpl(
    this._dioClient,
    this._tokenStorage,
  );

  final DioClient _dioClient;
  final AuthTokenStorage _tokenStorage;

  @override
  Future<BaseResponseModel> createDeliveryAssignment(
    CreateDeliveryAssignmentEntity parameters,
  ) async {
    try {
      final response = await _dioClient.dio.post(
        '${ApiEndpoints.orders}/${parameters.orderId}/delivery-assignments',

        data: {
          'user_id': parameters.userId,
        },

        options: Options(
          headers: {
            'Authorization': 'Bearer ${_tokenStorage.token}',
          },
        ),
      );

      return BaseResponseModel.fromJson(
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