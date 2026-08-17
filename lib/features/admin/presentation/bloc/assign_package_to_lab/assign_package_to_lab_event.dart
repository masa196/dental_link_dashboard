import 'package:dental_link_dashboard/features/admin/domain/entities/assign_package_to_lab/assign_package_to_lab_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AssignPackageToLabEvent extends Equatable {
  const AssignPackageToLabEvent();

  @override
  List<Object?> get props => [];
}

class AssignPackageToLabRequested extends AssignPackageToLabEvent {
  const AssignPackageToLabRequested({
    required this.parameters,
  });

  final AssignPackageToLabEntity parameters;

  @override
  List<Object?> get props => [
        parameters,
      ];
}