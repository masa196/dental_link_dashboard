import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:dental_link_dashboard/features/admin/domain/entities/labs_query_params.dart';

import 'manage_labs_cubit_state.dart';

@injectable
class ManageLabsCubit extends Cubit<ManageLabsUiState> {
  ManageLabsCubit() : super(const ManageLabsUiState());

  static const int pageSize = 15;

  void selectTab(LabsTabType tab) {
    if (state.selectedTab == tab) {
      return;
    }

    emit(state.copyWith(selectedTab: tab));
  }

  void goToPage(int page) {
    final safePage = page < 1 ? 1 : page;

    if (state.selectedTab == LabsTabType.active) {
      emit(state.copyWith(activePage: safePage));
    } else {
      emit(state.copyWith(inactivePage: safePage));
    }
  }

  void nextPage({int? lastPage}) {
    final current = state.currentPage;
    final maxPage = lastPage ?? current;
    if (current >= maxPage) {
      return;
    }

    goToPage(current + 1);
  }

  void previousPage() {
    final current = state.currentPage;
    if (current <= 1) {
      return;
    }

    goToPage(current - 1);
  }
}
