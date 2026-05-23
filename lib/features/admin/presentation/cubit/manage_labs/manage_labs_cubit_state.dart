import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/features/admin/domain/entities/labs_query_params.dart';

class ManageLabsUiState extends Equatable {
  const ManageLabsUiState({
    this.selectedTab = LabsTabType.active,
    this.activePage = 1,
    this.inactivePage = 1,
  });

  final LabsTabType selectedTab;
  final int activePage;
  final int inactivePage;

  int get currentPage => switch (selectedTab) {
    LabsTabType.active => activePage,
    LabsTabType.inactive => inactivePage,
  };

  ManageLabsUiState copyWith({
    LabsTabType? selectedTab,
    int? activePage,
    int? inactivePage,
  }) {
    return ManageLabsUiState(
      selectedTab: selectedTab ?? this.selectedTab,
      activePage: activePage ?? this.activePage,
      inactivePage: inactivePage ?? this.inactivePage,
    );
  }

  @override
  List<Object?> get props => [selectedTab, activePage, inactivePage];
}
