import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/manage_portfolio/create_portfolio_entity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';

abstract class CreatePortfolioRemoteDataSource {
  Future<BaseResponseModel> createPortfolio({
    required CreatePortfolioEntity parameters,
  });
}

@Injectable(as: CreatePortfolioRemoteDataSource)
class CreatePortfolioRemoteDataSourceImpl
    implements CreatePortfolioRemoteDataSource {
  CreatePortfolioRemoteDataSourceImpl(this.dioClient, this.authTokenStorage);

  final DioClient dioClient;
  final AuthTokenStorage authTokenStorage;

  Dio get dio => dioClient.dio;

  @override
  Future<BaseResponseModel> createPortfolio({
    required CreatePortfolioEntity parameters,
  }) async {
    try {
      final token = authTokenStorage.token;

      final formData = FormData.fromMap({
        'order_id': parameters.orderId,
        'case_name': parameters.caseName,
        'is_published': parameters.isPublished ? 1 : 0,

        'before_image': MultipartFile.fromBytes(
          parameters.beforeImage,
          filename: parameters.beforeImageName ?? 'before_image.jpg',
        ),

        'after_image': MultipartFile.fromBytes(
          parameters.afterImage,
          filename: parameters.afterImageName ?? 'after_image.jpg',
        ),
      });

      final response = await dio.post(
        ApiEndpoints.createPortfolio(parameters.labId),
        data: formData,
        options: Options(
          headers: {
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      final payload = _asMap(response.data);

      if (payload == null) {
        throw const AppException(message: 'Invalid response format');
      }

      final model = BaseResponseModel.fromJson(payload);

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
      return raw.map((key, value) => MapEntry(key.toString(), value));
    }
    return null;
  }
}
