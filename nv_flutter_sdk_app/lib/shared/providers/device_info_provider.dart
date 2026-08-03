import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nv_flutter_sdk_app/sdk/sdk_version.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../sdk/models/device_info_model.dart';

final deviceInfoProvider = FutureProvider<DeviceInfoModel>((ref) async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  final packageInfo = await PackageInfo.fromPlatform();

  String platform = Platform.isIOS ? 'iOS' : 'Android';
  String osVersion = '';
  String deviceId = '';

  if (Platform.isIOS) {
    final iosInfo = await deviceInfoPlugin.iosInfo;

    osVersion = iosInfo.systemVersion;
    deviceId = iosInfo.identifierForVendor ?? '';
  } else {
    final androidInfo = await deviceInfoPlugin.androidInfo;

    osVersion = androidInfo.version.release;
    deviceId = androidInfo.id;
  }

  return DeviceInfoModel(
    appVersion: packageInfo.version,
    buildNumber: packageInfo.buildNumber,

    environment: kReleaseMode ? 'release' : 'debug',

    // Temporary values
    sdkVersion: sdkVersion,
    brandId: '--',

    platform: platform,
    osVersion: osVersion,
    deviceId: deviceId,

    pushToken: '--',

    advertisingId: null,
    trackingStatus: null,
  );
});
