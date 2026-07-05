import 'package:dental_link_dashboard/features/receptionist/data/models/delivery_employees_model/delivery_employees_model.dart';
import 'package:flutter/material.dart';

import 'delivery_employee_dialog.dart';

Future<int?> showDeliveryEmployeeDialog(
  BuildContext context,
  List<DeliveryEmplyee> employees,
) {
  return showDialog<int>(
    context: context,
    builder: (_) => DeliveryEmployeeDialog(
      employees: employees,
    ),
  );
}