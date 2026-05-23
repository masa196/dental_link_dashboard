import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dental_link_dashboard/core/constants/app_fonts/app_typography.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_radius.dart';
import 'package:dental_link_dashboard/core/constants/app_values/app_spacing.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/lab_manager/domain/entities/departments_entity/departments_entity.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/create_departments/create_departments_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/create_departments/create_departments_bloc_event.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/manage_dep/create_departments/create_departments_bloc_state.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';

class CreateDepartmentsDialog extends StatefulWidget {
  const CreateDepartmentsDialog({super.key});

  @override
  State<CreateDepartmentsDialog> createState() =>
      _CreateDepartmentsDialogState();
}

class _CreateDepartmentsDialogState extends State<CreateDepartmentsDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _countController = TextEditingController();
  final List<TextEditingController> _nameControllers =
      <TextEditingController>[];
  late final CreateDepartmentsBulkBloc _createDepartmentsBulkBloc;

  int? _confirmedCount;
  String? _countError;

  @override
  void initState() {
    super.initState();
    _createDepartmentsBulkBloc = locator<CreateDepartmentsBulkBloc>();
  }

  @override
  void dispose() {
    _countController.dispose();
    for (final controller in _nameControllers) {
      controller.dispose();
    }
    _createDepartmentsBulkBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.isArabic;
    final scheme = context.scheme;
    final theme = Theme.of(context);
    final shadowColor = theme.shadowColor.withValues(alpha: 0.18);

    return MultiBlocProvider(
      providers: [BlocProvider.value(value: _createDepartmentsBulkBloc)],
      child: Dialog(
        backgroundColor: theme.dialogTheme.backgroundColor ?? scheme.surface,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Container(
            width: 520,
            constraints: const BoxConstraints(maxWidth: 560),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 40,
                  offset: Offset(0, 18),
                ),
              ],
            ),
            child:
                BlocListener<
                  CreateDepartmentsBulkBloc,
                  CreateDepartmentsBulkBlocState
                >(
                  listener: (context, blocState) {
                    if (blocState.status ==
                        CreateDepartmentsBulkStatus.success) {
                      Navigator.of(context).pop(
                        blocState.responseModel?.message ??
                            (isArabic
                                ? 'تم إنشاء الأقسام بنجاح'
                                : 'Departments created successfully'),
                      );
                      return;
                    }

                    if (blocState.status ==
                        CreateDepartmentsBulkStatus.failure) {
                      DepartmentSnackbarHelper.showFailure(
                        context,
                        title: isArabic
                            ? 'تعذر إنشاء الأقسام'
                            : 'Unable to create departments',
                        message:
                            blocState.failure?.message ??
                            (isArabic
                                ? 'حدث خطأ أثناء إنشاء الأقسام'
                                : 'An error occurred while creating departments'),
                        failure: blocState.failure,
                      );
                    }
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // تم تعديل الـ Row لتبدأ دائماً من بداية السطر حسب اتجاه اللغة
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                isArabic
                                    ? 'إضافة أقسام جديدة'
                                    : 'Add new departments',
                                style: TextStyle(
                                  fontSize: AppTypography.fs18,
                                  fontWeight: FontWeight.w800,
                                  color: scheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          _BuildModeTabs(isArabic: isArabic),
                          const SizedBox(height: AppSpacing.lg),
                          _BuildCountSection(
                            isArabic: isArabic,
                            scheme: scheme,
                            countController: _countController,
                            countError: _countError,
                            onConfirm: _confirmCount,
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          const Divider(height: 1),
                          const SizedBox(height: AppSpacing.xl),
                          _BuildNamesSection(
                            isArabic: isArabic,
                            scheme: scheme,
                            confirmedCount: _confirmedCount,
                            nameControllers: _nameControllers,
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child:
                                    BlocBuilder<
                                      CreateDepartmentsBulkBloc,
                                      CreateDepartmentsBulkBlocState
                                    >(
                                      builder: (context, blocState) {
                                        final isLoading =
                                            blocState.status ==
                                            CreateDepartmentsBulkStatus.loading;
                                        return ElevatedButton(
                                          onPressed: isLoading ? null : _submit,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: scheme.primary,
                                            foregroundColor: scheme.onPrimary,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    AppRadius.lg,
                                                  ),
                                            ),
                                          ),
                                          child: Text(
                                            isArabic
                                                ? 'حفظ التغييرات'
                                                : 'Save changes',
                                          ),
                                        );
                                      },
                                    ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: scheme.onSurface,
                                    side: BorderSide(
                                      color: scheme.outlineVariant,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppRadius.lg,
                                      ),
                                    ),
                                  ),
                                  child: Text(isArabic ? 'إلغاء' : 'Cancel'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }

  void _confirmCount() {
    final parsed = int.tryParse(_countController.text.trim());
    if (parsed == null || parsed <= 0) {
      setState(() {
        _countError = context.isArabic
            ? 'أدخل عددًا صحيحًا أكبر من صفر'
            : 'Enter a valid count greater than zero';
        _confirmedCount = null;
        _resetNameControllers();
      });
      return;
    }

    setState(() {
      _countError = null;
      _confirmedCount = parsed;
      _resetNameControllers(count: parsed);
    });
  }

  void _resetNameControllers({int? count}) {
    for (final controller in _nameControllers) {
      controller.dispose();
    }
    _nameControllers.clear();

    if (count == null) {
      return;
    }

    _nameControllers.addAll(
      List.generate(count, (_) => TextEditingController()),
    );
  }

  void _submit() {
    final isArabic = context.isArabic;
    final count = _confirmedCount;

    if (count == null) {
      setState(() {
        _countError = isArabic
            ? 'أكد عدد الأقسام أولًا'
            : 'Confirm the number of departments first';
      });
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final departments = _nameControllers
        .map((controller) => controller.text.trim())
        .where((name) => name.isNotEmpty)
        .map((name) => DepartmentInputEntity(name: name))
        .toList(growable: false);

    if (departments.length != count) {
      DepartmentSnackbarHelper.showFailure(
        context,
        title: isArabic ? 'بيانات ناقصة' : 'Incomplete data',
        message: isArabic
            ? 'أكمل جميع أسماء الأقسام المطلوبة'
            : 'Complete all required department names',
      );
      return;
    }

    _createDepartmentsBulkBloc.add(
      CreateDepartmentsBulkSubmitted(
        params: DepartmentsEntity(departments: departments),
      ),
    );
  }
}

class _BuildModeTabs extends StatelessWidget {
  const _BuildModeTabs({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final scheme = context.scheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _TabPill(
          label: isArabic ? 'الأقسام العامة' : 'General sections',
          selected: false,
          scheme: scheme,
        ),
        const SizedBox(width: AppSpacing.sm),
        _TabPill(
          label: isArabic ? 'أقسام مخصصة' : 'Custom sections',
          selected: true,
          scheme: scheme,
        ),
      ],
    );
  }
}

class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.label,
    required this.selected,
    required this.scheme,
  });

  final String label;
  final bool selected;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected
            ? scheme.primary.withValues(alpha: 0.12)
            : scheme.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: selected ? scheme.primary : scheme.outlineVariant,
          width: selected ? 1.2 : 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected
              ? scheme.primary
              : scheme.onSurface.withValues(alpha: 0.7),
          fontWeight: FontWeight.w700,
          fontSize: AppTypography.fs12,
        ),
      ),
    );
  }
}

