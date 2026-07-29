import 'package:equatable/equatable.dart';

class ShowPackagesEntity extends Equatable {
  const ShowPackagesEntity({
    this.perPage = 15,
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
      if (search != null && search!.isNotEmpty) 'q': search,
    };
  }

  @override
  List<Object?> get props => [
        perPage,
        page,
        search,
      ];
}