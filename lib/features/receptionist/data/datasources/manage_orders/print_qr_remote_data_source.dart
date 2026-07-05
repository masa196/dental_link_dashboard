import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/core/network/dio_client.dart';

abstract interface class PrintQrRemoteDataSource {
  Future<Uint8List> printQr(int orderId);
}

@Injectable(as: PrintQrRemoteDataSource)
class PrintQrRemoteDataSourceImpl
    implements PrintQrRemoteDataSource {
  PrintQrRemoteDataSourceImpl(
    this.dioClient,
    this.authTokenStorage,
  );

  final DioClient dioClient;
  final AuthTokenStorage authTokenStorage;

  Dio get dio => dioClient.dio;

  @override
  Future<Uint8List> printQr(int orderId) async {
    final token = authTokenStorage.token;

    try {
      final response = await dio.get<List<int>>(
        ApiEndpoints.qrImage(orderId),
        options: Options(
          responseType: ResponseType.bytes,
          headers: token == null || token.isEmpty
              ? null
              : {
                  'Authorization': 'Bearer $token',
                },
        ),
      );

      final bytes = response.data;

      if (bytes == null || bytes.isEmpty) {
        throw const AppException(
          message: 'QR image is empty',
        );
      }

      return Uint8List.fromList(bytes);
    } on DioException {
      rethrow;
    }
  }
}