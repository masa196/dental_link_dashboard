import 'package:equatable/equatable.dart';

class LogoutResponseModel extends Equatable {
  const LogoutResponseModel({
    required this.success,
    required this.status,
    required this.message,
    this.errors,
  });

  final bool success;
  final int status;
  final String message;
  final Map<String, dynamic>? errors;

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) {
    final errors = json['errors'] is Map
        ? Map<String, dynamic>.from(json['errors'] as Map)
        : null;

    return LogoutResponseModel(
      success: json['success'] == true,
      status: (json['status'] as num?)?.toInt() ?? 200,
      message: json['message']?.toString() ?? '',
      errors: errors,
    );
  }

  @override
  List<Object?> get props => [success, status, message, errors];
}
