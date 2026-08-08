import 'dart:typed_data';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_details/order_details_model.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/manage_portfolio/create_portfolio_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_portfolio/create_portfolio/create_portfolio_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_portfolio/create_portfolio/create_portfolio_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_portfolio/create_portfolio/create_portfolio_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/gallery/widgets/case_name_field.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/gallery/widgets/gallery_images_row.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/pages/order_details/widgets/gallery/widgets/publish_switch.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePortfolioView extends StatefulWidget {
  const CreatePortfolioView({
    super.key,
    required this.order,
    required this.onCreated,
  });

  final OrderDetails order;
  final VoidCallback onCreated;

  @override
  State<CreatePortfolioView> createState() => _CreatePortfolioViewState();
}

class _CreatePortfolioViewState extends State<CreatePortfolioView> {
  late final TextEditingController _caseNameController;

  Uint8List? beforeImageBytes;
  Uint8List? afterImageBytes;
  String? beforeImageName;
  String? afterImageName;
  bool isPublished = true;

  @override
  void initState() {
    super.initState();
    _caseNameController = TextEditingController(
      text: widget.order.caseName ?? '',
    );
  }

  @override
  void dispose() {
    _caseNameController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_caseNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("يرجى إدخال اسم الحالة")));
      return;
    }
    if (beforeImageBytes == null || afterImageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى اختيار صورتي قبل وبعد")),
      );
      return;
    }

    context.read<CreatePortfolioBloc>().add(
      CreatePortfolioRequested(
        CreatePortfolioEntity(
          labId: widget.order.lab!.id!,
          orderId: widget.order.id!,
          caseName: _caseNameController.text.trim(),
          beforeImage: beforeImageBytes!,
          afterImage: afterImageBytes!,
          beforeImageName: beforeImageName,
          afterImageName: afterImageName,
          isPublished: isPublished,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePortfolioBloc, CreatePortfolioState>(
      listener: (context, state) {
        if (state.status == CreatePortfolioStatus.success) {
          AppSnackbarHelper.showSuccess(
            context,
            title: "تمت الإضافة",
            message:
                state.response?.message ?? "تمت إضافة الحالة إلى معرض الأعمال",
          );

          widget.onCreated();
        }

        if (state.status == CreatePortfolioStatus.failure) {
          AppSnackbarHelper.showFailure(
            context,
            title: "فشل الإضافة",
            message: state.failure?.message ?? "حدث خطأ",
            failure: state.failure,
          );
        }
      },
      builder: (context, state) {
        final loading = state.status == CreatePortfolioStatus.loading;

        return _GalleryCardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "أضف هذه الحالة إلى معرض الأعمال لتظهر للدكاترة.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),

              CaseNameField(controller: _caseNameController),
              const SizedBox(height: 20),

              GalleryImagesRow(
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
              const SizedBox(height: 20),

              Align(
                alignment: AlignmentDirectional.centerEnd,

                child: FilledButton.icon(
                  onPressed: loading
                      ? null
                      : () {
                          _submit(context);
                        },
                  icon: loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.add),
                  label: Text(loading ? "جاري الإضافة..." : "إضافة"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GalleryCardContainer extends StatelessWidget {
  const _GalleryCardContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      child: Padding(padding: const EdgeInsets.all(24), child: child),
    );
  }
}
