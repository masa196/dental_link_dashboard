import 'package:equatable/equatable.dart';

class OrderStagesEntity extends Equatable {
  const OrderStagesEntity({
    required this.departmentIds,
    required this.departmentTimeAllowedHours,
  });

  final List<int> departmentIds;

  final List<int> departmentTimeAllowedHours;

  Map<String, dynamic> toJson() {
    return {
      'department_ids': departmentIds,
      'department_time_allowed_hours':
          departmentTimeAllowedHours,
    };
  }

  @override
  List<Object?> get props => [
        departmentIds,
        departmentTimeAllowedHours,
      ];
}