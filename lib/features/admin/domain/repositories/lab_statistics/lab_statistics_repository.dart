import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/lab_statistics/lab_statistics_model.dart';


abstract interface class LabStatisticsRepository {
  Future<Either<AppFailure, LabStatisticsResponse>> call();
}
