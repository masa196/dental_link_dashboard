
import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/system_logs/system_logs_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/system_logs/system_logs_entity.dart';


abstract interface class SystemLogsRepository {
  Future<Either<AppFailure, SystemLogsResponse>> call({
    required SystemLogsEntity parameters,
  });
}


