import 'package:dental_link_dashboard/features/lab_manager/data/models/order_delivery_time/order_delivery_time_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/order_delivery_time_entity/order_delivery_time_entity.dart';

import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/order_delivery_time/get_order_delivery_time/get_order_delivery_time_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/order_delivery_time/get_order_delivery_time/get_order_delivery_time_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/order_delivery_time/get_order_delivery_time/get_order_delivery_time_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/order_delivery_time/update_order_delivery_time/update_order_delivery_time_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/order_delivery_time/update_order_delivery_time/update_order_delivery_time_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/order_delivery_time/update_order_delivery_time/update_order_delivery_time_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDeliveryTimeDialog extends StatefulWidget {
  const OrderDeliveryTimeDialog({
    super.key,
  });

  @override
  State<OrderDeliveryTimeDialog> createState() =>
      _OrderDeliveryTimeDialogState();
}
class _OrderDeliveryTimeDialogState
    extends State<OrderDeliveryTimeDialog> {

  bool editing = false;
  final normalController = TextEditingController();
  final urgentController = TextEditingController();
  String? normalError;
  String? urgentError;


  @override
  Widget build(BuildContext context) {

    return MultiBlocListener(
      listeners: [
        BlocListener< UpdateOrderDeliveryTimeBloc,UpdateOrderDeliveryTimeState>(
          listener: (context, state) {
            if (state.isSuccess) {
              AppSnackbarHelper.showSuccess(
                context,
                title: "نجاح العملية",
                message: state.response?.message ?? '',
              );
              context.read<GetOrderDeliveryTimeBloc>() .add(
                    const GetOrderDeliveryTimeRequested(),
                  );
              Navigator.pop(context);
            }
            if (state.failure != null) {
              AppSnackbarHelper.showFailure(
                context,
                title: "فشل العملية",
                message: state.failure!.message,
                failure: state.failure,
              );
            }
          },
        ),
      ],
      child: AlertDialog(
        title: const Text(
          "مدة تسليم الطلبيات",
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 350,
          ),
          child: BlocBuilder<GetOrderDeliveryTimeBloc, GetOrderDeliveryTimeState>(

            builder: (context, state) {

              if (state.isLoading) {

                return const SizedBox(

                  height: 200,

                  child: Center(
                    child: CircularProgressIndicator(),
                  ),

                );

              }


              final data = state.deliveryTime;


              if (data == null) {

                return const SizedBox(
                  height: 80,
                  child: Center(
                    child: Text(
                      "لا توجد بيانات",
                    ),
                  ),
                );

              }


              _fillControllers(data);



              if (!editing) {

                return Column(

                  mainAxisSize: MainAxisSize.min,

                  children: [


                    _infoTile(
                      context,
                      title: "الطلبات العادية",
                      value:
                          "${data.normalDeliveryDays} أيام",
                    ),


                    const SizedBox(height: 12),



                    _infoTile(
                      context,
                      title: "الطلبات المستعجلة",
                      value:
                          "${data.urgentDeliveryDays} أيام",
                    ),


                  ],

                );

              }



              return Column(

                mainAxisSize: MainAxisSize.min,

                children: [


                  TextField(

                    controller: normalController,

                    keyboardType:
                        TextInputType.number,


                    decoration: InputDecoration(

                      labelText:
                          "الطلبات العادية",

                      errorText:
                          normalError,

                    ),

                  ),


                  const SizedBox(
                    height: 15,
                  ),



                  TextField(

                    controller: urgentController,

                    keyboardType:
                        TextInputType.number,


                    decoration: InputDecoration(

                      labelText:
                          "الطلبات المستعجلة",

                      errorText:
                          urgentError,

                    ),

                  ),


                ],

              );

            },

          ),

        ),

         actions: [

  TextButton(
    onPressed: context
            .watch<UpdateOrderDeliveryTimeBloc>()
            .state
            .isLoading
        ? null
        : () {
            setState(() {
              editing = !editing;

              if (!editing) {
                normalError = null;
                urgentError = null;

                normalController.clear();
                urgentController.clear();
              }
            });
          },

    child: Text(
      editing ? "إلغاء" : "تعديل",
    ),
  ),


  if (editing)

    ElevatedButton(
      onPressed: context
              .watch<UpdateOrderDeliveryTimeBloc>()
              .state
              .isLoading
          ? null
          : _save,

      child: context
              .watch<UpdateOrderDeliveryTimeBloc>()
              .state
              .isLoading

          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )

          : const Text(
              "حفظ",
            ),
    ),

],

      ),

    );

  }




  void _fillControllers(
      OrderDeliveryTimeModel data,
      ) {

    if (!editing) return;


    if (normalController.text.isEmpty) {

      normalController.text =
          data.normalDeliveryDays.toString();

    }


    if (urgentController.text.isEmpty) {

      urgentController.text =
          data.urgentDeliveryDays.toString();

    }

  }





 Widget _infoTile(
  BuildContext context, {
  required String title,
  required String value,
}) {
  final colors = Theme.of(context).colorScheme;

  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 12,
    ),

    decoration: BoxDecoration(
      color: colors.surface,

      borderRadius: BorderRadius.circular(12),

      border: Border.all(
        color: colors.outline,
        width: 1,
      ),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [

        Text(
          title,
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),


        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),

          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.12),

            borderRadius: BorderRadius.circular(8),
          ),

          child: Text(
            value,

            style: TextStyle(
              color: colors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

      ],
    ),
  );
}





  void _save() {


    setState(() {


      normalError =
          normalController.text.trim().isEmpty

              ? "يرجى إدخال عدد الأيام"

              : null;



      urgentError =
          urgentController.text.trim().isEmpty

              ? "يرجى إدخال عدد الأيام"

              : null;


    });



    if (normalError != null ||
        urgentError != null) {

      return;

    }



    context
        .read<UpdateOrderDeliveryTimeBloc>()
        .add(

          UpdateOrderDeliveryTimeRequested(

            parameters:
                OrderDeliveryTimeEntity(

              normalDeliveryDays:
                  int.parse(
                    normalController.text,
                  ),


              urgentDeliveryDays:
                  int.parse(
                    urgentController.text,
                  ),

            ),

          ),

        );

  }





  @override
  void dispose() {

    normalController.dispose();

    urgentController.dispose();

    super.dispose();

  }

}