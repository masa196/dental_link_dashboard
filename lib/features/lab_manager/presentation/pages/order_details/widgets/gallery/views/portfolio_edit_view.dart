import 'dart:typed_data';

import 'package:dental_link_dashboard/features/lab_manager/data/models/order_details/order_details_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/manage_portfolio/update_portfolio_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_portfolio/update_portfolio/update_portfolio_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_portfolio/update_portfolio/update_portfolio_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_portfolio/update_portfolio/update_portfolio_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/gallery/widgets/case_name_field.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/gallery/widgets/gallery_images_row.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/gallery/widgets/publish_switch.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PortfolioEditView extends StatefulWidget {
  const PortfolioEditView({
    super.key,
    required this.order,
    required this.onCancel,
    required this.onSaved,
  });

  final OrderDetails order;
  final VoidCallback onCancel;
  final VoidCallback onSaved;

  @override
  State<PortfolioEditView> createState() => _PortfolioEditViewState();
}

class _PortfolioEditViewState extends State<PortfolioEditView> {
  late final TextEditingController _caseNameController;

  Uint8List? beforeImageBytes;
  Uint8List? afterImageBytes;
  String? beforeImageName;
  String? afterImageName;

  late bool isPublished;

  @override
  void initState() {
    super.initState();

    _caseNameController = TextEditingController(
      text: widget.order.caseName ?? '',
    );

    isPublished = widget.order.isPublished ?? false;
  }

  @override
  void dispose() {
    _caseNameController.dispose();
    super.dispose();
  }

  void _save(BuildContext context) {
    context.read<UpdatePortfolioBloc>().add(
      UpdatePortfolioRequested(
        UpdatePortfolioEntity(
          labId: widget.order.lab!.id!,
          portfolioId: widget.order.portfolioId!,
          caseName: _caseNameController.text.trim(),
          beforeImage: beforeImageBytes,
          afterImage: afterImageBytes,
          beforeImageName: beforeImageName,
          afterImageName: afterImageName,
          isPublished: isPublished,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdatePortfolioBloc, UpdatePortfolioState>(
      listener: (context, state) {
        if (state.status == UpdatePortfolioStatus.success) {
          AppSnackbarHelper.showSuccess(
            context,
            title: "تم التعديل",
            message: state.response?.message ?? "تم تحديث معرض الأعمال",
          );

          widget.onSaved();
        }

        if (state.status == UpdatePortfolioStatus.failure) {
          AppSnackbarHelper.showFailure(
            context,
            title: "فشل التعديل",
            message: state.failure?.message ?? "حدث خطأ",
            failure: state.failure,
          );
        }
      },
      builder: (context, state) {
        final loading = state.status == UpdatePortfolioStatus.loading;

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CaseNameField(
                  controller: _caseNameController,
                ),
                const SizedBox(height: 20),

                GalleryImagesRow(
                  beforeImageUrl: widget.order.beforeImagePath,
                  afterImageUrl: widget.order.afterImagePath,
                  beforeBytes: beforeImageBytes,
                  afterBytes: afterImageBytes,
                  onBeforeSelected: (bytes, name) {
                    setState(() {
                      beforeImageBytes = bytes;
                      beforeImageName = name;
                    });
                  },
                  onAfterSelected: (bytes, name) {
                    setState(() {
                      afterImageBytes = bytes;
                      afterImageName = name;
                    });
                  },
                ),

                const SizedBox(height: 20),

                PublishSwitch(
                  value: isPublished,
                  onChanged: loading
                      ? null
                      : (value) {
                          setState(() {
                            isPublished = value;
                          });
                        },
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: loading ? null : widget.onCancel,
                      child: const Text("إلغاء"),
                    ),

                    const SizedBox(width: 12),

                    FilledButton(
                      onPressed: loading
                          ? null
                          : () => _save(context),
                      child: loading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text("حفظ"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}