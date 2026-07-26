import 'package:equatable/equatable.dart';

class DeviceTokenEntity extends Equatable {
  const DeviceTokenEntity({
    required this.token,
    required this.deviceType,
  });

  final String token;
  final String deviceType;


  @override
  List<Object?> get props => [
    token,
    deviceType,
  ];
}