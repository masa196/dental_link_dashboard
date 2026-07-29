// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_doctors_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllDoctorsResponse _$AllDoctorsResponseFromJson(Map<String, dynamic> json) =>
    AllDoctorsResponse(
      success: json['success'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  doctors: (json['doctors'] as List<dynamic>?)
      ?.map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totals: json['totals'] == null
      ? null
      : Totals.fromJson(json['totals'] as Map<String, dynamic>),
  pagination: json['pagination'] == null
      ? null
      : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
  doctorId: (json['doctor_id'] as num?)?.toInt(),
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  ordersCount: (json['orders_count'] as num?)?.toInt(),
  totalBilled: (json['total_billed'] as num?)?.toInt(),
  totalPaid: (json['total_paid'] as num?)?.toInt(),
  totalOwed: (json['total_owed'] as num?)?.toInt(),
);

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  currentPage: (json['current_page'] as num?)?.toInt(),
  perPage: (json['per_page'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
  lastPage: (json['last_page'] as num?)?.toInt(),
  from: (json['from'] as num?)?.toInt(),
  to: (json['to'] as num?)?.toInt(),
);

Totals _$TotalsFromJson(Map<String, dynamic> json) => Totals(
  repaymentPercentage: (json['repayment_percentage'] as num?)?.toDouble(),
  totalBilled: (json['total_billed'] as num?)?.toInt(),
  totalPaid: (json['total_paid'] as num?)?.toInt(),
  totalOwed: (json['total_owed'] as num?)?.toInt(),
);
