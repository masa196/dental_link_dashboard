import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_portfolio/update_portfolio_remote_datasource.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/entities/manage_portfolio/update_portfolio_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_portfolio/update_portfolio_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UpdatePortfolioRepository)
class UpdatePortfolioRepositoryImpl
    implements UpdatePortfolioRepository {
  const UpdatePortfolioRepositoryImpl(
    this._remoteDataSource,
  );

  final UpdatePortfolioRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call({
    required UpdatePortfolioEntity parameters,
  }) async {
    try {
      final response = await _remoteDataSource.updatePortfolio(
        parameters: parameters,
      );

      return Right(response);
    } catch (e) {
      return Left(
        AppErrorMapper.map(e),
      );
    }
  }
}