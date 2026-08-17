import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/system_logs/get_system_logs_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/system_logs/system_logs_entity.dart';

import 'system_logs_event.dart';
import 'system_logs_state.dart';

@injectable
class SystemLogsBloc extends Bloc<SystemLogsEvent, SystemLogsState> {
  SystemLogsBloc(this.getSystemLogsUseCase)
      : super(const SystemLogsState()) {
    on<GetSystemLogsEvent>(_onGetSystemLogs);
    on<ChangeSystemLogsPageEvent>(_onChangePage);
  }

  final GetSystemLogsUseCase getSystemLogsUseCase;

  Future<void> _onGetSystemLogs(
    GetSystemLogsEvent event,
    Emitter<SystemLogsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SystemLogsStatus.loading,
        clearMessage: true,
        clearError: true,
      ),
    );

    final result = await getSystemLogsUseCase(event.parameters);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: SystemLogsStatus.failure,
            error: failure,
            clearMessage: true,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            status: SystemLogsStatus.success,
            data: response.data ?? const [],
            message: response.message,
            currentPage: event.parameters.page,
            perPage: event.parameters.perPage,
            clearError: true,
          ),
        );
      },
    );
  }

  void _onChangePage(
    ChangeSystemLogsPageEvent event,
    Emitter<SystemLogsState> emit,
  ) {
    add(
      GetSystemLogsEvent(
        parameters: SystemLogsEntity(
          page: event.page,
          perPage: state.perPage,
        ),
      ),
    );
  }
}