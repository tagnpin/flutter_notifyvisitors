import 'package:flutter/services.dart';

class IDFAService {
  static const MethodChannel _channel = MethodChannel('idfa.channel');

  static Future<String> getIDFA() async {
    final String idfa = await _channel.invokeMethod('getIDFA');
    return idfa;
  }
}
