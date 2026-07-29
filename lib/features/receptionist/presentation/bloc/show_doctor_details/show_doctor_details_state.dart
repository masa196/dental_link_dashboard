import 'package:equatable/equatable.dart';

import 'package:dental_link_dashboard/core/error/app_error.dart';

import 'package:dental_link_dashboard/features/receptionist/data/models/doctor_details/doctor_details_model.dart';



class ShowDoctorDetailsState extends Equatable {


  const ShowDoctorDetailsState({

    this.doctorInfo,

    this.orders = const [],

    this.pagination,

    this.failure,

    this.isLoadingDoctor = false,

    this.isLoadingOrders = false,

    this.doctorId,

    this.currentStatus = 'paid',

    this.currentPage = 1,

    this.lastPage = 1,

  });



  final DoctorInDetails? doctorInfo;


  final List<OrderInDoc> orders;


  final Pagination? pagination;


  final AppFailure? failure;


  final bool isLoadingDoctor;


  final bool isLoadingOrders;


  final int? doctorId;


  final String currentStatus;


  final int currentPage;


  final int lastPage;



  ShowDoctorDetailsState copyWith({

    DoctorInDetails? doctorInfo,

    List<OrderInDoc>? orders,

    Pagination? pagination,

    AppFailure? failure,

    bool? isLoadingDoctor,

    bool? isLoadingOrders,

    int? doctorId,

    String? currentStatus,

    int? currentPage,

    int? lastPage,

  }) {


    return ShowDoctorDetailsState(

      doctorInfo: doctorInfo ?? this.doctorInfo,

      orders: orders ?? this.orders,

      pagination: pagination ?? this.pagination,

      failure: failure,

      isLoadingDoctor:
          isLoadingDoctor ?? this.isLoadingDoctor,

      isLoadingOrders:
          isLoadingOrders ?? this.isLoadingOrders,

      doctorId:
          doctorId ?? this.doctorId,

      currentStatus:
          currentStatus ?? this.currentStatus,

      currentPage:
          currentPage ?? this.currentPage,

      lastPage:
          lastPage ?? this.lastPage,

    );

  }



  @override
  List<Object?> get props => [

    doctorInfo,

    orders,

    pagination,

    failure,

    isLoadingDoctor,

    isLoadingOrders,

    doctorId,

    currentStatus,

    currentPage,

    lastPage,

  ];

}