import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

enum AppFailureType {
  validation,
  unauthorized,
  rateLimit,
  badRequest,
  server,
  network,
  unexpected,
}

class AppFailure extends Equatable {
  const AppFailure({
    required this.type,
    required this.message,
    this.statusCode,
    this.errors,
    this.retryAfterSeconds,
  });

  final AppFailureType type;
  final String message;
  final int? statusCode;
  final Map<String, List<String>>? errors;
  final int? retryAfterSeconds;

  bool get hasFieldErrors => errors != null && errors!.isNotEmpty;

  @override
  List<Object?> get props => [
    type,
    message,
    statusCode,
    errors,
    retryAfterSeconds,
  ];
}

class AppException implements Exception {
  const AppException({
    required this.message,
    this.statusCode,
    this.errors,
    this.retryAfterSeconds,
    this.rawResponse,
  });

  final String message;
  final int? statusCode;
  final Map<String, List<String>>? errors;
  final int? retryAfterSeconds;
  final Object? rawResponse;

  factory AppException.network([String message = 'Network error']) {
    return AppException(message: message);
  }

  factory AppException.fromDioException(DioException exception) {
    final response = exception.response;
    final payload = AppErrorParser.asMap(response?.data);

    if (payload != null) {
      return AppException.fromResponse(
        payload,
        fallbackStatusCode: response?.statusCode,
        rawResponse: response?.data,
      );
    }

    final message = switch (exception.type) {
      DioExceptionType.connectionTimeout => 'Connection timeout',
      DioExceptionType.sendTimeout => 'Send timeout',
      DioExceptionType.receiveTimeout => 'Receive timeout',
      DioExceptionType.badCertificate => 'Bad certificate',
      DioExceptionType.connectionError => 'No internet connection',
      DioExceptionType.cancel => 'Request cancelled',
      _ => response?.statusMessage ?? 'Request failed',
    };

    return AppException(
      message: message,
      statusCode: response?.statusCode,
      rawResponse: response?.data,
    );
  }

  factory AppException.fromResponse(
    Map<String, dynamic> response, {
    int? fallbackStatusCode,
    Object? rawResponse,
  }) {
    final data = AppErrorParser.asMap(response['data']);
    final errors =
        AppErrorParser.parseErrors(response['errors']) ??
        AppErrorParser.parseErrors(data?['errors']);
    final retryAfterSeconds =
        AppErrorParser.parseRetryAfter(response['data']) ??
        AppErrorParser.parseRetryAfter(data);
    final statusCode =
        (response['status'] as num?)?.toInt() ?? fallbackStatusCode;
    final message = (response['message'] ?? 'Request failed').toString();

    return AppException(
      message: message,
      statusCode: statusCode,
      errors: errors,
      retryAfterSeconds: retryAfterSeconds,
      rawResponse: rawResponse ?? response,
    );
  }

  @override
  String toString() => 'AppException($statusCode): $message';
}

class AppErrorParser {
  static Map<String, dynamic>? asMap(Object? raw) {
    if (raw is Map<String, dynamic>) return raw;
    if (raw is Map) {
      return raw.map((key, value) => MapEntry(key.toString(), value));
    }
    return null;
  }

  static Map<String, List<String>>? parseErrors(Object? raw) {
    final map = asMap(raw);
    if (map == null || map.isEmpty) return null;

    return map.map((key, value) {
      if (value is List) {
        return MapEntry(key, value.map((item) => item.toString()).toList());
      }
      if (value == null) {
        return MapEntry(key, <String>[]);
      }
      return MapEntry(key, <String>[value.toString()]);
    });
  }

  static int? parseRetryAfter(Object? raw) {
    final map = asMap(raw);
    if (map == null) return null;

    final value = map['retry_after_seconds'];
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }
}

class AppErrorMapper {
  static AppFailure map(Object error) {
    if (error is AppException) {
      return _fromException(error);
    }

    if (error is DioException) {
      return _fromException(AppException.fromDioException(error));
    }

    return const AppFailure(
      type: AppFailureType.unexpected,
      message: 'Something went wrong',
    );
  }

  static AppFailure _fromException(AppException exception) {
    final status = exception.statusCode;
    final type = switch (status) {
      400 => AppFailureType.validation,
      401 => AppFailureType.unauthorized,
      422 => AppFailureType.validation,
      429 => AppFailureType.rateLimit,
      null => AppFailureType.unexpected,
      >= 500 => AppFailureType.server,
      _ =>
        exception.errors != null
            ? AppFailureType.validation
            : AppFailureType.unexpected,
    };

    return AppFailure(
      type: type,
      message: exception.message,
      statusCode: status,
      errors: exception.errors,
      retryAfterSeconds: exception.retryAfterSeconds,
    );
  }
}
