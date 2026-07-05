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
        ReceptionistOrderTab.needsTest => true,
        _ => false,
      };
    }

    String getButtonTitle(ReceptionistOrderTab tab) {
  switch (tab) {
    case ReceptionistOrderTab.pending:
      return 'اطبع QR لبدء العمل';

    case ReceptionistOrderTab.inProgress:
      return 'تغيير حالة الطلب';

    case ReceptionistOrderTab.newOrders:
    case ReceptionistOrderTab.needsRedo:
    case ReceptionistOrderTab.needsTest:
    case ReceptionistOrderTab.readyToSend:
      return 'إنشاء مهمة توصيل';
  }
}

String getTabApiValue(ReceptionistOrderTab tab) {
  switch (tab) {
    case ReceptionistOrderTab.newOrders:
      return 'new';

    case ReceptionistOrderTab.pending:
      return 'pending';

    case ReceptionistOrderTab.inProgress:
      return 'in_progress';

    case ReceptionistOrderTab.needsRedo:
      return 'needs_redo';

    case ReceptionistOrderTab.needsTest:
      return 'needs_test';

    case ReceptionistOrderTab.readyToSend:
      return 'ready_to_send';
  }
}
  }