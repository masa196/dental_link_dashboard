import 'package:dental_link_dashboard/features/admin/domain/usecases/package_hisrtory_sys_admin.dart/show_package_hisrtory_sys_admin_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package_history_sys_admin_event.dart';
import 'package_history_sys_admin_state.dart';

@injectable
class PackageHistorySysAdminBloc
    extends Bloc<PackageHistorySysAdminEvent, PackageHistorySysAdminState> {
  PackageHistorySysAdminBloc(
    this.showPackageHistorySysAdminUsecase,
  ) : super(const PackageHistorySysAdminState()) {
    on<GetPackageHistorySysAdminRequested>(
      _getPackageHistory,
    );
  }

  final ShowPackageHistorySysAdminUsecase
      showPackageHistorySysAdminUsecase;

  Future<void> _getPackageHistory(
    GetPackageHistorySysAdminRequested event,
    Emitter<PackageHistorySysAdminState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearFailure: true,
      ),
    );

    final result = await showPackageHistorySysAdminUsecase(
      event.parameters,
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
        emit(
          state.copyWith(
            isLoading: false,
            success: response.success ?? true,
            message: response.message,
            response: response,
          ),
        );
      },
    );
  }
}