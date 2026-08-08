import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/stripe_link/get_stripe_link_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'stripe_link_event.dart';
import 'stripe_link_state.dart';

@injectable
class StripeLinkBloc extends Bloc<StripeLinkEvent, StripeLinkState> {
  StripeLinkBloc(this._getStripeLinkUsecase)
      : super(const StripeLinkState()) {
    on<StripeLinkRequested>(_onRequested);
  }

  final GetStripeLinkUsecase _getStripeLinkUsecase;

  Future<void> _onRequested(
    StripeLinkRequested event,
    Emitter<StripeLinkState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearFailure: true,
      ),
    );

    final result = await _getStripeLinkUsecase();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            failure: failure,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            isLoading: false,
            response: response,
            clearFailure: true,
          ),
        );
      },
    );
  }
}