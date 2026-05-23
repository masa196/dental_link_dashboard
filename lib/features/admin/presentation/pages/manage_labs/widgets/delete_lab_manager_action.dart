import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_link_dashboard/core/auth/auth_token_storage.dart';
import 'package:dental_link_dashboard/core/extensions/context_extensions.dart';
import 'package:dental_link_dashboard/core/services/locator.dart';
import 'package:dental_link_dashboard/features/admin/domain/entities/delete_lab_manager/delete_lab_manager_entity.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/delete_lab_manager/delete_lab_manager_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/delete_lab_manager/delete_lab_manager_bloc_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/delete_lab_manager/delete_lab_manager_bloc_state.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc.dart';
import 'package:dental_link_dashboard/features/admin/presentation/bloc/labs/manage_labs/manage_labs_bloc_event.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/manage_labs/manage_labs_cubit.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/widgets/department_snackbar_helper.dart';

Future<void> confirmAndDeleteLab(
  BuildContext context, {
  required int labId,
  required String labName,
}) async {
  final l10n = context.l10n;

  final confirmed = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(l10n.delete),
        content: Text(
          context.isArabic
              ? 'هل تريد حذف المخبر "$labName"؟'
              : 'Do you want to delete the lab "$labName"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.delete),
          ),
        ],
      );
    },
  );

  if (confirmed != true || !context.mounted) {
    return;
  }

  final token = locator<AuthTokenStorage>().token;
  if (token == null || token.isEmpty) {
    AppSnackbarHelper.showFailure(
      context,
      title: l10n.error,
      message: context.isArabic
          ? 'لا يوجد توكن صالح لتنفيذ الحذف'
          : 'No valid token available for deletion',
    );
    return;
  }

  final bloc = locator<DeleteLabManagerBloc>();
  final params = DeleteLabManagerEntity(labId: labId);

  late final StreamSubscription sub;
  sub = bloc.stream.listen((state) async {
    if (!context.mounted) {
      await sub.cancel();
      await bloc.close();
      return;
    }

    if (state.status == DeleteLabManagerRemoteStatus.success) {
      AppSnackbarHelper.showSuccess(
        context,
        title: context.l10n.success,
        message:
            state.responseModel?.message ??
            (context.isArabic
                ? 'تم حذف المخبر بنجاح'
                : 'Lab deleted successfully'),
      );

      _refreshLabs(context);
      await sub.cancel();
      await bloc.close();
      return;
    }

    if (state.status == DeleteLabManagerRemoteStatus.failure) {
      AppSnackbarHelper.showFailure(
        context,
        title: context.l10n.error,
        message:
            state.failure?.message ??
            (context.isArabic ? 'فشل حذف المخبر' : 'Failed to delete lab'),
        failure: state.failure,
      );

      await sub.cancel();
      await bloc.close();
    }
  });

  bloc.add(DeleteLabManagerSubmitted(params: params));
}

void _refreshLabs(BuildContext context) {
  if (!context.mounted) return;

  final uiState = context.read<ManageLabsCubit>().state;
  context.read<ManageLabsBloc>().add(
    ManageLabsFetchRequested(
      tab: uiState.selectedTab,
      page: uiState.currentPage,
      perPage: ManageLabsCubit.pageSize,
    ),
  );
}
