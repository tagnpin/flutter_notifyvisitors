import '../../../sdk/sdk_manager.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_definition.dart';

final List<FeatureActionDefinition> sendPushActions = [
  /// -------------------------
  /// SIMPLE BUTTON ACTION
  /// -------------------------

  FeatureActionDefinition(
    id: 'pushSubscriptionID',
    title: 'Get Push SubscriptionID',
    description: 'returns FCM/APNS Token as NVECTA subscriptionID',
    actionLabel: 'Get Push SubscriptionID',
    showResult: true,
    resultTitle: "Push SubscriptionID:",
    execute: (params) async {
      final pushToken = await SDKManager.getPushToken();
      return pushToken;
    },
  ),
  FeatureActionDefinition(
    id: 'sendStandardPush',
    title: 'Send Standard Push',
    description: 'Sends a text only push notification to this device',
    actionLabel: 'Send Standard Push',
    execute: (params) async {
      SDKManager.sendStandardPush();
      return null;
    },
  ),

  FeatureActionDefinition(
    id: 'sendStdPushWithActionBtns',
    title: 'Send Standard Push with Action Buttons',
    description: 'Sends a text only push notification to this device',
    actionLabel: 'Send Standard Push',
    execute: (params) async {
      SDKManager.sendStdPushWithActionBtns();
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'sendRichPush',
    title: 'Send Rich Push Notification',
    description:
        'Sends a rich push notification with image and action buttons to this device',
    actionLabel: 'Send Rich Push',
    execute: (params) async {
      SDKManager.sendRichPush();
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'sendAndroidGIFPush',
    title: 'Send GIF Push Notification',
    description:
        'Sends a push notification with multiple images which act as a gif to the device',
    actionLabel: 'Send GIF Push Notification',
    supportedPlatform: SupportedPlatform.android,
    execute: (params) async {
      SDKManager.sendAndroidGifPush();
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'sendAndroidSLiderPush',
    title: 'Send Slider Push Notification',
    description:
        'Sends a push notification with multiple images which act as a slider to the device',
    actionLabel: 'Send Slider Push Notification',
    supportedPlatform: SupportedPlatform.android,
    execute: (params) async {
      SDKManager.sendAndroidSliderPush();
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'sendAndroidCrouselPush',
    title: 'Send Crousel Push Notification',
    description:
        'Sends a push notification with multiple images which act as a crousel to the device',
    actionLabel: 'Send Crousel Push Notification',
    supportedPlatform: SupportedPlatform.android,
    execute: (params) async {
      SDKManager.sendAndroidCrouselPush();
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'sendIOSAudioPush',
    title: 'Send Audio Push Notification',
    description: 'Sends an audio push notification to this device',
    actionLabel: 'Send Audio Push',
    supportedPlatform: SupportedPlatform.ios,
    execute: (params) async {
      SDKManager.sendIOSAudioPush();
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'sendIOSVideoPush',
    title: 'Send Video Push Notification',
    description:
        'Sends an video of max 50MB in push notification to this device',
    actionLabel: 'Send Video Push',
    supportedPlatform: SupportedPlatform.ios,
    execute: (params) async {
      SDKManager.sendIOSVideoPush();
      return null;
    },
  ),
];

final List<FeatureActionDefinition> notificationCenterActions = [
  FeatureActionDefinition(
    id: 'showStdNotificationCenter',
    title: 'Show Standard Notification Center',
    description: 'Shows the standard notification center UI',
    actionLabel: 'Show Notification Center',
    execute: (params) async {
      SDKManager.showStandardNotificationCenter();
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'showAdvancedNotificationCenter',
    title: 'Show Advanced Notification Center',
    description: 'Shows the advanced notification center UI',
    actionLabel: 'Show Advanced Notification Center',
    // actionBadgeCount: 5,
    execute: (params) async {
      SDKManager.showAdvancedNotificationCenter();
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'getUnreadCountNotificationCenter',
    title: 'Get Unread Notification Count',
    description:
        'Retrieves the unread notification count in the notification center',
    actionLabel: 'Get Unread notification Count in Center',
    execute: (params) async {
      SDKManager.getUnreadCount();
      return null;
    },
  ),
];
