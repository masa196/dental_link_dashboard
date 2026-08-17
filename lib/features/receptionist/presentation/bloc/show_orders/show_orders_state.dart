import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/orders_model/orders_model.dart';

class ShowOrdersState extends Equatable {
  const ShowOrdersState({
    this.orders = const [],
    this.failure,
    this.isLoading = false,
    this.currentPage = 1,
    this.lastPage = 1,
    this.currentStatus,
    this.currentPriority,
    this.currentSearch,
  });

  final List<OrderModel> orders;
  final AppFailure? failure;
  final bool isLoading;

  final int currentPage;
  final int lastPage;

  final String? currentStatus;
  final String? currentPriority;
  final String? currentSearch;

  ShowOrdersState copyWith({
    List<OrderModel>? orders,
    AppFailure? failure,
    bool? isLoading,
    int? currentPage,
    int? lastPage,
    String? currentStatus,
    String? currentPriority,
    String? currentSearch,
    bool clearSearch = false,
  }) {
    return ShowOrdersState(
      orders: orders ?? this.orders,
      failure: failure,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      currentStatus: currentStatus ?? this.currentStatus,
      currentPriority: currentPriority ?? this.currentPriority,
      currentSearch: clearSearch
          ? null
          : currentSearch ?? this.currentSearch,
    );
  }

  @override
  List<Object?> get props => [
        orders,
        failure,
        isLoading,
        currentPage,
        lastPage,
        currentStatus,
        currentPriority,
        currentSearch,
      ];
}