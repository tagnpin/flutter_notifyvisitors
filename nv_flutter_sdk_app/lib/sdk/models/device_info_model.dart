class DeviceInfoModel {
  final String appVersion;
  final String buildNumber;

  final String environment;

  final String sdkVersion;
  final String brandId;

  final String platform;
  final String osVersion;

  /// Android ID / IDFV
  final String deviceId;

  final String pushToken;

  final String? advertisingId;
  final String? trackingStatus;

  const DeviceInfoModel({
    required this.appVersion,
    required this.buildNumber,
    required this.environment,
    required this.sdkVersion,
    required this.brandId,
    required this.platform,
    required this.osVersion,
    required this.deviceId,
    required this.pushToken,
    this.advertisingId,
    this.trackingStatus,
  });
}
