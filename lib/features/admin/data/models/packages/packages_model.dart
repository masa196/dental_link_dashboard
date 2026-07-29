import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'packages_model.g.dart';

@JsonSerializable(createToJson: false)
class PackagesResponse extends Equatable {
 const  PackagesResponse({
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

    factory PackagesResponse.fromJson(Map<String, dynamic> json) => _$PackagesResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class Data extends Equatable {
const   Data({
        required this.data,
        required this.total,
        required this.perPage,
        required this.currentPage,
        required this.lastPage,
    });

    final List<PackageItemModel>? data;
    final int? total;

    @JsonKey(name: 'per_page') 
    final int? perPage;

    @JsonKey(name: 'current_page') 
    final int? currentPage;

    @JsonKey(name: 'last_page') 
    final int? lastPage;

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    @override
    List<Object?> get props => [
    data, total, perPage, currentPage, lastPage, ];
}

@JsonSerializable(createToJson: false)
class PackageItemModel extends Equatable {
   const  PackageItemModel({
        required this.id,
        required this.name,
        required this.description,
        required this.durationDays,
        required this.price,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? name;
    final String? description;

    @JsonKey(name: 'duration_days') 
    final int? durationDays;
    final String? price;

    @JsonKey(name: 'is_active') 
    final bool? isActive;

    @JsonKey(name: 'created_at') 
    final DateTime? createdAt;

    @JsonKey(name: 'updated_at') 
    final DateTime? updatedAt;

    factory PackageItemModel.fromJson(Map<String, dynamic> json) => _$PackageItemModelFromJson(json);

    @override
    List<Object?> get props => [
    id, name, description, durationDays, price, isActive, createdAt, updatedAt, ];
}
