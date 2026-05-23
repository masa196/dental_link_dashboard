import 'package:dartz/dartz.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';

abstract class BaseRepository<Params, Result> {
  Future<Either<AppFailure, Result>> call(Params params);
}
