import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:dental_link_dashboard/features/lab_manager/data/models/stripe_link/stripe_link_model.dart';
import 'package:equatable/equatable.dart';

class StripeLinkState extends Equatable {
  const StripeLinkState({
    this.response,
    this.failure,
    this.isLoading = false,
  });

  final StripeLinkResponse? response;
  final AppFailure? failure;
  final bool isLoading;

  StripeLinkState copyWith({
    StripeLinkResponse? response,
    AppFailure? failure,
    bool? isLoading,
    bool clearFailure = false,
  }) {
    return StripeLinkState(
      response: response ?? this.response,
      failure: clearFailure ? null : failure ?? this.failure,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        response,
        failure,
        isLoading,
      ];
}