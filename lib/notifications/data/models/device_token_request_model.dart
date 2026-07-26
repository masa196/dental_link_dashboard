class DeviceTokenRequestModel {
  final String token;
  final String deviceType;

  const DeviceTokenRequestModel({
    required this.token,
    required this.deviceType,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'device_type': deviceType,
    };
  }
}