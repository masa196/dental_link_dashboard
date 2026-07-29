import 'package:equatable/equatable.dart';

abstract class ShowDoctorsEvent extends Equatable {
  const ShowDoctorsEvent();

  @override
  List<Object?> get props => [];
}

class ShowDoctorsRequested extends ShowDoctorsEvent {
  const ShowDoctorsRequested({
    this.page = 1,
    this.perPage = 15,
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

class ShowDoctorsRefresh extends ShowDoctorsEvent {
  const ShowDoctorsRefresh();
}