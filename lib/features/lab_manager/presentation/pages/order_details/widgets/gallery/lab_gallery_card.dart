import 'package:dental_link_dashboard/features/lab_manager/data/models/order_details/order_details_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/show_order_details/show_order_details_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/show_order_details/show_order_details_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/gallery/views/create_portfolio_view.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/gallery/views/portfolio_edit_view.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/gallery/views/portfolio_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabGalleryCard extends StatefulWidget {
  const LabGalleryCard({super.key, required this.order});

  final OrderDetails order;

  @override
  State<LabGalleryCard> createState() => _LabGalleryCardState();
}

class _LabGalleryCardState extends State<LabGalleryCard> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    /// الطلب لم تتم إضافته للمعرض بعد

    if (widget.order.isPublished == null) {
      return CreatePortfolioView(
        order: widget.order,

        onCreated: () {
          context.read<ShowOrderDetailsBloc>().add(
            ShowOrderDetailsRequested(widget.order.id!),
          );
        },
      );
    }

    /// تعديل الحالة
    if (isEditing) {
      return PortfolioEditView(
        order: widget.order,

        onCancel: () {
          setState(() {
            isEditing = false;
          });
        },

        onSaved: () {
          setState(() {
            isEditing = false;
          });

          context.read<ShowOrderDetailsBloc>().add(
            ShowOrderDetailsRequested(widget.order.id!),
          );
        },
      );
    }

    /// العرض العادي

    return PortfolioView(
      order: widget.order,

      onEdit: () {
        setState(() {
          isEditing = true;
        });
      },
    );
  }
}
