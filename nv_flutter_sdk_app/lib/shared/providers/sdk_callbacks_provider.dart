import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nv_flutter_sdk_app/sdk/sdk_manager.dart';

import 'notification_badge_provider.dart';

final sdkCallbacksProvider = Provider<void>((ref) {
  debugPrint('sdkCallbacksProvider initialized !!!');
  // 🔔 Notification center count
  SDKManager.getUnreadCount().then((value) {
    final data = jsonDecode(value) as Map<String, dynamic>;
    debugPrint('sdkCallbacksProvider Notification Center Count data: $data');
    final count = data['totalCount'] ?? 0;
    ref.read(notificationBadgeProvider.notifier).update(count);
  });
  // 🔗 Deep link / CTA

  SDKManager.getLinkInfo().then((value) {
    final data = jsonDecode(value) as Map<String, dynamic>;
    debugPrint('sdkCallbacksProvider Deep Link / CTA data: $data');
    // 🔥 IMPORTANT
    // Do NOT navigate here directly
    // Just store intent / signal
    // Navigation handled elsewhere
  });
  // Notifyvisitors.shared.getLinkInfo((response) {
  //   final json = jsonDecode(response);

  //   // 🔥 IMPORTANT
  //   // Do NOT navigate here directly
  //   // Just store intent / signal
  //   // Navigation handled elsewhere
  // });

  // 🧠 Known user
  SDKManager.knownUserIdentified().then((value) {
    final data = jsonDecode(value) as Map<String, dynamic>;
    debugPrint('sdkCallbacksProvider Known User Identified data: $data');
    // logging / analytics safe here
  });

  // Notifyvisitors.shared.knownUserIdentified((response) {
  //   // logging / analytics safe here
  // });

  // 🔔 Notification click

  SDKManager.notificationClickCallback().then((value) {
    final data = jsonDecode(value) as Map<String, dynamic>;
    debugPrint('sdkCallbacksProvider Notification Click Callback data: $data');
    // 🔥 IMPORTANT
    // Do NOT navigate here directly
    // Just store intent / signal
    // Navigation handled elsewhere
  });
});
