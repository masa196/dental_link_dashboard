import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stripe_link_model.g.dart';

@JsonSerializable(createToJson: false)
class StripeLinkResponse extends Equatable {
    const StripeLinkResponse({
        required this.success,
        required this.status,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool? success;
    final int? status;
    final String? message;
    final StripeLink? data;
    final dynamic errors;

    factory StripeLinkResponse.fromJson(Map<String, dynamic> json) => _$StripeLinkResponseFromJson(json);

    @override
    List<Object?> get props => [
    success, status, message, data, errors, ];
}

@JsonSerializable(createToJson: false)
class StripeLink extends Equatable {
 const    StripeLink({
        required this.success,
        required this.url,
    });

    final bool? success;
    final String? url;

    factory StripeLink.fromJson(Map<String, dynamic> json) => _$StripeLinkFromJson(json);

    @override
    List<Object?> get props => [
    success, url, ];
}
