import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/system_logs/system_logs_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/system_logs/system_logs_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/system_logs/system_logs_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';


@injectable
class GetSystemLogsUseCase
    extends BaseUseCase<SystemLogsResponse, SystemLogsEntity> {
  GetSystemLogsUseCase(this.repository);

  final SystemLogsRepository repository;

  @override
  Future<Either<AppFailure, SystemLogsResponse>> call(
    SystemLogsEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
