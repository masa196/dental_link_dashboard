import 'package:equatable/equatable.dart';

abstract class PrintQrEvent extends Equatable {
  const PrintQrEvent();

  @override
  List<Object?> get props => [];
}

class PrintQrRequested extends PrintQrEvent {
  const PrintQrRequested({
    required this.orderId,
    required this.serialNumber,
  });

  final int orderId;
  final String serialNumber;

  @override
  List<Object?> get props => [orderId, serialNumber];
}