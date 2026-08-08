import 'package:equatable/equatable.dart';

class ShowDoctorDetailsEntity extends Equatable {

  const ShowDoctorDetailsEntity({
    required this.doctorId,
    this.paymentStatus,
    this.perPage = 15,
    this.page = 1,
  });


  final int doctorId;

  final String? paymentStatus;

  final int perPage;

  final int page;


  Map<String, dynamic> toQueryParameters() {
    return {
      'per_page': perPage,
      'page': page,
      if(paymentStatus != null && paymentStatus!.isNotEmpty)
        'status': paymentStatus,
    };
  }


  @override
  List<Object?> get props => [
    doctorId,
    paymentStatus,
    perPage,
    page,
  ];
}