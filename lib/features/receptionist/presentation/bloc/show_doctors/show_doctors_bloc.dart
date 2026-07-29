import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/receptionist/domain/entities/show_doctors/show_doctors_entity.dart';
import 'package:dental_link_dashboard/features/receptionist/domain/usecases/show_doctors/show_doctors_usecase.dart';

import 'show_doctors_event.dart';
import 'show_doctors_state.dart';

@injectable
class ShowDoctorsBloc extends Bloc<ShowDoctorsEvent, ShowDoctorsState> {
  ShowDoctorsBloc(this._showDoctorsUsecase)
      : super(const ShowDoctorsState()) {
    on<ShowDoctorsRequested>(_onRequested);
    on<ShowDoctorsRefresh>(_onRefresh);
  }

  final ShowDoctorsUsecase _showDoctorsUsecase;

  Future<void> _onRequested(
    ShowDoctorsRequested event,
    Emitter<ShowDoctorsState> emit,
  ) async {
    final search = event.search ?? state.currentSearch;

    emit(
      state.copyWith(
        isLoading: true,
        failure: null,
        currentSearch: search,
      ),
    );

    final result = await _showDoctorsUsecase(
      ShowDoctorsEntity(
        page: event.page,
        perPage: event.perPage,
        search: search,
      ),
    );

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
        final doctors = response.data?.doctors ?? [];

        // إذا أصبحت الصفحة الحالية فارغة بعد حذف أو تغيير بيانات
        if (doctors.isEmpty && event.page > 1) {
          add(
            ShowDoctorsRequested(
              page: event.page - 1,
              perPage: event.perPage,
              search: search,
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            isLoading: false,
            doctors: doctors,
            totals: response.data?.totals,
            currentPage:
                response.data?.pagination?.currentPage ?? event.page,
            lastPage:
                response.data?.pagination?.lastPage ?? 1,
            currentSearch: search,
          ),
        );
      },
    );
  }

  Future<void> _onRefresh(
    ShowDoctorsRefresh event,
    Emitter<ShowDoctorsState> emit,
  ) async {
    add(
      ShowDoctorsRequested(
        page: state.currentPage,
        search: state.currentSearch,
      ),
    );
  }
}