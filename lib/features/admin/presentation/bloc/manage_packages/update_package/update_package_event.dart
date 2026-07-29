import 'package:dental_link_dashboard/features/admin/domain/entities/packages_entity/update_package_entity.dart';
import 'package:equatable/equatable.dart';

sealed class UpdatePackageEvent extends Equatable {
  const UpdatePackageEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePackageRequested extends UpdatePackageEvent {
  const UpdatePackageRequested({
    required this.parameters,
  });

  final UpdatePackageEntity parameters;

  @override
  List<Object?> get props => [
        parameters,
      ];
}