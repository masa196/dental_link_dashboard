import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/datasources/manage_portfolio/create_portfolio_remote_data_source.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/manage_portfolio/create_portfolio_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_portfolio/create_portfolio_repository.dart';

@Injectable(as: CreatePortfolioRepository)
class CreatePortfolioRepositoryImpl
    implements CreatePortfolioRepository {
  const CreatePortfolioRepositoryImpl(
    this._remoteDataSource,
  );

  final CreatePortfolioRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call({
    required CreatePortfolioEntity parameters,
  }) async {
    try {
      final response =
          await _remoteDataSource.createPortfolio(
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