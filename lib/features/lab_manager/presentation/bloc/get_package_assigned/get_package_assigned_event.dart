import 'package:equatable/equatable.dart';

sealed class GetPackageAssignedEvent extends Equatable {
  const GetPackageAssignedEvent();

  @override
  List<Object?> get props => [];
}

final class GetPackageAssignedRequested
    extends GetPackageAssignedEvent {
  const GetPackageAssignedRequested();
}