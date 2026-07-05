import 'package:equatable/equatable.dart';

class UpdateOrderStatusEntity extends Equatable {
  const UpdateOrderStatusEntity({
    required this.orderId,
    required this.status,
    this.notes,
  });

  final int orderId;
  final String status;
  final String? notes;

  @override
  List<Object?> get props => [
        orderId,
        status,
        notes,
      ];
}