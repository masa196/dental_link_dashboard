import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'print_qr_event.dart';
import 'print_qr_state.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/usecases/manage_orders/print_qr_usecase.dart';

@injectable
class PrintQrBloc extends Bloc<PrintQrEvent, PrintQrState> {
  PrintQrBloc(this._useCase) : super(const PrintQrState()) {
    on<PrintQrRequested>(_onRequested);
  }

  final PrintQrUseCase _useCase;

  Future<void> _onRequested(
    PrintQrRequested event,
    Emitter<PrintQrState> emit,
  ) async {
    emit(state.copyWith(
      status: PrintQrStatus.loading,
      serialNumber: event.serialNumber,
    ));

    final result = await _useCase(event.orderId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: PrintQrStatus.failure,
          failure: failure,
        ));
      },
      (image) {
        emit(state.copyWith(
          status: PrintQrStatus.success,
          image: image,
        ));
      },
    );
  }
}