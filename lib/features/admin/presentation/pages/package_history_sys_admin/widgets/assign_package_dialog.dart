import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/show_packages/show_packages_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/show_packages/show_packages_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/manage_packages/show_packages/show_packages_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/assign_package_to_lab/assign_package_to_lab_entity.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/assign_package_to_lab/assign_package_to_lab_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/assign_package_to_lab/assign_package_to_lab_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/assign_package_to_lab/assign_package_to_lab_state.dart';


class AssignPackageDialog extends StatelessWidget {
  const AssignPackageDialog({
    super.key,
    required this.labId,
  });

  final int labId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<ShowPackagesBloc>()
            ..add(
              const ShowPackagesRequested(
                page: 1,
                perPage: 15,
              ),
            ),
        ),
        BlocProvider(
          create: (_) => locator<AssignPackageToLabBloc>(),
        ),
      ],
      child: _AssignPackageDialogContent(
        labId: labId,
      ),
    );
  }
}

class _AssignPackageDialogContent extends StatefulWidget {
  const _AssignPackageDialogContent({
    required this.labId,
  });

  final int labId;

  @override
  State<_AssignPackageDialogContent> createState() =>
      _AssignPackageDialogContentState();
}

class _AssignPackageDialogContentState
    extends State<_AssignPackageDialogContent> {
  int? selectedPackageId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AssignPackageToLabBloc, AssignPackageToLabState>(
      listener: (context, state) {
        if (state.response != null) {
          final message = state.response?.message ??
              'تم إسناد الباقة بنجاح';

          AppSnackbarHelper.showSuccess(
            context,
            title: 'تمت العملية',
            message: message,
          );

          Navigator.of(context).pop(true);
        }

        if (state.failure != null) {
          final message =
              state.failure?.message ?? 'تعذر إسناد الباقة';

          AppSnackbarHelper.showFailure(
            context,
            title: 'فشل الإسناد',
            message: message,
          );
        }
      },
      child: AlertDialog(
        title: const Text('إسناد باقة'),
        content: SizedBox(
          width: 500,
          child: BlocBuilder<ShowPackagesBloc, ShowPackagesState>(
            builder: (context, state) {
              if (state.isLoading && state.packages.isEmpty) {
                return const SizedBox(
                  height: 150,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state.failure != null && state.packages.isEmpty) {
                return const SizedBox(
                  height: 150,
                  child: Center(
                    child: Text(
                      'تعذر تحميل الباقات',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              final availablePackages = state.packages
                  .where(
                    (package) => package.isActive == true,
                  )
                  .toList();

              if (availablePackages.isEmpty) {
                return const SizedBox(
                  height: 150,
                  child: Center(
                    child: Text(
                      'لا توجد باقات متاحة حاليًا',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              return BlocBuilder<AssignPackageToLabBloc,
                  AssignPackageToLabState>(
                builder: (context, assignState) {
                  final bool isAssigning = assignState.isLoading;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...availablePackages.map(
                        (package) {
                          final bool isSelected =
                              selectedPackageId == package.id;

                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                            ),
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.circular(12),
                              onTap: isAssigning
                                  ? null
                                  : () {
                                      setState(() {
                                        selectedPackageId =
                                            package.id;
                                      });
                                    },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                  color: isSelected
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withValues(alpha: 0.08)
                                      : null,
                                  border: Border.all(
                                    color: isSelected
                                        ? Theme.of(context)
                                            .colorScheme
                                            .primary
                                        : Theme.of(context)
                                            .dividerColor,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Radio<int>(
                                      value: package.id!,
                                      groupValue:
                                          selectedPackageId,
                                      onChanged: isAssigning
                                          ? null
                                          : (value) {
                                              setState(() {
                                                selectedPackageId =
                                                    value;
                                              });
                                            },
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            package.name ?? '—',
                                            style: const TextStyle(
                                              fontWeight:
                                                  FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            package.durationDays !=
                                                    null
                                                ? '${package.durationDays} يوم'
                                                : '—',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('إلغاء'),
          ),
          BlocBuilder<AssignPackageToLabBloc,
              AssignPackageToLabState>(
            builder: (context, state) {
              return FilledButton(
                onPressed: selectedPackageId == null ||
                        state.isLoading
                    ? null
                    : () {
                        context
                            .read<AssignPackageToLabBloc>()
                            .add(
                              AssignPackageToLabRequested(
                                parameters:
                                    AssignPackageToLabEntity(
                                  labId: widget.labId,
                                  packageId:
                                      selectedPackageId!,
                                ),
                              ),
                            );
                      },
                child: state.isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('إسناد الباقة'),
              );
            },
          ),
        ],
      ),
    );
  }
}