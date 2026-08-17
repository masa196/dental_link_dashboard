import 'package:equatable/equatable.dart';

class ShowPackageHistorySysAdminEntity extends Equatable {
  const ShowPackageHistorySysAdminEntity({
    this.perPage = 15,
    this.page = 1,
    required this.labId,
  });

  final int perPage;
  final int page;
  final int labId;


  Map<String, dynamic> toQueryParameters() {
    return {
      'per_page': perPage,
      'page': page,
    };
  }

  @override
  List<Object?> get props => [
        perPage,
        page,
        labId,
      ];
}