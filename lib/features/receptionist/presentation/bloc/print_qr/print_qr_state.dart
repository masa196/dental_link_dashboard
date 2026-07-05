import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:dental_link_dashboard/core/error/app_error.dart';

enum PrintQrStatus { initial, loading, success, failure }

class PrintQrState extends Equatable {
  const PrintQrState({
    this.status = PrintQrStatus.initial,
    this.image,
    this.failure,
    this.serialNumber,
  });

  final PrintQrStatus status;
  final Uint8List? image;
  final AppFailure? failure;
  final String? serialNumber;

  PrintQrState copyWith({
    PrintQrStatus? status,
    Uint8List? image,
    AppFailure? failure,
    String? serialNumber,
  }) {
    return PrintQrState(
      status: status ?? this.status,
      image: image ?? this.image,
      failure: failure,
      serialNumber: serialNumber ?? this.serialNumber,
    );
  }

  @override
  List<Object?> get props => [
        status,
        image,
        failure,
        serialNumber,
      ];
}