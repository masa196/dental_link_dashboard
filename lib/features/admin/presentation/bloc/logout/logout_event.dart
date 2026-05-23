import 'package:equatable/equatable.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}

class LogoutRequested extends LogoutEvent {
  const LogoutRequested(this.token);

  final String token;

  @override
  List<Object?> get props => [token];
}

class LogoutResetRequested extends LogoutEvent {}
