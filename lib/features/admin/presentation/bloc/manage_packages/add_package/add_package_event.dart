import 'package:dental_link_dashboard/features/admin/domain/entities/packages_entity/add_packages_entity.dart';
import 'package:equatable/equatable.dart';

sealed class AddPackageEvent extends Equatable {
  const AddPackageEvent();

  @override
  List<Object?> get props => [];
}


class AddPackageRequested extends AddPackageEvent {
  const AddPackageRequested({
    required this.parameters,
  });

  final AddPackageEntity parameters;

  @override
  List<Object?> get props => [
    parameters,
  ];
}