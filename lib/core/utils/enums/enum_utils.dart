import 'package:dental_link_dashboard/features/receptionist/data/models/orders_model.dart';

enum PageAnimation { slide, fade, none }

enum ReceptionistOrderTab {
  newOrders,
  pending,
  inProgress,
  needsRedo,
  needsTrial,
  readyToSend,
}




extension ReceptionistOrderTabX on ReceptionistOrderTab {
  String get apiStatus {
    switch (this) {
      case ReceptionistOrderTab.newOrders:
        return 'new';

      case ReceptionistOrderTab.pending:
        return 'pending';

      case ReceptionistOrderTab.inProgress:
        return 'in_progress';

      case ReceptionistOrderTab.needsRedo:
        return 'resend_wrong_impression';

      case ReceptionistOrderTab.needsTrial:
        return 'try_on';

      case ReceptionistOrderTab.readyToSend:
        return 'completed';
    }
  }
}


enum OrderMode {
  simple,
  workflow,
}


enum OrderPriority {
  normal,
  urgent,
}


extension OrderModeX on OrderModel {
  OrderMode get mode {
    switch (status) {
      case "in_progress":
      case "needs_redo":
      case "needs_trial":
        return OrderMode.workflow;

      default:
        return OrderMode.simple;
    }
  }
}

OrderPriority parsePriority(String? value) {
  switch (value) {
    case "urgent":
      return OrderPriority.urgent;
    default:
      return OrderPriority.normal;
  }
}


