import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/repositories/manage_orders/print_qr_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';



@injectable
class PrintQrUseCase {
  const PrintQrUseCase(this.repository);

  final PrintQrRepository repository;

  Future<Either<AppFailure, Uint8List>> call(int orderId) {
    return repository.call(orderId);
  }
}
