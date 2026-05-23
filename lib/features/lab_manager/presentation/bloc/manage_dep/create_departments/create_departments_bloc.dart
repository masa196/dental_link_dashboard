import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/usecases/create_departments_bulk/create_departments_bulk_use_case.dart';

import 'create_departments_bloc_event.dart';
import 'create_departments_bloc_state.dart';

@injectable
class CreateDepartmentsBulkBloc
    extends
        Bloc<CreateDepartmentsBlocEvent, CreateDepartmentsBulkBlocState> {
  CreateDepartmentsBulkBloc({required this.createDepartmentsBulkUseCase})
    : super(const CreateDepartmentsBulkBlocState()) {
    on<CreateDepartmentsBulkSubmitted>(_onSubmitted);
    on<CreateDepartmentsBulkReset>(_onReset);
  }

  final CreateDepartmentsBulkUseCase createDepartmentsBulkUseCase;

  Future<void> _onSubmitted(
    CreateDepartmentsBulkSubmitted event,
    Emitter<CreateDepartmentsBulkBlocState> emit,
  ) async {
    emit(state.copyWith(status: CreateDepartmentsBulkStatus.loading));

    final result = await createDepartmentsBulkUseCase(event.params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CreateDepartmentsBulkStatus.failure,
            failure: failure,
          ),
        );
      },
      (responseModel) {
        emit(
          state.copyWith(
            status: CreateDepartmentsBulkStatus.success,
            responseModel: responseModel,
            clearFailure: true,
          ),
        );
      },
    );
  }

  Future<void> _onReset(
    CreateDepartmentsBulkReset event,
    Emitter<CreateDepartmentsBulkBlocState> emit,
  ) async {
    emit(const CreateDepartmentsBulkBlocState());
  }
}
