import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/admin/domain/usecases/base_use_case.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_dep/get_departments_with_employee_usecase.dart';

import 'departments_with_employee_event.dart';
import 'departments_with_employee_state.dart';

@injectable
class DepartmentsWithEmployeeBloc
    extends Bloc<DepartmentsWithEmployeeEvent, DepartmentsWithEmployeeState> {
  DepartmentsWithEmployeeBloc({required this.getDepartmentsWithEmployeeUseCase})
      : super(const DepartmentsWithEmployeeState()) {
    on<DepartmentsWithEmployeeFetchRequested>(_onFetchRequested);
    
    // 🔴 تم حذف سطر الـ add من هنا تماماً لمنع التحديث عند الـ Rebuild العشوائي
  }

  final GetDepartmentsWithEmployeeUseCase getDepartmentsWithEmployeeUseCase;

  Future<void> _onFetchRequested(
    DepartmentsWithEmployeeFetchRequested event,
    Emitter<DepartmentsWithEmployeeState> emit,
  ) async {
    // 🛡️ حارس يمنع تكرار الطلب إذا كان الـ Bloc يجلب البيانات حالياً 
    if (state.status == DepartmentsWithEmployeeStatus.loading) return;

    emit(
      state.copyWith(
        status: DepartmentsWithEmployeeStatus.loading,
        clearFailure: true,
      ),
    );

    final result = await getDepartmentsWithEmployeeUseCase(
      const NoParameters(),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: DepartmentsWithEmployeeStatus.failure,
            failure: failure,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            status: DepartmentsWithEmployeeStatus.success,
            response: response,
            clearFailure: true,
          ),
        );
      },
    );
  }
}
