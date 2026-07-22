import 'package:equatable/equatable.dart';

abstract class ShowMaterialsEvent extends Equatable {
  const ShowMaterialsEvent();

  @override
  List<Object?> get props => [];
}

class ShowMaterialsRequested extends ShowMaterialsEvent {
  const ShowMaterialsRequested({
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

class ShowMaterialsRefresh extends ShowMaterialsEvent {
  const ShowMaterialsRefresh();
}