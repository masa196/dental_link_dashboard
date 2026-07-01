  import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

  import '../../../../core/utils/enums/enum_utils.dart';
  import 'receptionist_dashboard_state.dart';


  @injectable
  class ReceptionistDashboardCubit extends Cubit<ReceptionistDashboardState> {
    ReceptionistDashboardCubit()
        : super(ReceptionistDashboardState.initial());

    void changeTab(ReceptionistOrderTab tab) {
      emit(state.copyWith(
        selectedTab: tab,
      ));
    }

    bool shouldUseWorkflow(ReceptionistOrderTab tab) {
      return switch (tab) {
        ReceptionistOrderTab.inProgress => true,
        ReceptionistOrderTab.needsRedo => true,
        ReceptionistOrderTab.needsTrial => true,
        _ => false,
      };
    }
  }