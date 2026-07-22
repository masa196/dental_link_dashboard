import 'package:dental_link_dashboard/features/receptionist/data/models/orders_model/orders_model.dart';

enum PageAnimation { slide, fade, none }

enum ReceptionistOrderTab {
  newOrders,
  pending,
  inProgress,
  needsRedo,
  needsTest,
  readyToSend,
}

enum UpdateOrderStatusOption {
  needsRedo,
  needsTest,
}

enum OrderMode {
  simple,
  workflow,
}


enum OrderPriority {
  normal,
  urgent,
}


enum OrdersMode {
  receptionist,
  labManager,
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

      case ReceptionistOrderTab.needsTest:
        return 'try_on';

      case ReceptionistOrderTab.readyToSend:
        return 'completed';
    }
  }
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


extension UpdateOrderStatusOptionX on UpdateOrderStatusOption {
  String get apiValue {
    switch (this) {
      case UpdateOrderStatusOption.needsRedo:
        return 'resend_wrong_impression';

      case UpdateOrderStatusOption.needsTest:
        return 'try_on';
    }
  }

  String get title {
    switch (this) {
      case UpdateOrderStatusOption.needsRedo:
        return 'تحتاج لإعادة';

      case UpdateOrderStatusOption.needsTest:
        return 'تحتاج للتجربة';
    }
  }
}

