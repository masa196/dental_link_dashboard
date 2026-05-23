import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/features/admin/domain/entities/labs_query_params.dart';
import 'package:dental_link_dashboard/features/admin/data/models/labs/labs_model.dart';

enum ManageLabsRemoteStatus { initial, loading, success, failure }

class ManageLabsBlocState extends Equatable {
  const ManageLabsBlocState({
    this.status = ManageLabsRemoteStatus.initial,
    this.page,
    this.failureMessage,
    this.tab = LabsTabType.active,
  });

  final ManageLabsRemoteStatus status;
  final PaginatedLabsResponseModel? page;
  final String? failureMessage;
  final LabsTabType tab;

  PaginatedLabsPageModel? get _pageData => page?.data;

  List<LabModel> get labs => _pageData?.data ?? const <LabModel>[];

  int get currentPage => _pageData?.currentPage ?? 1;

  int get lastPage => _pageData?.lastPage ?? 1;

  int get total => _pageData?.total ?? 0;

  int get from => _pageData?.from ?? 0;

  int get to => _pageData?.to ?? 0;

  int get perPage => _pageData?.perPage ?? 15;

  bool get hasData => labs.isNotEmpty;

  bool get isLoading => status == ManageLabsRemoteStatus.loading;

  bool get isInitialLoading => isLoading && !hasData;

  ManageLabsBlocState copyWith({
    ManageLabsRemoteStatus? status,
    PaginatedLabsResponseModel? page,
    String? failureMessage,
    bool clearFailureMessage = false,
    LabsTabType? tab,
  }) {
    return ManageLabsBlocState(
      status: status ?? this.status,
      page: page ?? this.page,
      failureMessage: clearFailureMessage
          ? null
          : failureMessage ?? this.failureMessage,
      tab: tab ?? this.tab,
    );
  }

  @override
  List<Object?> get props => [status, page, failureMessage, tab];
}
