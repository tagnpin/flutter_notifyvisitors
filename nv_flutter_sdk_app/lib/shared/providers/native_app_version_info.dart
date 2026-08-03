import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nv_flutter_sdk_app/shared/native/native_advertising.dart';

final nativeAppVersionInfoProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  debugPrint('nativeAppVersionInfoProvider START');

  final result = await NativeAppVersionInfo.getAppVersionInfo();

  debugPrint('nativeAppVersionInfoProvider RESULT = $result');

  return result;
});

// final nativeAppVersionInfoProvider =
//     AsyncNotifierProvider<NativeAppVersionInfoNotifier, Map<String, dynamic>>(
//         NativeAppVersionInfoNotifier.new);

// class NativeAppVersionInfoNotifier extends AsyncNotifier<Map<String, dynamic>> {
//   @override
//   Future<Map<String, dynamic>> build() async {
//     // DO NOTHING automatically
//     // prevents crash at launch
//     return const {};
//   }

//   Future<void> loadAppVersionInfo() async {
//     debugPrint('loadAppVersionInfo START');

//     state = const AsyncLoading();

//     try {
//       final data = await NativeAppVersionInfo.getAppVersionInfo();

//       debugPrint('loadAppVersionInfo DATA = $data');

//       state = AsyncData(data);
//     } catch (e) {
//       debugPrint('loadAppVersionInfo ERROR = $e');

//       state = const AsyncData({});
//     }
//   }
// }
