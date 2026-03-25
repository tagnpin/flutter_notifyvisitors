import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:advertising_id/advertising_id.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:nv_flutter_sdk_app/shared/utils/advertising_info.dart';

final advertisingInfoProvider =
    AsyncNotifierProvider<AdvertisingInfoNotifier, AdvertisingInfo>(
        AdvertisingInfoNotifier.new);

class AdvertisingInfoNotifier extends AsyncNotifier<AdvertisingInfo> {
  @override
  Future<AdvertisingInfo> build() async {
    // DO NOTHING automatically
    // prevents crash at launch
    return const AdvertisingInfo.initial();
  }

  /// Call manually after UI ready
  Future<void> loadAdvertisingInfo() async {
    state = const AsyncLoading();

    try {
      String? advertisingId;
      bool limitAdTracking = false;
      String trackingStatus = "not_applicable";

      if (Platform.isIOS) {
        var status = await AppTrackingTransparency.trackingAuthorizationStatus;

        if (status == TrackingStatus.notDetermined) {
          status = await AppTrackingTransparency.requestTrackingAuthorization();
        }

        trackingStatus = status.name;

        if (status == TrackingStatus.authorized) {
          advertisingId = await AdvertisingId.id(true);
          limitAdTracking =
              await AdvertisingId.isLimitAdTrackingEnabled ?? false;
        }
      } else if (Platform.isAndroid) {
        advertisingId = await AdvertisingId.id(true);
        limitAdTracking = await AdvertisingId.isLimitAdTrackingEnabled ?? false;
      }

      state = AsyncData(
        AdvertisingInfo(
          advertisingId: advertisingId,
          limitAdTracking: limitAdTracking,
          trackingStatus: trackingStatus,
        ),
      );
    } on PlatformException {
      state = const AsyncData(AdvertisingInfo.initial());
    }
  }
}
