import 'package:dental_link_dashboard/features/receptionist/domain/entities/show_doctors/show_doctor_details_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/usecases/show_doctors/show_doctor_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'show_doctor_details_event.dart';
import 'show_doctor_details_state.dart';

@injectable
class ShowDoctorDetailsBloc
    extends Bloc<ShowDoctorDetailsEvent, ShowDoctorDetailsState> {
  ShowDoctorDetailsBloc(this._usecase) : super(const ShowDoctorDetailsState()) {
    on<ShowDoctorDetailsRequested>(_onRequested);

    on<ShowDoctorPaymentFilterChanged>(_onPaymentFilterChanged);

    on<ShowDoctorDetailsRefresh>(_onRefresh);

    on<ShowDoctorOrdersPageChanged>(_onPageChanged);
  }

  final ShowDoctorDetailsUsecase _usecase;

  Future<void> _onRequested(
    ShowDoctorDetailsRequested event,
    Emitter<ShowDoctorDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoadingDoctor: true,
        isLoadingOrders: true,
        failure: null,
        doctorId: event.doctorId,
        currentPaymentStatus: event.paymentStatus,
      ),
    );

    await _loadDoctor(event, emit, isFirstLoad: true);
  }

  Future<void> _onPaymentFilterChanged(
    ShowDoctorPaymentFilterChanged event,
    Emitter<ShowDoctorDetailsState> emit,
  ) async {
    if (state.doctorId == null) {
      return;
    }

    final request = ShowDoctorDetailsRequested(
      doctorId: state.doctorId!,
      paymentStatus: event.paymentStatus,
      page: 1,
    );

    emit(
      state.copyWith(
        isLoadingOrders: true,
        currentPaymentStatus: event.paymentStatus,
      ),
    );

    await _loadDoctor(request, emit, isFirstLoad: false);
  }

  Future<void> _loadDoctor(
    ShowDoctorDetailsRequested event,
    Emitter<ShowDoctorDetailsState> emit, {
    required bool isFirstLoad,
  }) async {
    final result = await _usecase(
      ShowDoctorDetailsEntity(
        doctorId: event.doctorId,
        paymentStatus: event.paymentStatus,
        page: event.page,
        perPage: event.perPage,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoadingDoctor: false,
            isLoadingOrders: false,
            failure: failure,
          ),
        );
      },
      (response) {
        final data = response.data;

        if (data == null) {
          emit(state.copyWith(isLoadingDoctor: false, isLoadingOrders: false));
          return;
        }

        emit(
          state.copyWith(
            doctorInfo: isFirstLoad ? data : state.doctorInfo,
            orders: data.orders ?? [],
            pagination: data.pagination,
            currentPage: data.pagination?.currentPage ?? 1,
            lastPage: data.pagination?.lastPage ?? 1,
            isLoadingDoctor: false,
            isLoadingOrders: false,
            currentPaymentStatus: event.paymentStatus,
          ),
        );
      },
    );
  }

  Future<void> _onRefresh(
    ShowDoctorDetailsRefresh event,
    Emitter<ShowDoctorDetailsState> emit,
  ) async {
    if (state.doctorId == null) {
      return;
    }

    add(
      ShowDoctorDetailsRequested(
        doctorId: state.doctorId!,
        paymentStatus: state.currentPaymentStatus,
        page: state.currentPage,
      ),
    );
  }

  Future<void> _onPageChanged(
  ShowDoctorOrdersPageChanged event,
  Emitter<ShowDoctorDetailsState> emit,
) async {
  if (state.doctorId == null) {
    return;
  }

  emit(
    state.copyWith(
      isLoadingOrders: true,
    ),
  );

  await _loadDoctor(
    ShowDoctorDetailsRequested(
      doctorId: state.doctorId!,
      paymentStatus: state.currentPaymentStatus,
      page: event.page,
    ),
    emit,
    isFirstLoad: false,
  );
}
}
