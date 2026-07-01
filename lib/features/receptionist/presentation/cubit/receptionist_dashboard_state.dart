import 'package:dental_link_dashboard/core/utils/enums/enum_utils.dart';
import 'package:equatable/equatable.dart';


class ReceptionistDashboardState extends Equatable {
  final ReceptionistOrderTab selectedTab;

  const ReceptionistDashboardState({
    required this.selectedTab,
  });

  factory ReceptionistDashboardState.initial() {
    return const ReceptionistDashboardState(
      selectedTab: ReceptionistOrderTab.newOrders,
    );
  }

  ReceptionistDashboardState copyWith({
    ReceptionistOrderTab? selectedTab,
  }) {
    return ReceptionistDashboardState(
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object> get props => [selectedTab];
}