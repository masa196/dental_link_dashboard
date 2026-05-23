import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

/// حالات Cubit المستخدم والدور
class UserRoleState extends Equatable {
  final String? userRole; // system_admin, lab_manager, receptionist
  final String? userName;
  final int? userId;

  const UserRoleState({this.userRole, this.userName, this.userId});

  UserRoleState copyWith({String? userRole, String? userName, int? userId}) {
    return UserRoleState(
      userRole: userRole ?? this.userRole,
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [userRole, userName, userId];
}

/// Cubit لإدارة دور المستخدم
class UserRoleCubit extends Cubit<UserRoleState> {
  UserRoleCubit() : super(const UserRoleState());

  /// تعيين دور المستخدم
  void setUserRole({
    required String role,
    required String userName,
    required int userId,
  }) {
    emit(state.copyWith(userRole: role, userName: userName, userId: userId));
  }

  /// مسح دور المستخدم (عند تسجيل الخروج)
  void clearUserRole() {
    emit(const UserRoleState());
  }

  /// التحقق من كون المستخدم نظام إداري
  bool get isSystemAdmin => state.userRole == 'system_admin';

  /// التحقق من كون المستخدم مدير مخبر
  bool get isLabManager => state.userRole == 'lab_manager';

  /// التحقق من كون المستخدم موظف استقبال
  bool get isReceptionist => state.userRole == 'receptionist';
}
