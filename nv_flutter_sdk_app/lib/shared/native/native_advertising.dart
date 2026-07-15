import 'dart:io';
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
