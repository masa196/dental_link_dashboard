import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/features/admin/domain/entities/labs_query_params.dart';

abstract class ManageLabsBlocEvent extends Equatable {
  const ManageLabsBlocEvent();

  @override
  List<Object?> get props => [];
}

class ManageLabsFetchRequested extends ManageLabsBlocEvent {
  const ManageLabsFetchRequested({
    required this.tab,
    required this.page,
    required this.perPage,
  });

  final LabsTabType tab;
  final int page;
  final int perPage;

  @override
  List<Object?> get props => [tab, page, perPage];
}
