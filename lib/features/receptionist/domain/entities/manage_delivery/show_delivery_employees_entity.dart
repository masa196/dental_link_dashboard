import 'package:equatable/equatable.dart';

class ShowDeliveryEmployeesEntity extends Equatable {
  final int perPage;
  final String search;

  const ShowDeliveryEmployeesEntity({
    this.perPage = 10,
    this.search = '',
  });

  @override
  List<Object?> get props => [
        perPage,
        search,
      ];
}