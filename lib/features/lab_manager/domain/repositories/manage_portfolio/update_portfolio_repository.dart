import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/manage_portfolio/update_portfolio_entity.dart';

abstract interface class UpdatePortfolioRepository {
  Future<Either<AppFailure, BaseResponseModel>> call({
    required UpdatePortfolioEntity parameters,
  });
}