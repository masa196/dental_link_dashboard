import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/manage_portfolio/create_portfolio_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/manage_portfolio/create_portfolio_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';



@injectable
class CreatePortfolioUsecase
    extends BaseUseCase<BaseResponseModel, CreatePortfolioEntity> {
  CreatePortfolioUsecase(this.repository);

  final CreatePortfolioRepository repository;

  @override
  Future<Either<AppFailure, BaseResponseModel>> call(
    CreatePortfolioEntity parameters,
  ) {
    return repository.call(parameters: parameters);
  }
}
