import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_doctors_model.g.dart';

@JsonSerializable(createToJson: false)
class AllDoctorsResponse extends Equatable {
    const AllDoctorsResponse({
        required this.success,
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool? success;
    final int? status;
    final String? message;
    final Data? data;
    final dynamic errors;

    factory AllDoctorsResponse.fromJson(Map<String, dynamic> json) => _$AllDoctorsResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class Data extends Equatable {
    const Data({
        required this.doctors,
        required this.totals,
        required this.pagination,
    });

    final List<DoctorModel>? doctors;
    final Totals? totals;
    final Pagination? pagination;

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    @override
    List<Object?> get props => [
    doctors, totals, pagination, ];
}

@JsonSerializable(createToJson: false)
class DoctorModel extends Equatable {
    const DoctorModel({
        required this.doctorId,
        required this.name,
        required this.email,
        required this.phone,
        required this.ordersCount,
        required this.totalBilled,
        required this.totalPaid,
        required this.totalOwed,
    });

    @JsonKey(name: 'doctor_id') 
    final int? doctorId;
    final String? name;
    final String? email;
    final String? phone;

    @JsonKey(name: 'orders_count') 
    final int? ordersCount;

    @JsonKey(name: 'total_billed') 
    final int? totalBilled;

    @JsonKey(name: 'total_paid') 
    final int? totalPaid;

    @JsonKey(name: 'total_owed') 
    final int? totalOwed;

    factory DoctorModel.fromJson(Map<String, dynamic> json) => _$DoctorModelFromJson(json);

    @override
    List<Object?> get props => [
    doctorId, name, email, phone, ordersCount, totalBilled, totalPaid, totalOwed, ];
}

@JsonSerializable(createToJson: false)
class Pagination extends Equatable {
    const Pagination({
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

@JsonSerializable(createToJson: false)
class Totals extends Equatable {
    const Totals({
        required this.repaymentPercentage,
        required this.totalBilled,
        required this.totalPaid,
        required this.totalOwed,
    });

    @JsonKey(name: 'repayment_percentage') 
    final double? repaymentPercentage;

    @JsonKey(name: 'total_billed') 
    final int? totalBilled;

    @JsonKey(name: 'total_paid') 
    final int? totalPaid;

    @JsonKey(name: 'total_owed') 
    final int? totalOwed;

    factory Totals.fromJson(Map<String, dynamic> json) => _$TotalsFromJson(json);

    @override
    List<Object?> get props => [
    repaymentPercentage, totalBilled, totalPaid, totalOwed, ];
}
