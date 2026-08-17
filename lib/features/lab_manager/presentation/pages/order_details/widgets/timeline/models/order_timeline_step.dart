import 'package:flutter/material.dart';
import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';

enum TimelineStatus {
  completed,
  current,
  pending,
}

class OrderTimelineStep {
  final String title;

  final String employeeName;

  final String? status;

  final TimelineStatus timelineStatus;

  final double progress;

  const OrderTimelineStep({
    required this.title,
    required this.employeeName,
    required this.status,
    required this.timelineStatus,
    required this.progress,
  });

  bool get isCompleted =>
      timelineStatus == TimelineStatus.completed;

  bool get isCurrent =>
      timelineStatus == TimelineStatus.current;

  bool get isPending =>
      timelineStatus == TimelineStatus.pending;

  Color get color {
    if (isCompleted) {
      return AppLightColors.success;
    }

    if (isCurrent) {
      switch (status) {
        case 'assigned':
        case 'pending_assignment':
          return const Color(0xff64748B);

        case 'in_progress':
          return const Color(0xff2563EB);

        case 'pending_review':
          return const Color(0xffF59E0B);

        case 'completed':
          return AppLightColors.success;

        default:
          return AppLightColors.primary;
      }
    }

    return const Color(0xffCBD5E1);
  }

  String get statusLabel {
    switch (status) {
      case 'assigned':
      case 'pending_assignment':
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
}