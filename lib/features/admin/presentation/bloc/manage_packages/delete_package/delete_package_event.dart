import 'package:equatable/equatable.dart';

sealed class DeletePackageEvent extends Equatable {
  const DeletePackageEvent();

  @override
  List<Object?> get props => [];
}

class DeletePackageRequested extends DeletePackageEvent {
  const DeletePackageRequested({
    required this.packageId,
  });

  final int packageId;

  @override
  List<Object?> get props => [packageId];
}