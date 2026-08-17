import 'package:equatable/equatable.dart';

class SystemLogsEntity extends Equatable {
  const SystemLogsEntity({
    this.perPage = 15,
    this.page = 1,
   
  });

  final int perPage;
  final int page;



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

      ];
}