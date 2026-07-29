import 'package:equatable/equatable.dart';

abstract class ShowPackagesEvent extends Equatable {
  const ShowPackagesEvent();

  @override
  List<Object?> get props => [];
}

class ShowPackagesRequested extends ShowPackagesEvent {
  const ShowPackagesRequested({
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

class ShowPackagesRefresh extends ShowPackagesEvent {
  const ShowPackagesRefresh();
}