import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/entities/employee_pagination_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/show_employee/get_show_employee_usecase.dart';

import 'employee_page_event.dart';
import 'employee_page_state.dart';

@injectable
class EmployeePageBloc extends Bloc<EmployeePageEvent, EmployeePageState> {
  EmployeePageBloc({
    required this.getShowEmployeeUseCase,
    @factoryParam required int departmentId,
    @factoryParam required String departmentName,
  }) : super(
         EmployeePageState(
           departmentId: departmentId,
           departmentName: departmentName,
         ),
       ) {
    on<EmployeePageFetchRequested>(_onFetchRequested);
    add(
      EmployeePageFetchRequested(
        departmentId: departmentId,
        page: 1,
        employeesPerPage: 15,
      ),
    );
  }

  final GetShowEmployeeUseCase getShowEmployeeUseCase;

  Future<void> _onFetchRequested(
    EmployeePageFetchRequested event,
    Emitter<EmployeePageState> emit,
  ) async {
    emit(
      state.copyWith(
        status: EmployeePageStatus.loading,
        clearFailure: true,
        currentPage: event.page,
        employeesPerPage: event.employeesPerPage,
      ),
    );

    final result = await getShowEmployeeUseCase(
      EmployeePaginationEntity(
        departmentId: event.departmentId,
        employeesPerPage: event.employeesPerPage,
        employeesPage: event.page,
        currentPage: event.page,
        lastPage: null,
        perPage: event.employeesPerPage,
        total: null,
        from: null,
        to: null,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(status: EmployeePageStatus.failure, failure: failure),
        );
      },
      (response) {
        emit(
          state.copyWith(
            status: EmployeePageStatus.success,
            response: response,
            clearFailure: true,
            departmentName: response.data?.department?.name,
            currentPage:
                response.data?.department?.employees?.meta?.currentPage ??
                event.page,
            employeesPerPage:
                response.data?.department?.employees?.meta?.perPage ??
                event.employeesPerPage,
          ),
        );
      },
    );
  }
}
