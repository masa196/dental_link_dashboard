import 'package:equatable/equatable.dart';

class ShowDeliveryTasksEntity extends Equatable {
  const ShowDeliveryTasksEntity({
    this.perPage = 10,
    this.page = 1,
    this.search,
  });

  final int perPage;
  final int page;
  final String? search;

  Map<String, dynamic> toQueryParameters() {
    return {
      'per_page': perPage,
      'page': page,
      if (search != null && search!.isNotEmpty) 'search': search,
    };
  }

  @override
  List<Object?> get props => [
        perPage,
        page,
        search,
      ];
}