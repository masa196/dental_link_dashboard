import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/orders/show_orders_bloc.dart';
import 'package:dental_link_dashboard/features/receptionist/presentation/bloc/orders/show_orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../order_card/order_card.dart';

class OrdersList extends StatelessWidget {
  final String buttonTitle;

  const OrdersList({
    super.key,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowOrdersBloc, ShowOrdersState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.failure != null) {
          return Center(
            child: Text(state.failure!.message),
          );
        }

        if (state.orders.isEmpty) {
          return const Center(
            child: Text('No orders found'),
          );
        }

        return ListView.builder(
          itemCount: state.orders.length,
          itemBuilder: (context, index) {
            return OrderCard(
              order: state.orders[index],
              buttonTitle: buttonTitle,
            );
          },
        );
      },
    );
  }
}