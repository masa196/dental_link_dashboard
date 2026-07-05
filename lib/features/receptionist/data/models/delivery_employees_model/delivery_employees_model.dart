import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_employees_model.g.dart';

@JsonSerializable(createToJson: false)
class DeliveryEmployeesResponse extends Equatable {
   const DeliveryEmployeesResponse({
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

    factory DeliveryEmployeesResponse.fromJson(Map<String, dynamic> json) => _$DeliveryEmployeesResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class Data extends Equatable {
    const Data({
        required this.data,
        required this.links,
        required this.meta,
    });

    final List<DeliveryEmplyee>? data;
    final Links? links;
    final Meta? meta;

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    @override
    List<Object?> get props => [
    data, links, meta, ];
}

@JsonSerializable(createToJson: false)
class DeliveryEmplyee extends Equatable {
    const DeliveryEmplyee({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
    });

    final int? id;
    final String? name;
    final String? email;
    final String? phone;

    factory DeliveryEmplyee.fromJson(Map<String, dynamic> json) => _$DeliveryEmplyeeFromJson(json);

    @override
    List<Object?> get props => [
    id, name, email, phone, ];
}

@JsonSerializable(createToJson: false)
class Links extends Equatable {
    const Links({
        required this.first,
        required this.last,
        required this.prev,
        required this.next,
    });

    final String? first;
    final String? last;
    final dynamic prev;
    final dynamic next;

    factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

    @override
    List<Object?> get props => [
    first, last, prev, next, ];
}

@JsonSerializable(createToJson: false)
class Meta extends Equatable {
  const  Meta({
        required this.currentPage,
        required this.from,
        required this.lastPage,
        required this.links,
        required this.path,
        required this.perPage,
        required this.to,
        required this.total,
    });

    @JsonKey(name: 'current_page') 
    final int? currentPage;
    final int? from;

    @JsonKey(name: 'last_page') 
    final int? lastPage;
    final List<Link>? links;
    final String? path;

    @JsonKey(name: 'per_page') 
    final int? perPage;
    final int? to;
    final int? total;

    factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

    @override
    List<Object?> get props => [
    currentPage, from, lastPage, links, path, perPage, to, total, ];
}

@JsonSerializable(createToJson: false)
class Link extends Equatable {
    const Link({
        required this.url,
        required this.label,
        required this.page,
        required this.active,
    });

    final String? url;
    final String? label;
    final int? page;
    final bool? active;

    factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

    @override
    List<Object?> get props => [
    url, label, page, active, ];
}
