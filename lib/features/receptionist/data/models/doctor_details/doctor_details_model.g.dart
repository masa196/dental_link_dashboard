// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorDetailsResponse _$DoctorDetailsResponseFromJson(
  Map<String, dynamic> json,
) => DoctorDetailsResponse(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : DoctorInDetails.fromJson(json['data'] as Map<String, dynamic>),
  errors: json['errors'],
);

DoctorInDetails _$DoctorInDetailsFromJson(Map<String, dynamic> json) =>
    DoctorInDetails(
      doctorId: (json['doctor_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profileImage: json['profile_image'],
      ordersCount: (json['orders_count'] as num?)?.toInt(),
      totalCost: json['total_cost'] as String?,
      totalPayments: json['total_payments'] as String?,
      totalAmountDue: json['total_amount_due'] as String?,
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => OrderInDoc.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

OrderInDoc _$OrderInDocFromJson(Map<String, dynamic> json) => OrderInDoc(
  id: (json['id'] as num?)?.toInt(),
  serialNumber: json['serial_number'] as String?,
  caseType: json['case_type'] as String?,
  status: json['status'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  cost: json['cost'] as String?,
  totalPayments: json['total_payments'] as String?,
  amountDue: json['amount_due'] as String?,
);

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  currentPage: (json['current_page'] as num?)?.toInt(),
  perPage: (json['per_page'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
  lastPage: (json['last_page'] as num?)?.toInt(),
  from: (json['from'] as num?)?.toInt(),
  to: (json['to'] as num?)?.toInt(),
);
