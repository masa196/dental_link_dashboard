import 'package:equatable/equatable.dart';

abstract class ShowDeliveryTasksEvent extends Equatable {
  const ShowDeliveryTasksEvent();

  @override
  List<Object?> get props => [];
}

class ShowDeliveryTasksRequested extends ShowDeliveryTasksEvent {
  const ShowDeliveryTasksRequested({
    this.page = 1,
    this.perPage = 10,
    this.search,
  });

  final int page;
  final int perPage;
  final String? search;

  @override
  List<Object?> get props => [
        page,
        perPage,
        search,
      ];
}

class ShowDeliveryTasksRefresh extends ShowDeliveryTasksEvent {
  const ShowDeliveryTasksRefresh();
}