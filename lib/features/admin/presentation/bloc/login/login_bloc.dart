import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/admin/domain/usecases/login/login_usecase.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/login/login_state.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/login/login_event.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.loginUseCase}) : super(LoginState.initial()) {
    on<LoginSubmitted>(_onSubmitted);
    on<LoginResetRequested>(_onResetRequested);
  }

  final LoginUseCase loginUseCase;

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.loading());

    final result = await loginUseCase(event.credentials);

    result.fold(
      (failure) => emit(LoginState.failure(failure)),
      (response) => emit(LoginState.success(response)),
    );
  }

  void _onResetRequested(LoginResetRequested event, Emitter<LoginState> emit) {
    emit(LoginState.initial());
  }
}
