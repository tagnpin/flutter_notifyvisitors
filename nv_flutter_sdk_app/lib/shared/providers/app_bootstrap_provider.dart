import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nv_flutter_sdk_app/shared/providers/app_mode_provider.dart';
import 'package:nv_flutter_sdk_app/shared/providers/environment_provider.dart';
import 'package:nv_flutter_sdk_app/shared/providers/sdk_callbacks_provider.dart';

final appBootstrapProvider = FutureProvider<void>((ref) async {
  // 1️⃣ Load environment
  await ref.read(environmentProvider.future);

  // 2️⃣ Load app mode / flags
  await ref.read(appModeProvider.future);

  // 🔹 Register SDK callbacks ONCE
  ref.read(sdkCallbacksProvider);
  debugPrint("SDK Callbacks registered from appBootstrapProvider");
  // 3️⃣ Future: analytics, remote config
});
