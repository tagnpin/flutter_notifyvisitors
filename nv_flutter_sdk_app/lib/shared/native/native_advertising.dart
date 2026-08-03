import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class NativeAdvertising {
  static const MethodChannel _channel = MethodChannel('native.advertising');

  static Future<Map<String, dynamic>> getAdvertisingInfo() async {
    try {
      final result = await _channel.invokeMapMethod<String, dynamic>(
        'getAdvertisingInfo',
      );

      return result ?? {};
    } catch (_) {
      return {};
    }
  }
}

class NativeAppVersionInfo {
  static const MethodChannel _appVersionchannel =
      MethodChannel('native.appVersionInfo');

  static Future<Map<String, dynamic>> getAppVersionInfo() async {
    debugPrint('NativeAppVersionInfo: getAppVersionInfo called');

    try {
      final result = await _appVersionchannel.invokeMethod(
        'getAppVersionInfo',
      );

      debugPrint('NativeAppVersionInfo: raw result = $result');

      return Map<String, dynamic>.from(result ?? {});
    } catch (e, s) {
      debugPrint('NativeAppVersionInfo ERROR = $e');
      debugPrint('$s');
      rethrow;
    }
  }
}
