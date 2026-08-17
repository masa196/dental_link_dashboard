import 'package:dental_link_dashboard/features/admin/domain/usecases/lab_statistics/get_lab_statistics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/lab_statistics/lab_statistics_bloc_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/lab_statistics/lab_statistics_bloc_state.dart';

@injectable
class LabStatisticsBloc
    extends Bloc<LabStatisticsEvent, LabStatisticsState> {
  LabStatisticsBloc(this.getLabStatisticsUseCase)
      : super(const LabStatisticsState()) {
    on<LabStatisticsFetchRequested>(_onFetchRequested);
  }

  final GetLabStatisticsUseCase getLabStatisticsUseCase;

  Future<void> _onFetchRequested(
    LabStatisticsFetchRequested event,
    Emitter<LabStatisticsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: LabStatisticsStatus.loading,
        clearFailure: true,
      ),
    );

    final result = await getLabStatisticsUseCase(NoParameters());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: LabStatisticsStatus.failure,
            failure: failure,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            status: LabStatisticsStatus.success,
            response: response,
            clearFailure: true,
          ),
        );
      },
    );
  }
}