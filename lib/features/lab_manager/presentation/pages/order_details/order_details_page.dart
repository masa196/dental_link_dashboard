import 'package:dental_link_dashboard/core/navigation/app_routes.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_portfolio/create_portfolio/create_portfolio_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_portfolio/update_portfolio/update_portfolio_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/show_order_details/show_order_details_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/show_order_details/show_order_details_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/order_details_body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';

@injectable
class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({
    super.key,
    required this.orderId,
    required this.source,
  });

  final int orderId;
  final OrderDetailsSource source;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              locator<ShowOrderDetailsBloc>()
                ..add(ShowOrderDetailsRequested(orderId)),
        ),

        BlocProvider(create: (_) => locator<CreatePortfolioBloc>()),

        BlocProvider(create: (_) => locator<UpdatePortfolioBloc>()),
      ],
      child: const OrderDetailsBody(),
    );
  }
}
