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
    this.search,
    this.clearPriority = false,
    this.clearSearch = false,
  });

  final String status;
  final int page;
  final int perPage;

  final String? priority;
  final String? search;

  final bool clearPriority;
  final bool clearSearch;

  @override
  List<Object?> get props => [
        status,
        page,
        perPage,
        priority,
        search,
        clearPriority,
        clearSearch,
      ];
}

class ShowOrdersRefresh extends ShowOrdersEvent {
  const ShowOrdersRefresh();
}