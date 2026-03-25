class AdvertisingInfo {
  final String? advertisingId;
  final bool limitAdTracking;
  final String trackingStatus;

  const AdvertisingInfo({
    required this.advertisingId,
    required this.limitAdTracking,
    required this.trackingStatus,
  });

  const AdvertisingInfo.initial()
      : advertisingId = null,
        limitAdTracking = false,
        trackingStatus = "not_requested";
}
