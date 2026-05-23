import 'package:dartz/dartz.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/labs/labs_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/labs_query_params.dart';


abstract interface  class LabsRepository {
  Future<Either<AppFailure, PaginatedLabsResponseModel>> getLabs(
    LabsQueryParams params,
  );
}
