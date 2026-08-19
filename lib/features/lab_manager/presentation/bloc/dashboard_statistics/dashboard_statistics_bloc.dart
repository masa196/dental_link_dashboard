import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/dashboard_statistics/get_dashboard_statistics_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';

import 'dashboard_statistics_event.dart';
import 'dashboard_statistics_state.dart';

@injectable
class DashboardStatisticsBloc
    extends Bloc<DashboardStatisticsEvent, DashboardStatisticsState> {
  DashboardStatisticsBloc(
    this._getDashboardStatisticsUseCase,
  ) : super(const DashboardStatisticsInitial()) {
    on<GetDashboardStatisticsEvent>(
      _onGetDashboardStatistics,
    );
  }

  final GetDashboardStatisticsUseCase _getDashboardStatisticsUseCase;

  Future<void> _onGetDashboardStatistics(
    GetDashboardStatisticsEvent event,
    Emitter<DashboardStatisticsState> emit,
  ) async {
    emit(const DashboardStatisticsLoading());

    final result = await _getDashboardStatisticsUseCase(
      const NoParameters(),
    );

    result.fold(
      (failure) {
        emit(
          DashboardStatisticsFailure(
            failure: failure,
          ),
        );
      },
      (statistics) {
        emit(
          DashboardStatisticsSuccess(
            statistics: statistics,
          ),
        );
      },
    );
  }
}