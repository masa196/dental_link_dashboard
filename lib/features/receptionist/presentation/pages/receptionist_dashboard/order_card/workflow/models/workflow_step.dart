import 'package:equatable/equatable.dart';

enum StepStatus { pending, active, done, rejected }

class WorkflowStep extends Equatable {
  final String title;
  final StepStatus status;

  const WorkflowStep({required this.title, required this.status});

  WorkflowStep copyWith({String? title, StepStatus? status}) {
    return WorkflowStep(
      title: title ?? this.title,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [title, status];
}
