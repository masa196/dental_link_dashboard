import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class WorkflowStep extends Equatable {
  final String title;

  /// 0 → 1
  final double progress;

  final bool isCurrent;

  /// null إذا لم يكن Current
  final String? status;

  /// هل لهذا القسم حالة TaskStatus من الـ API؟
  final bool hasStatus;

  const WorkflowStep({
    required this.title,
    required this.progress,
    required this.isCurrent,
    required this.status,
    required this.hasStatus,
  });

  Color get color {
    // 1- أي قسم مكتمل
    if (progress >= 1) {
      return AppLightColors.success;
    }

    // 2- القسم الحالي فقط يعتمد على task_status
    if (isCurrent) {
      switch (status) {
        case 'assigned':
        case 'pending_assignment':
          return const Color(0xff64748B);

        case 'in_progress':
          return const Color(0xff2563EB);

        case 'pending_review':
          return const Color(0xffF59E0B);

        default:
          return const Color(0xffCBD5E1);
      }
    }

    // 3- الأقسام المستقبلية
    return const Color(0xffCBD5E1);
  }

  String get statusLabel {
    switch (status) {
      case 'pending_assignment':
        return 'Pending Assignment';
      case 'assigned':
        return 'Assigned';

      case 'in_progress':
        return 'In Progress';

      case 'pending_review':
        return 'Pending Review';

      case 'completed':
        return 'Completed';

      default:
        return '';
    }
  }

  @override
  List<Object?> get props => [
        title,
        progress,
        isCurrent,
        status,
        hasStatus,
      ];
}