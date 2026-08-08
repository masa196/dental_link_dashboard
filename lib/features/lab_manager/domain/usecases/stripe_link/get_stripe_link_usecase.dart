import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/stripe_link/stripe_link_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/repositories/stripe_link/stripe_link_repository.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';


@injectable
class GetStripeLinkUsecase {
  GetStripeLinkUsecase(this.repository);

  final StripeLinkRepository repository;

  Future<Either<AppFailure, StripeLinkResponse>> call() {
    return repository.call();
  }
}