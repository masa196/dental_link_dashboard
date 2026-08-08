
import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/stripe_link/stripe_link_model.dart';

abstract interface class StripeLinkRepository {
  Future<Either<AppFailure, StripeLinkResponse>> call();
}