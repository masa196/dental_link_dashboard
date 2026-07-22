import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'show_materials_model.g.dart';

@JsonSerializable(createToJson: false)
class ShowMaterialsResponse extends Equatable {
  const  ShowMaterialsResponse({
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

    factory ShowMaterialsResponse.fromJson(Map<String, dynamic> json) => _$ShowMaterialsResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class Data extends Equatable {
 const  Data({
        required this.data,
        required this.total,
        required this.perPage,
        required this.currentPage,
        required this.lastPage,
    });

    final List<MaterialItem>? data;
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
class MaterialItem extends Equatable {
 const   MaterialItem({
        required this.id,
        required this.labId,
        required this.name,
        required this.description,
        required this.category,
        required this.price,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;

    @JsonKey(name: 'lab_id') 
    final int? labId;
    final String? name;
    final String? description;
    final String? category;
    final String? price;

    @JsonKey(name: 'created_at') 
    final DateTime? createdAt;

    @JsonKey(name: 'updated_at') 
    final DateTime? updatedAt;

    factory MaterialItem.fromJson(Map<String, dynamic> json) => _$MaterialItemFromJson(json);

    @override
    List<Object?> get props => [
    id, labId, name, description, category, price, createdAt, updatedAt, ];
}
