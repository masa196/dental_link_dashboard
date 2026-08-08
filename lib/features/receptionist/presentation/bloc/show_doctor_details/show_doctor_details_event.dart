import 'package:equatable/equatable.dart';

abstract class ShowDoctorDetailsEvent extends Equatable {
  const ShowDoctorDetailsEvent();

  @override
  List<Object?> get props => [];
}

class ShowDoctorDetailsRequested extends ShowDoctorDetailsEvent {
  const ShowDoctorDetailsRequested({
    required this.doctorId,
    this.paymentStatus = 'paid',
    this.page = 1,
    this.perPage = 15,
  });

  final int doctorId;
  final String paymentStatus;
  final int page;
  final int perPage;

  @override
  List<Object?> get props => [
        doctorId,
        paymentStatus,
        page,
        perPage,
      ];
}

class ShowDoctorPaymentFilterChanged extends ShowDoctorDetailsEvent {
  const ShowDoctorPaymentFilterChanged({
    required this.paymentStatus,
  });

  final String paymentStatus;

  @override
  List<Object?> get props => [
        paymentStatus,
      ];
}

class ShowDoctorDetailsRefresh extends ShowDoctorDetailsEvent {
  const ShowDoctorDetailsRefresh();
}

class ShowDoctorOrdersPageChanged extends ShowDoctorDetailsEvent {
  const ShowDoctorOrdersPageChanged({
    required this.page,
  });

  final int page;

  @override
  List<Object?> get props => [
        page,
      ];
}