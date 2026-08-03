import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nv_flutter_sdk_app/sdk/models/sdk_metadata.dart';
import 'package:nv_flutter_sdk_app/sdk/sdk_manager.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:package_info_plus/package_info_plus.dart';

// import '../../sdk/models/device_info_model.dart';

final sdkMetadataProvider = FutureProvider<SDKMetadata>((ref) async {
  // final brandId = await SDKManager.getBrandId();
  final deviceInfo = await SDKManager.getDeviceInfo();

  return SDKMetadata(
    sdkVersion: deviceInfo.sdkVersion,
    brandId: '--',
  );
});