class _BuildCountSection extends StatelessWidget {
  const _BuildCountSection({
    required this.isArabic,
    required this.scheme,
    required this.countController,
    required this.countError,
    required this.onConfirm,
  });

  final bool isArabic;
  final ColorScheme scheme;
  final TextEditingController countController;
  final String? countError;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.primary, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '1',
                  style: TextStyle(
                    color: scheme.onPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: AppTypography.fs12,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                isArabic ? 'حدد عدد الأقسام' : 'Set the number of departments',
                style: TextStyle(
                  color: scheme.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: AppTypography.fs16,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: countController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: isArabic
                        ? 'أدخل الرقم (مثال: 3)'
                        : 'Enter number (e.g. 3)',
                    errorText: countError,
                    filled: true,
                    fillColor:
                        Theme.of(context).inputDecorationTheme.fillColor ??
                        scheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: scheme.primary,
                    foregroundColor: scheme.onPrimary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                  ),
                  child: Text(isArabic ? 'تأكيد' : 'Confirm'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BuildNamesSection extends StatelessWidget {
  const _BuildNamesSection({
    required this.isArabic,
    required this.scheme,
    required this.confirmedCount,
    required this.nameControllers,
  });

  final bool isArabic;
  final ColorScheme scheme;
  final int? confirmedCount;
  final List<TextEditingController> nameControllers;

  @override
  Widget build(BuildContext context) {
    if (confirmedCount == null) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: scheme.secondary, width: 1.2),
        ),
        child: Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: scheme.secondary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '2',
                style: TextStyle(
                  color: scheme.onSecondary,
                  fontWeight: FontWeight.w800,
                  fontSize: AppTypography.fs12,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              isArabic ? 'تسمية الأقسام' : 'Name the departments',
              style: TextStyle(
                color: scheme.primary,
                fontWeight: FontWeight.w800,
                fontSize: AppTypography.fs16,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              isArabic
                  ? 'أكد عدد الأقسام أولًا ليتم عرض حقول الأسماء.'
                  : 'Confirm the count first to show the name fields.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: scheme.onSurface.withValues(alpha: 0.65),
                fontSize: AppTypography.fs13,
                height: 1.4,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.secondary, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: scheme.secondary.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // تصحيح اتجاه رأس قسم الأسماء ليتبع بداية السطر ديناميكياً
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: scheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: scheme.onSecondary,
                        fontWeight: FontWeight.w800,
                        fontSize: AppTypography.fs12,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    isArabic ? 'تسمية الأقسام' : 'Name the departments',
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: AppTypography.fs16,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: scheme.secondary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  isArabic
                      ? '$confirmedCount قسم'
                      : '$confirmedCount department${confirmedCount == 1 ? '' : 's'}',
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: AppTypography.fs12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ...List.generate(
            confirmedCount!,
            (index) => Padding(
              padding: EdgeInsets.only(
                bottom: index == confirmedCount! - 1 ? 0 : AppSpacing.md,
              ),
              child: _DepartmentNameField(
                index: index,
                isArabic: isArabic,
                controller: nameControllers[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DepartmentNameField extends StatelessWidget {
  const _DepartmentNameField({
    required this.index,
    required this.isArabic,
    required this.controller,
  });

  final int index;
  final bool isArabic;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          isArabic ? 'اسم القسم ${index + 1}' : 'Department name ${index + 1}',
          style: TextStyle(
            color: context.scheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: AppTypography.fs12,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: controller,
          textAlign:
              TextAlign.start, // تم التغيير ليدعم الاتجاه التلقائي للغة الواجهة
          validator: (value) {
            if ((value ?? '').trim().isEmpty) {
              return isArabic ? 'أدخل اسم القسم' : 'Enter department name';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: isArabic ? 'أدخل اسم القسم' : 'Enter department name',
            filled: true,
            fillColor:
                Theme.of(context).inputDecorationTheme.fillColor ??
                context.scheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
          ),
        ),
      ],
    );
  }
}
