import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/all_doctors/all_doctors_model.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/entities/show_doctors/show_doctors_entity.dart';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract interface class ShowDoctorsRemoteDataSource {
  Future<AllDoctorsResponse> getDoctors(
    ShowDoctorsEntity parameters,
  );
}



@Injectable(as: ShowDoctorsRemoteDataSource)
class ShowDoctorsRemoteDataSourceImpl
    implements ShowDoctorsRemoteDataSource {
  const ShowDoctorsRemoteDataSourceImpl(
    this._dioClient,
    this._tokenStorage,
  );

  final DioClient _dioClient;
  final AuthTokenStorage _tokenStorage;

  @override
  Future<AllDoctorsResponse> getDoctors(
    ShowDoctorsEntity parameters,
  ) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.showDoctors,
        queryParameters: parameters.toQueryParameters(),
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${_tokenStorage.token}',
          },
        ),
      );

      return AllDoctorsResponse.fromJson(
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