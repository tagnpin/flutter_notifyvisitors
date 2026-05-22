import 'dart:async';
import 'dart:io';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_notifyvisitors/PushPromptInfo.dart';
import 'package:flutter_notifyvisitors/flutter_notifyvisitors.dart';
import 'package:nv_flutter_sdk_app/shared/theme/app_colors.dart';

import 'package:intl/intl.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:package_info_plus/package_info_plus.dart';

class SDKManager {
  // static const String sdkVersion = '1.0.0';

  // static final eventAttributes = <String, dynamic>{
  //   'name': bannerSurveyUserToken['name'],
  //   'email': bannerSurveyUserToken['email'],
  //   'user_score': '340',
  //   'plan_type': 3,
  //   'mobileNo': '9900000000',
  // };

  /* ---------------------------------------------------
   *  Device Info
   * --------------------------------------------------- */

  // static Future<Map<String, dynamic>> getDeviceInfo() async {
  //   final deviceInfo = DeviceInfoPlugin();
  //   final packageInfo = await PackageInfo.fromPlatform();

  //   String osVersion = '';
  //   String deviceId = '';

  //   if (Platform.isAndroid) {
  //     final info = await deviceInfo.androidInfo();
  //     osVersion = info.version.release;
  //     deviceId = info.id;
  //   } else if (Platform.isIOS) {
  //     final info = await deviceInfo.iosInfo();
  //     osVersion = info.systemVersion;
  //     deviceId = info.identifierForVendor ?? '';
  //   }

  //   final result = {
  //     'platform': Platform.isAndroid ? 'android' : 'ios',
  //     'osVersion': osVersion,
  //     'deviceId': deviceId,
  //     'appVersion': packageInfo.version,
  //     'buildNumber': packageInfo.buildNumber,
  //     'sdkVersion': sdkVersion,
  //     'environment': kDebugMode ? 'debug' : 'release',
  //   };

  //   _emitCallback('getDeviceInfo', result);
  //   return result;
  // }

  /* ---------------------------------------------------
   *  Date Helper
   * --------------------------------------------------- */

  static String osName = Platform.isAndroid
      ? 'android'
      : Platform.isIOS
          ? 'ios'
          : '';

  static String get currentDateTime {
    final formatter = DateFormat('dd_MM_yyyy_HH_mm_ss');
    return '_${formatter.format(DateTime.now())}';
  }

  static String _hexFromColor(Color color) {
    final a = (color.a * 255).round();
    final r = (color.r * 255).round();
    final g = (color.g * 255).round();
    final b = (color.b * 255).round();

    final hex = ((a << 24) | (r << 16) | (g << 8) | b)
        .toRadixString(16)
        .padLeft(8, '0')
        .toUpperCase();

    return '#${hex.substring(2)}';
  }

  /* ---------------------------------------------------
   *  Push Notification IDs
   * --------------------------------------------------- */

  static const Map<String, Map<String, String>> _nvNotificationIDs = {
    'android': {
      'standardPushNID': '233130',
      'stdPushWithActionNID': '233132',
      'richPushNID': '233133',
      'gifPushNID': '23XXXX',
      'sliderPushNID': '23XXXX',
      'crouselPushNID': '2XXX',
    },
    'ios': {
      'standardPushNID': '152746',
      'stdPushWithActionNID': '143452',
      'richPushNID': '37896',
      'audioPushNID': '40211',
      'videoPushNID': '188595',
    },
  };

  static String _getNotificationId(String type) {
    final platform = Platform.isAndroid ? 'android' : 'ios';
    final id = _nvNotificationIDs[platform]?[type];

    if (id == null) {
      throw Exception('Notification ID not configured for $platform → $type');
    }
    return id;
  }

  static void _schedulePush(String nvId, String seconds) {
    Notifyvisitors.shared
        .scheduleNotification(nvId, '', seconds, '', '', '', '');
  }

  /* ---------------------------------------------------
   *  Push APIs
   * --------------------------------------------------- */

  static Future<void> sendStandardPush() async {
    try {
      _schedulePush(_getNotificationId('standardPushNID'), '2');
    } catch (e) {
      debugPrint('sendStandardPush error: $e');
    }
  }

  static Future<void> sendStdPushWithActionBtns() async {
    try {
      _schedulePush(_getNotificationId('stdPushWithActionNID'), '2');
    } catch (e) {
      debugPrint('sendStdPushWithActionBtns error: $e');
    }
  }

  static Future<void> sendRichPush() async {
    try {
      _schedulePush(_getNotificationId('richPushNID'), '2');
    } catch (e) {
      debugPrint('sendRichPush error: $e');
    }
  }

