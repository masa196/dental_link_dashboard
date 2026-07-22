import 'package:equatable/equatable.dart';

abstract class ShowOrderDetailsEvent extends Equatable {
  const ShowOrderDetailsEvent();

  @override
  List<Object?> get props => [];
}

class ShowOrderDetailsRequested extends ShowOrderDetailsEvent {
  const ShowOrderDetailsRequested(this.orderId);

  final int orderId;

  @override
  List<Object?> get props => [orderId];
}