import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/stripe_link/stripe_link_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/stripe_link/stripe_link_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/stripe_link/stripe_link_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';


@Injectable(as: StripeLinkRepository)
class StripeLinkRepositoryImpl implements StripeLinkRepository {
  const StripeLinkRepositoryImpl(
    this._remoteDataSource,
  );

  final StripeLinkRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, StripeLinkResponse>> call() async {
    try {
      final response =
          await _remoteDataSource.getStripeLink();

      return Right(response);
    } catch (e) {
      return Left(
        AppErrorMapper.map(e),
      );
    }
  }
}