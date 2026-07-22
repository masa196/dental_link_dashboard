import 'package:dental_link_dashboard/core/error/app_error.dart';
import 'package:equatable/equatable.dart';

class AddMaterialsState extends Equatable {
  const AddMaterialsState({
    this.isLoading = false,
    this.success = false,
    this.failure,
  });

  final bool isLoading;
  final bool success;
  final AppFailure? failure;

  AddMaterialsState copyWith({
    bool? isLoading,
    bool? success,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return AddMaterialsState(
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    success,
    failure,
  ];
}