import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_portfolio/create_portfolio_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'create_portfolio_event.dart';
import 'create_portfolio_state.dart';



@injectable
class CreatePortfolioBloc
    extends Bloc<CreatePortfolioEvent, CreatePortfolioState> {
  CreatePortfolioBloc(
    this._usecase,
  ) : super(const CreatePortfolioState()) {
    on<CreatePortfolioRequested>(_onCreateRequested);
    on<CreatePortfolioReset>(_onReset);
  }

  final CreatePortfolioUsecase _usecase;

  Future<void> _onCreateRequested(
    CreatePortfolioRequested event,
    Emitter<CreatePortfolioState> emit,
  ) async {
    emit(
      state.copyWith(
        status: CreatePortfolioStatus.loading,
      ),
    );

    final result = await _usecase(event.parameters);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CreatePortfolioStatus.failure,
            failure: failure,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            status: CreatePortfolioStatus.success,
            response: response,
          ),
        );
      },
    );
  }

  void _onReset(
    CreatePortfolioReset event,
    Emitter<CreatePortfolioState> emit,
  ) {
    emit(const CreatePortfolioState());
  }
}