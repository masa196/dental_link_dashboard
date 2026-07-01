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
    this.perPage = 15,
  });

  final String status;
  final int page;
  final int perPage;

  @override
  List<Object?> get props => [
        status,
        page,
        perPage,
      ];
}



class ShowOrdersRefresh extends ShowOrdersEvent {
  const ShowOrdersRefresh();
}