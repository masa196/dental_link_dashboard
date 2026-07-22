import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/show_order_details/show_order_details_usecase.dart';

import 'show_order_details_event.dart';
import 'show_order_details_state.dart';

@injectable
class ShowOrderDetailsBloc
    extends Bloc<ShowOrderDetailsEvent, ShowOrderDetailsState> {
  ShowOrderDetailsBloc(
    this._showOrderDetailsUseCase,
  ) : super(const ShowOrderDetailsState()) {
    on<ShowOrderDetailsRequested>(
      _onShowOrderDetailsRequested,
    );
  }

  final ShowOrderDetailsUseCase _showOrderDetailsUseCase;

  Future<void> _onShowOrderDetailsRequested(
    ShowOrderDetailsRequested event,
    Emitter<ShowOrderDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ShowOrderDetailsStatus.loading,
      ),
    );

    final result = await _showOrderDetailsUseCase(
      event.orderId,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ShowOrderDetailsStatus.failure,
            failure: failure,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            status: ShowOrderDetailsStatus.success,
            response: response,
          ),
        );
      },
    );
  }
}