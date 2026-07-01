import 'package:equatable/equatable.dart';

class CreateRoleEntity extends Equatable {
  final String name;
  final List<int> permissions;

  const CreateRoleEntity({
    required this.name,
    required this.permissions,
  });

  @override
  List<Object?> get props => [name, permissions];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "permissions": permissions,
    };
  }
}