import 'package:dartz/dartz.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/base_response_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/edit_lab_manager/edit_lab_manager_entity.dart';

abstract interface class EditLabManagerRepository {
  Future<Either<AppFailure, BaseResponseModel>> call(
    EditLabManagerEntity params,
  );
}
