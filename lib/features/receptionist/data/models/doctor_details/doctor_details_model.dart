import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_details_model.g.dart';

@JsonSerializable(createToJson: false)
class DoctorDetailsResponse extends Equatable {
  const DoctorDetailsResponse({
        required this.success,
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool? success;
    final int? status;
    final String? message;
    final DoctorInDetails? data;
    final dynamic errors;

    factory DoctorDetailsResponse.fromJson(Map<String, dynamic> json) => _$DoctorDetailsResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class DoctorInDetails extends Equatable {
 const   DoctorInDetails({
        required this.doctorId,
        required this.name,
        required this.email,
        required this.phone,
        required this.profileImage,
        required this.ordersCount,
        required this.totalCost,
        required this.totalPayments,
        required this.totalAmountDue,
        required this.orders,
        required this.pagination,
    });

    @JsonKey(name: 'doctor_id') 
    final int? doctorId;
    final String? name;
    final String? email;
    final String? phone;

    @JsonKey(name: 'profile_image') 
    final dynamic profileImage;

    @JsonKey(name: 'orders_count') 
    final int? ordersCount;

    @JsonKey(name: 'total_cost') 
    final String? totalCost;

    @JsonKey(name: 'total_payments') 
    final String? totalPayments;

    @JsonKey(name: 'total_amount_due') 
    final String? totalAmountDue;
    final List<OrderInDoc>? orders;
    final Pagination? pagination;

    factory DoctorInDetails.fromJson(Map<String, dynamic> json) => _$DoctorInDetailsFromJson(json);

    @override
    List<Object?> get props => [
    doctorId, name, email, phone, profileImage, ordersCount, totalCost, totalPayments, totalAmountDue, orders, pagination, ];
}

@JsonSerializable(createToJson: false)
class OrderInDoc extends Equatable {
  const  OrderInDoc({
        required this.id,
        required this.serialNumber,
        required this.caseType,
        required this.status,
        required this.date,
        required this.cost,
        required this.totalPayments,
        required this.amountDue,
    });

    final int? id;

    @JsonKey(name: 'serial_number') 
    final String? serialNumber;

    @JsonKey(name: 'case_type') 
    final String? caseType;
    final String? status;
    final DateTime? date;
    final String? cost;

    @JsonKey(name: 'total_payments') 
    final String? totalPayments;

    @JsonKey(name: 'amount_due') 
    final String? amountDue;

    factory OrderInDoc.fromJson(Map<String, dynamic> json) => _$OrderInDocFromJson(json);

    @override
    List<Object?> get props => [
    id, serialNumber, caseType, status, date, cost, totalPayments, amountDue, ];
}

@JsonSerializable(createToJson: false)
class Pagination extends Equatable {
  const  Pagination({
        required this.currentPage,
        required this.perPage,
        required this.total,
        required this.lastPage,
        required this.from,
        required this.to,
    });

    @JsonKey(name: 'current_page') 
    final int? currentPage;

    @JsonKey(name: 'per_page') 
    final int? perPage;
    final int? total;

    @JsonKey(name: 'last_page') 
    final int? lastPage;
    final int? from;
    final int? to;

    factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);

    @override
    List<Object?> get props => [
    currentPage, perPage, total, lastPage, from, to, ];
}