  static Future<void> sendAndroidGifPush() async {
    if (!Platform.isAndroid) return;
    _schedulePush(_getNotificationId('gifPushNID'), '2');
  }

  static Future<void> sendAndroidSliderPush() async {
    if (!Platform.isAndroid) return;
    _schedulePush(_getNotificationId('sliderPushNID'), '2');
  }

  static Future<void> sendAndroidCrouselPush() async {
    if (!Platform.isAndroid) return;
    _schedulePush(_getNotificationId('crouselPushNID'), '2');
  }

  static Future<void> sendIOSAudioPush() async {
    if (!Platform.isIOS) return;
    _schedulePush(_getNotificationId('audioPushNID'), '2');
  }

  static Future<void> sendIOSVideoPush() async {
    if (!Platform.isIOS) return;
    _schedulePush(_getNotificationId('videoPushNID'), '2');
  }

  static Future<dynamic> getPushToken() async {
    final callback = await Notifyvisitors.shared.getRegistrationToken();
    debugPrint("NVECTA Push SubscriptionID: $callback");
    return callback;
  }

  static Future<dynamic> androidPushPermissionPrompt() async {
    final design = PushPromptInfo()
      ..title = 'Get Notified'
      ..titleTextColor = _hexFromColor(AppColors.lightTextPrimary)
      ..description = 'Enable Push Notifications on Your Device !!'
      ..descriptionTextColor = _hexFromColor(AppColors.lightTextSecondary)
      ..backgroundColor = _hexFromColor(AppColors.lightSurface)
      ..buttonOneBorderColor = _hexFromColor(AppColors.primary)
      ..buttonOneBackgroundColor = _hexFromColor(AppColors.primary)
      ..buttonOneBorderRadius = '16'
      ..buttonOneText = 'Allow'
      ..buttonOneTextColor = _hexFromColor(AppColors.lightSurface)
      ..buttonTwoText = 'Cancel'
      ..buttonTwoTextColor = _hexFromColor(AppColors.lightSurface)
      ..buttonTwoBackgroundColor = _hexFromColor(AppColors.error)
      ..buttonTwoBorderColor = _hexFromColor(AppColors.error)
      ..buttonTwoBorderRadius = '16'
      ..numberOfSessions = '3'
      ..setResumeInDays = '1'
      ..setNumberOfTimesPerSession = '6';

    final completer = Completer<dynamic>();

    Notifyvisitors.shared.pushPermissionPrompt(design, (response) {
      debugPrint('Push Permission Prompt Callback: $response');
      if (!completer.isCompleted) {
        completer.complete(response);
      }
    });

    return completer.future;
  }

  static Future<dynamic> androidCustomNotificationChannel() async {
    if (!Platform.isAndroid) return;

    try {
      await Notifyvisitors.shared.createNotificationChannel(
        'nv_flutter_sdkApp_channel_id_89',
        'nv_flutter_sdk_app custom notifications',
        'Testing channel for NotifyVisitors push notifications in the flutter testing app',
        '5',
        true,
        true,
        '#FFFFFF',
        '',
        '0,500,200,500,200,500',
      );
    } catch (error) {
      debugPrint('createNotificationChannel failed: $error');
    }
  }

  /* ---------------------------------------------------
   *  Notification Center
   * --------------------------------------------------- */

  static const Map<String, dynamic> _nvCenterTabs = {
    'label_one': 'promotion',
    'name_one': 'Promotional',
    'label_two': 'transaction',
    'name_two': 'Transactional',
    'label_three': 'other',
    'name_three': 'Others',
    'selectedTabIndex_ios': '0',
  };

  static Future<void> showStandardNotificationCenter() async {
    Notifyvisitors.shared.showNotifications(null, 0);
  }

  static Future<void> showAdvancedNotificationCenter() async {
    Notifyvisitors.shared.openNotificationCenter(_nvCenterTabs, 0, (callback) {
      debugPrint("Notification Center Callback: $callback");
    });
  }

  static Future<dynamic> getUnreadCount() async {
    dynamic result;
    await Notifyvisitors.shared
        .getNotificationCenterCount(_nvCenterTabs)
        .then((callback) {
      debugPrint("Notification Center Unread Count Callback: $callback");
      result = callback;
    });
    return result;
  }

  /* ---------------------------------------------------
   *  In-App Messages
   * --------------------------------------------------- */

  static Future<dynamic> showInAppMessage(String bannerType) async {
    final userToken = {
      'name': 'Customer Name',
      'email': 'customer_$currentDateTime@notifyvisitors.com',
      'department': 'development',
      'age': 34,
      'married': true,
    };

    final customRules = {
      'banner': bannerType,
      'screenname': 'FeatureActions',
      'currentDate': currentDateTime,
    };

    Notifyvisitors.shared.showInAppMessage(userToken, customRules, '',
        (callback) {
      debugPrint("In-App Message Callback: $callback");
    });
  }

