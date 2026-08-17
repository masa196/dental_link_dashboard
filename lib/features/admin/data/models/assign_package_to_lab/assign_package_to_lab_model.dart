import 'package:dental_link_dashboard/features/admin/domain/entities/assign_package_to_lab/assign_package_to_lab_entity.dart';

class AssignPackageToLabModel {
  const AssignPackageToLabModel({
    required this.packageId,
  });

  final int packageId;

  factory AssignPackageToLabModel.fromEntity(
    AssignPackageToLabEntity entity,
  ) {
    return AssignPackageToLabModel(
      packageId: entity.packageId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'package_id': packageId,
    };
  }
}