import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/labs/labs_model.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/labs_query_params.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/labs_repository.dart';

@injectable
class GetLabsUseCase {
  const GetLabsUseCase(this.repository);

  final LabsRepository repository;

  Future<Either<AppFailure,PaginatedLabsResponseModel>> call(LabsQueryParams params) {
    return repository.getLabs(params);
  }
}
