import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/features/lab_manager/domain/entities/system_logs/system_logs_entity.dart';

sealed class SystemLogsEvent extends Equatable {
  const SystemLogsEvent();

  @override
  List<Object?> get props => [];
}

final class GetSystemLogsEvent extends SystemLogsEvent {
  const GetSystemLogsEvent({
    this.parameters = const SystemLogsEntity(),
  });

  final SystemLogsEntity parameters;

  @override
  List<Object?> get props => [parameters];
}

final class ChangeSystemLogsPageEvent extends SystemLogsEvent {
  const ChangeSystemLogsPageEvent({
    required this.page,
  });

  final int page;

  @override
  List<Object?> get props => [page];
}