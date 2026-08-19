import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/get_package_assigned/get_package_assigned_bloc.dart';
import 'package:dental_link_dashboard/features/lab_manager/presentation/bloc/get_package_assigned/get_package_assigned_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPackageDialog extends StatelessWidget {
  const MyPackageDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GetPackageAssignedBloc,
      GetPackageAssignedState
    >(
      builder: (context, state) {
        return AlertDialog(
          title: const Text(
            "باقتي الحالية",
            textDirection: TextDirection.rtl,
          ),
          content: _buildContent(context, state),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("إغلاق"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    GetPackageAssignedState state,
  ) {
    if (state.isLoading) {
      return const SizedBox(
        width: 350,
        height: 180,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.failure != null) {
      return SizedBox(
        width: 350,
        child: Text(
          state.failure!.message,
          textDirection: TextDirection.rtl,
        ),
      );
    }

    final package = state.package;

    if (package == null) {
      return const SizedBox(
        width: 350,
        child: Text(
          "لا توجد باقة مشترَك بها حاليًا.",
          textDirection: TextDirection.rtl,
        ),
      );
    }

    return SizedBox(
      width: 420,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _InfoRow(
              label: "اسم الباقة",
              value: package.name ?? "-",
            ),

            const SizedBox(height: 12),

            _InfoRow(
              label: "الوصف",
              value: package.description?.trim().isNotEmpty == true
                  ? package.description!.trim()
                  : "لا يوجد وصف",
            ),

            const SizedBox(height: 12),

            _InfoRow(
              label: "مدة الاشتراك",
              value: _formatDuration(package.durationDays),
            ),

            const SizedBox(height: 12),

            _InfoRow(
              label: "السعر",
              value: "${package.price ?? "0"} ل.س",
            ),

            const SizedBox(height: 12),

            _InfoRow(
              label: "الحالة",
              value: package.isActive == true
                  ? "متاحة"
                  : "غير متاحة",
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(int? days) {
    if (days == null || days <= 0) {
      return "-";
    }

    if (days >= 360 && days <= 370) {
      return "سنة";
    }

    final months = days ~/ 30;
    final remainingDays = days % 30;

    if (months > 0 && remainingDays == 0) {
      if (months == 1) {
        return "شهر واحد";
      }

      if (months == 2) {
        return "شهران";
      }

      return "$months أشهر";
    }

    if (months > 0) {
      if (months == 1) {
        return "شهر و $remainingDays يوم";
      }

      return "$months أشهر و $remainingDays يوم";
    }

    return "$days يوم";
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(
          alpha: .45,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              value,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}