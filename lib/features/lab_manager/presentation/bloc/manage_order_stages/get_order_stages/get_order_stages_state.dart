import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/order_stages/order_stages_model.dart';

class GetOrderStagesState extends Equatable {
  const GetOrderStagesState({
    this.isLoading = false,
    this.response,
    this.failure,
  });

  final bool isLoading;
  final OrderStagesResponse? response;
  final AppFailure? failure;

  GetOrderStagesState copyWith({
    bool? isLoading,
    OrderStagesResponse? response,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return GetOrderStagesState(
      isLoading: isLoading ?? this.isLoading,
      response: response ?? this.response,
      failure: clearFailure
          ? null
          : failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        response,
        failure,
      ];
}