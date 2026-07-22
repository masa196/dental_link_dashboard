import 'package:dental_link_dashboard/features/lab_manager/data/models/show_materials/show_materials_model.dart';
import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';

class ShowMaterialsState extends Equatable {
  const ShowMaterialsState({
    this.materials = const [],
    this.failure,
    this.isLoading = false,
    this.currentPage = 1,
    this.lastPage = 1,
    this.currentSearch,
  });

  final List<MaterialItem> materials;

  final AppFailure? failure;

  final bool isLoading;

  final int currentPage;

  final int lastPage;

  final String? currentSearch;

  ShowMaterialsState copyWith({
    List<MaterialItem>? materials,
    AppFailure? failure,
    bool? isLoading,
    int? currentPage,
    int? lastPage,
    String? currentSearch,
  }) {
    return ShowMaterialsState(
      materials: materials ?? this.materials,
      failure: failure,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      currentSearch: currentSearch ?? this.currentSearch,
    );
  }

  @override
  List<Object?> get props => [
        materials,
        failure,
        isLoading,
        currentPage,
        lastPage,
        currentSearch,
      ];
}