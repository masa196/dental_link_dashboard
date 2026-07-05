import 'dart:developer';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/datasources/manage_orders/print_qr_remote_data_source.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_orders/print_qr_repository.dart';

@Injectable(as: PrintQrRepository)
class PrintQrRepositoryImpl
    implements PrintQrRepository {
  const PrintQrRepositoryImpl(
    this.remoteDataSource,
  );

  final PrintQrRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, Uint8List>> call(
    int orderId,
  ) async {
    try {
      final bytes = await remoteDataSource.printQr(orderId);

      return Right(bytes);
    } catch (error, stackTrace) {
      log(
        'PrintQrRepositoryImpl',
        error: error,
        stackTrace: stackTrace,
      );

      return Left(AppErrorMapper.map(error));
    }
  }
}