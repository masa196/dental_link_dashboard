import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';


import '../../models/assign_package_to_lab/assign_package_to_lab_model.dart';

abstract interface class AssignPackageToLabRemoteDataSource {
  Future<BaseResponseModel> assignPackageToLab(
    int labId,
    AssignPackageToLabModel model,
  );
}

@Injectable(as: AssignPackageToLabRemoteDataSource)
class AssignPackageToLabRemoteDataSourceImpl
    implements AssignPackageToLabRemoteDataSource {
  AssignPackageToLabRemoteDataSourceImpl(
    this.dioClient,
    this.authTokenStorage,
  );

  final DioClient dioClient;
  final AuthTokenStorage authTokenStorage;

  Dio get dio => dioClient.dio;

  @override
  Future<BaseResponseModel> assignPackageToLab(
    int labId,
    AssignPackageToLabModel model,
  ) async {
    final token = authTokenStorage.token;

    final response = await dio.post(
      ApiEndpoints.assignPackageToLab(labId),
      data: model.toJson(),
      options: Options(
        headers: token == null || token.isEmpty
            ? null
            : {
                'Authorization': 'Bearer $token',
              },
      ),
    );

    return BaseResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}