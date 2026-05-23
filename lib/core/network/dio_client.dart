import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api/api_endpoints.dart';
import '../error/app_error.dart';

@singleton
class DioClient {
  DioClient();

  static final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            headers: const {'Accept': 'application/json'},
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onError: (e, handler) {
              // If the error already carries an AppException, don't remap it
              if (e.error is AppException) {
                handler.reject(e);
                return;
              }

              final mappedException = AppException.fromDioException(e);

              handler.reject(
                DioException(
                  requestOptions: e.requestOptions,
                  response: e.response,
                  type: e.type,
                  error: mappedException,
                ),
              );
            },
          ),
        );

  Dio get dio => _dio;
}
