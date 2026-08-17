import 'package:equatable/equatable.dart';

class AssignPackageToLabEntity extends Equatable {
  const AssignPackageToLabEntity({
    required this.labId,
    required this.packageId,
  });

  final int labId;
  final int packageId;

  @override
  List<Object> get props => [
        labId,
        packageId,
      ];
}