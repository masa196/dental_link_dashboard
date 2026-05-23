import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/admin/data/models/location/location_model.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/create_lab_manager/create_lab_manager_entity.dart';
import 'package:dental_link_dashboard/features/admin/domain/repositories/location/location_base_repository.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';



@Injectable(as: BaseUseCase<List<LocationModel>, CreateLabManagerEntity>)
@Named('SearchLocation')
class SearchLocationUseCase extends BaseUseCase<List<LocationModel>, CreateLabManagerEntity> {
  final LocationBaseRepository repository;

  SearchLocationUseCase(this.repository);

  @override
  Future<Either<AppFailure, List<LocationModel>>> call(CreateLabManagerEntity data) async{
    return repository.searchLocation(data);
  }
}