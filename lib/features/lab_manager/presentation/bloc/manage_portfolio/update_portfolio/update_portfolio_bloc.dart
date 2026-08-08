import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_portfolio/update_portfolio_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'update_portfolio_event.dart';
import 'update_portfolio_state.dart';

@injectable
class UpdatePortfolioBloc
    extends Bloc<UpdatePortfolioEvent, UpdatePortfolioState> {
  UpdatePortfolioBloc(
    this._usecase,
  ) : super(const UpdatePortfolioState()) {
    on<UpdatePortfolioRequested>(_onUpdateRequested);
    on<UpdatePortfolioReset>(_onReset);
  }

  final UpdatePortfolioUsecase _usecase;

  Future<void> _onUpdateRequested(
    UpdatePortfolioRequested event,
    Emitter<UpdatePortfolioState> emit,
  ) async {
    emit(
      state.copyWith(
        status: UpdatePortfolioStatus.loading,
      ),
    );

    final result = await _usecase(event.parameters);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: UpdatePortfolioStatus.failure,
            failure: failure,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            status: UpdatePortfolioStatus.success,
            response: response,
          ),
        );
      },
    );
  }

  void _onReset(
    UpdatePortfolioReset event,
    Emitter<UpdatePortfolioState> emit,
  ) {
    emit(const UpdatePortfolioState());
  }
}