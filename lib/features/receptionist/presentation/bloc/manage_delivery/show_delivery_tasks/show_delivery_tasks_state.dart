import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/delivery_tasks_model/delivery_tasks_model.dart';

class ShowDeliveryTasksState extends Equatable {
  const ShowDeliveryTasksState({
    this.tasks = const [],
    this.failure,
    this.isLoading = false,
    this.currentPage = 1,
    this.lastPage = 1,
    this.currentSearch,
  });

  final List<TaskInfo> tasks;

  final AppFailure? failure;

  final bool isLoading;

  final int currentPage;

  final int lastPage;

  final String? currentSearch;

  ShowDeliveryTasksState copyWith({
    List<TaskInfo>? tasks,
    AppFailure? failure,
    bool? isLoading,
    int? currentPage,
    int? lastPage,
    String? currentSearch,
  }) {
    return ShowDeliveryTasksState(
      tasks: tasks ?? this.tasks,
      failure: failure,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      currentSearch: currentSearch ?? this.currentSearch,
    );
  }

  @override
  List<Object?> get props => [
        tasks,
        failure,
        isLoading,
        currentPage,
        lastPage,
        currentSearch,
      ];
}