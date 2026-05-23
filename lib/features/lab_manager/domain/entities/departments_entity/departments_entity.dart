import 'package:equatable/equatable.dart';

class DepartmentsEntity extends Equatable {
  const DepartmentsEntity({required this.departments});

  final List<DepartmentInputEntity> departments;

  Map<String, dynamic> toJson() {
    return {
      'departments': departments
          .map((department) => department.toJson())
          .toList(),
    };
  }

  @override
  List<Object?> get props => [departments];
}

class DepartmentInputEntity extends Equatable {
  const DepartmentInputEntity({required this.name});

  final String name;

  Map<String, dynamic> toJson() {
    return {'name': name};
  }

  @override
  List<Object?> get props => [name];
}

class DepartmentNameEntity extends Equatable {
  const DepartmentNameEntity({required this.name});

  final String name;

  Map<String, dynamic> toJson() {
    return {'name': name};
  }

  @override
  List<Object?> get props => [name];
}
