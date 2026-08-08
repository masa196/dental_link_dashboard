// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StripeLinkResponse _$StripeLinkResponseFromJson(Map<String, dynamic> json) =>
    StripeLinkResponse(
      success: json['success'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : StripeLink.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
    );

StripeLink _$StripeLinkFromJson(Map<String, dynamic> json) =>
    StripeLink(success: json['success'] as bool?, url: json['url'] as String?);
