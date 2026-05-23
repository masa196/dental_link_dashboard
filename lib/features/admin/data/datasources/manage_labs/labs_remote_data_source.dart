import 'package:dental_link_dashboard/features/admin/data/models/labs/labs_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/labs_query_params.dart';

abstract class LabsRemoteDataSource {
  Future<PaginatedLabsResponseModel> getLabs(LabsQueryParams params);
}

@Injectable(as: LabsRemoteDataSource)
class LabsRemoteDataSourceImpl implements LabsRemoteDataSource {
  LabsRemoteDataSourceImpl(this.dioClient, this.authTokenStorage);

  final DioClient dioClient;
  final AuthTokenStorage authTokenStorage;

  Dio get dio => dioClient.dio;

  @override
  Future<PaginatedLabsResponseModel> getLabs(LabsQueryParams params) async {
    try {
      final token = authTokenStorage.token;
      final response = await dio.get(
        params.tab.apiPath,
        queryParameters: {'per_page': params.perPage, 'page': params.page},
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

      final model = PaginatedLabsResponseModel.fromJson(payload);
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
