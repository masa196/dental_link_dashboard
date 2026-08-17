import 'package:dental_link_dashboard/features/admin/data/models/packages/packages_model.dart';
import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';

class ShowPackagesState extends Equatable {
  const ShowPackagesState({
    this.packages = const [],
    this.failure,
    this.isLoading = false,
    this.currentPage = 1,
    this.lastPage = 1,
    this.currentSearch,
  });

  final List<PackageItemModel> packages;
  final AppFailure? failure;
  final bool isLoading;
  final int currentPage;
  final int lastPage;
  final String? currentSearch;

  ShowPackagesState copyWith({
    List<PackageItemModel>? packages,
    AppFailure? failure,
    bool? isLoading,
    int? currentPage,
    int? lastPage,
    String? currentSearch,
  }) {
    return ShowPackagesState(
      packages: packages ?? this.packages,
      failure: failure,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      currentSearch: currentSearch ?? this.currentSearch,
    );
  }

  @override
  List<Object?> get props => [
        packages,
        failure,
        isLoading,
        currentPage,
        lastPage,
        currentSearch,
      ];
}