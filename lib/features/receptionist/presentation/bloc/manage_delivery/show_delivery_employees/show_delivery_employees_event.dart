import 'package:equatable/equatable.dart';

class ShowDeliveryEmployeesEvent extends Equatable {
  const ShowDeliveryEmployeesEvent();

  @override
  List<Object?> get props => [];
}

class LoadDeliveryEmployees extends ShowDeliveryEmployeesEvent {
  final int perPage;
  final String search;

  const LoadDeliveryEmployees({
    this.perPage = 10,
    this.search = '',
  });

  @override
  List<Object?> get props => [
        perPage,
        search,
      ];
}