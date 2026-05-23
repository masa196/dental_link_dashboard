import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/admin/domain/usecases/login/logout_usecase.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/logout/logout_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/logout/logout_state.dart';

@injectable
class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc({required this.logoutUseCase}) : super(LogoutState.initial()) {
    on<LogoutRequested>(_onRequested);
    on<LogoutResetRequested>(_onResetRequested);
  }

  final LogoutUseCase logoutUseCase;

  Future<void> _onRequested(
    LogoutRequested event,
    Emitter<LogoutState> emit,
  ) async {
    emit(LogoutState.loading());

    final result = await logoutUseCase(event.token);

    result.fold(
      (failure) => emit(LogoutState.failure(failure)),
      (response) => emit(LogoutState.success(response)),
    );
  }

  void _onResetRequested(
    LogoutResetRequested event,
    Emitter<LogoutState> emit,
  ) {
    emit(LogoutState.initial());
  }
}