  /* ---------------------------------------------------
   *  Analytics
   * --------------------------------------------------- */

  static Future<dynamic> trackEvent({
    required String eventName,
    Map<String, dynamic>? attributes,
    String ltv = '',
    String scope = '',
  }) async {
    if (eventName.trim().isEmpty) return null;
    final completer = Completer<String?>();

    unawaited(Notifyvisitors.shared.event(eventName, attributes, ltv, scope,
        (callback) {
      debugPrint("Track Event Callback: $callback");
      if (!completer.isCompleted) {
        completer.complete(callback);
      }
    }).catchError((Object error, StackTrace stackTrace) {
      if (!completer.isCompleted) {
        completer.completeError(error, stackTrace);
      }
    }));

    final callback = await completer.future;
    return callback;
  }

  static Future<void> trackScreen(String screenName) async {
    if (screenName.trim().isEmpty) return;
    Notifyvisitors.shared.trackScreen(screenName);
  }

  /* ---------------------------------------------------
   *  User Properties
   * --------------------------------------------------- */

  static Future<dynamic> setUserDetails(Map<String, dynamic> data) async {
    Notifyvisitors.shared.setUserIdentifier(data).then((callback) {
      debugPrint("Set User Details Callback: $callback");
    });
  }

  static Future<dynamic> getNVUID() async {
    final callback = await Notifyvisitors.shared.getNvUID();
    debugPrint("Get NVUID Callback: $callback");
    return callback;
  }

  /* ---------------------------------------------------
   *  Callback & Listeners
   * --------------------------------------------------- */

  static Future<dynamic> getLinkInfo() async {
    dynamic result;
    await Notifyvisitors.shared.getLinkInfo((callback) {
      debugPrint("Get Link Info Callback: $callback");
      result = callback;
    });
    return result;
  }

  static Future<dynamic> knownUserIdentified() async {
    dynamic result;
    await Notifyvisitors.shared.knownUserIdentified((callback) {
      debugPrint("Known User Identified Callback: $callback");
      result = callback;
    });
    return result;
  }

  static Future<dynamic> notificationClickCallback() async {
    dynamic result;
    await Notifyvisitors.shared.notificationClickCallback((callback) {
      debugPrint("Notification Click Callback: $callback");
      result = callback;
    });
    return result;
  }
}

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_notifyvisitors/flutter_notifyvisitors.dart';
// import 'package:nv_flutter_sdk_app/shared/utils/push_type.dart';

// class SDKManager {
//   static const Map<AndroidPushType, String> _androidPushIds = {
//     AndroidPushType.standard: '233130',
//     AndroidPushType.standardWithAction: '233132',
//     AndroidPushType.rich: '233133',
//     AndroidPushType.gif: '23XXXX',
//     AndroidPushType.slider: '23XXXX',
//     AndroidPushType.carousel: '2XXX',
//   };

//   static const Map<IOSPushType, String> _iosPushIds = {
//     IOSPushType.standard: '152746',
//     IOSPushType.standardWithAction: '143452',
//     IOSPushType.rich: '37896',
//     IOSPushType.audio: '40211',
//     IOSPushType.video: '188595',
//   };

//   // static String _getNotificationId(Enum type) {
//   //   if (Platform.isAndroid && type is AndroidPushType) {
//   //     final id = _androidPushIds[type];
//   //     if (id == null) {
//   //       throw Exception('Android push ID not configured for $type');
//   //     }
//   //     return id;
//   //   }

//   //   if (Platform.isIOS && type is IOSPushType) {
//   //     final id = _iosPushIds[type];
//   //     if (id == null) {
//   //       throw Exception('iOS push ID not configured for $type');
//   //     }
//   //     return id;
//   //   }

//   //   throw Exception(
//   //     'Invalid push type $type for platform ${Platform.operatingSystem}',
//   //   );
//   // }

//   Future<void> sendNVPushNotificationForType() async {
//     // final notificationId = _getNotificationId(type);
//     debugPrint('sendPushNotification');

//     // Call native SDK / API here
//   }

//   Future<void> nvShowInAppMessages(dynamic bannerType) async {
//     debugPrint('nvShowInAppMessages for bannerType $bannerType');
//   }

//   Future<void> trackEvent(dynamic payload) async {
//     debugPrint('trackEvent called');
//   }

//   Future<void> trackScreen(dynamic payload) async {
//     debugPrint('trackScreen called');
//   }

//   Future<void> setUserDetails(dynamic payload) async {
//     debugPrint('setUserDetails called');
//   }

//   Future<void> getNVUID() async {
//     debugPrint('getNVUID called');
//   }
// }
