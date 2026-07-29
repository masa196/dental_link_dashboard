import 'package:equatable/equatable.dart';


abstract class ShowDoctorDetailsEvent extends Equatable {

  const ShowDoctorDetailsEvent();


  @override
  List<Object?> get props => [];

}

class ShowDoctorDetailsRequested extends ShowDoctorDetailsEvent {

  const ShowDoctorDetailsRequested({
    required this.doctorId,
    this.status = 'paid',
    this.page = 1,
    this.perPage = 15,

  });


  final int doctorId;
  final String status;
  final int page;
  final int perPage;


  @override
  List<Object?> get props => [
    doctorId,
    status,
    page,
    perPage,

  ];

}

class ShowDoctorOrdersStatusChanged extends ShowDoctorDetailsEvent {

  const ShowDoctorOrdersStatusChanged({

    required this.status,

  });

  final String status;

  @override
  List<Object?> get props => [
    status,
  ];

}

class ShowDoctorDetailsRefresh extends ShowDoctorDetailsEvent {


  const ShowDoctorDetailsRefresh();

}