import 'package:flutter/services.dart';

class NativeSDKConfig {
  static const MethodChannel _channel = MethodChannel('nvecta/sdk_config');

  static Future<String> getBrandId() async {
    try {
      final String? brandId = await _channel.invokeMethod('getBrandId');

      return brandId ?? '--';
    } catch (_) {
      return '--';
    }
  }
}
