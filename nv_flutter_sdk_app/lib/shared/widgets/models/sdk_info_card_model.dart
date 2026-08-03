class SDKInfoCardModel {
  final String appVersion;
  final String buildNumber;
  final String environment;

  final String sdkVersion;
  final String brandId;

  final String platform;
  final String osVersion;
  final String deviceId;

  final String advertisingId;
  final String trackingStatus;

  final String pushToken;

  const SDKInfoCardModel({
    required this.appVersion,
    required this.buildNumber,
    required this.environment,
    required this.sdkVersion,
    required this.brandId,
    required this.platform,
    required this.osVersion,
    required this.deviceId,
    required this.advertisingId,
    required this.trackingStatus,
    required this.pushToken,
  });
}
