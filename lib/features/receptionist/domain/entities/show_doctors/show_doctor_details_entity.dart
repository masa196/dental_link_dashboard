import 'package:equatable/equatable.dart';

class ShowDoctorDetailsEntity extends Equatable {
  const ShowDoctorDetailsEntity({
    required this.doctorId,
    this.status,
    this.perPage = 15,
    this.page = 1,
  });

  final int doctorId;

  final String? status;

  final int perPage;

  final int page;


  Map<String, dynamic> toQueryParameters() {
    return {
      'per_page': perPage,
      'page': page,
      if (status != null && status!.isNotEmpty)
        'status': status,
    };
  }


  @override
  List<Object?> get props => [
        doctorId,
        status,
        perPage,
        page,
      ];
}