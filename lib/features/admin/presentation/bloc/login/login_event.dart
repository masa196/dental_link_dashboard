import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/features/admin/domain/entities/login_entity.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted(this.credentials);

  final LoginEntity credentials;

  @override
  List<Object?> get props => [credentials];
}

class LoginResetRequested extends LoginEvent {
  const LoginResetRequested();
}
