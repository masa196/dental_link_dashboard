import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/all_doctors/all_doctors_model.dart';

class ShowDoctorsState extends Equatable {
  const ShowDoctorsState({
    this.doctors = const [],
    this.totals,
    this.failure,
    this.isLoading = false,
    this.currentPage = 1,
    this.lastPage = 1,
    this.currentSearch,
  });

  final List<DoctorModel> doctors;

  final Totals? totals;

  final AppFailure? failure;

  final bool isLoading;

  final int currentPage;

  final int lastPage;

  final String? currentSearch;

  ShowDoctorsState copyWith({
    List<DoctorModel>? doctors,
    Totals? totals,
    AppFailure? failure,
    bool? isLoading,
    int? currentPage,
    int? lastPage,
    String? currentSearch,
  }) {
    return ShowDoctorsState(
      doctors: doctors ?? this.doctors,
      totals: totals ?? this.totals,
      failure: failure,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      currentSearch: currentSearch ?? this.currentSearch,
    );
  }

  @override
  List<Object?> get props => [
        doctors,
        totals,
        failure,
        isLoading,
        currentPage,
        lastPage,
        currentSearch,
      ];
}