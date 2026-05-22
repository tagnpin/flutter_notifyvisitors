import 'dart:io';

import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_definition.dart';

class PlatformUtils {
  static bool isSupported(SupportedPlatform platform) {
    if (platform == SupportedPlatform.all) return true;
    if (platform == SupportedPlatform.ios && Platform.isIOS) return true;
    if (platform == SupportedPlatform.android && Platform.isAndroid) {
      return true;
    } else {
      return false;
    }
  }
}
