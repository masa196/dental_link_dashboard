import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';


abstract interface class PrintQrRepository  {
  Future<Either<AppFailure, Uint8List>> call(int orderId);
}
