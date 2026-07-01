import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/manage_dep/create_departments_use_case.dart';

import 'create_departments_bloc_event.dart';
import 'create_departments_bloc_state.dart';

@injectable
class CreateDepartmentsBloc
    extends
        Bloc<CreateDepartmentsBlocEvent, CreateDepartmentsBlocState> {
  CreateDepartmentsBloc({required this.createDepartmentsUseCase})
    : super(const CreateDepartmentsBlocState()) {
    on<CreateDepartmentsSubmitted>(_onSubmitted);
    on<CreateDepartmentsReset>(_onReset);
  }

  final CreateDepartmentsUseCase createDepartmentsUseCase;

  Future<void> _onSubmitted(
    CreateDepartmentsSubmitted event,
    Emitter<CreateDepartmentsBlocState> emit,
  ) async {
    emit(state.copyWith(status: CreateDepartmentsStatus.loading));

    final result = await createDepartmentsUseCase(event.params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CreateDepartmentsStatus.failure,
            failure: failure,
          ),
        );
      },
      (responseModel) {
        emit(
          state.copyWith(
            status: CreateDepartmentsStatus.success,
            responseModel: responseModel,
            clearFailure: true,
          ),
        );
      },
    );
  }

  Future<void> _onReset(
    CreateDepartmentsReset event,
    Emitter<CreateDepartmentsBlocState> emit,
  ) async {
    emit(const CreateDepartmentsBlocState());
  }
}
