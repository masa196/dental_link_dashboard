import 'package:equatable/equatable.dart';

abstract class ShowOrdersEvent extends Equatable {
  const ShowOrdersEvent();

  @override
  List<Object?> get props => [];
}

class ShowOrdersRequested extends ShowOrdersEvent {
  const ShowOrdersRequested({
    required this.status,
    this.page = 1,
    this.perPage = 10,
    this.priority,
    this.clearPriority = false,
  });

  final String status;
  final int page;
  final int perPage;
  final String? priority;

  final bool clearPriority;

  @override
  List<Object?> get props => [
    status,
    page,
    perPage,
    priority,
    clearPriority,
  ];
}

class ShowOrdersRefresh extends ShowOrdersEvent {
  const ShowOrdersRefresh();
}