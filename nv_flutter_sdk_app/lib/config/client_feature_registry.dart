import 'package:nv_flutter_sdk_app/client/features/analytics/analytics_actions.dart';
import 'package:nv_flutter_sdk_app/client/features/in_app_messages/inpp_message_actions.dart';
import 'package:nv_flutter_sdk_app/client/features/in_app_nudges/inapp_nudges_actions.dart';
import 'package:nv_flutter_sdk_app/client/features/push/push_actions.dart';
import 'package:nv_flutter_sdk_app/shared/utils/platform_utils.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_definition.dart';

/// ------------------------------
/// Top-level Client Features
/// ------------------------------
enum ClientFeature {
  analytics,
  push,
  inAppMessages,
  inAppNudges,
}

enum FeatureSection {
  pushActions,
  notificationCenter,
  inappMessageActions,
  inappNudgeActions,
  analyticsTrackEvents,
  analyticsUserProperties,
}

class ClientFeatureRegistry {
  ClientFeatureRegistry._();

  static List<FeatureActionDefinition> getActions(
    FeatureSection section,
  ) {
    final actions = switch (section) {
      FeatureSection.pushActions => sendPushActions,
      FeatureSection.notificationCenter => notificationCenterActions,
      FeatureSection.inappMessageActions => inAppMessageActions,
      FeatureSection.inappNudgeActions => inAppNudgesActions,
      FeatureSection.analyticsTrackEvents => trackEventActions,
      FeatureSection.analyticsUserProperties => userPropertyActions,
    };

    /// 🔥 PLATFORM FILTERING
    return actions
        .where((a) => PlatformUtils.isSupported(
            a.supportedPlatform ?? SupportedPlatform.all))
        .toList();
  }

  static ClientFeature getParentFeature(FeatureSection section) {
    switch (section) {
      case FeatureSection.pushActions:
      case FeatureSection.notificationCenter:
        return ClientFeature.push;

      case FeatureSection.inappMessageActions:
        return ClientFeature.inAppMessages;

      case FeatureSection.inappNudgeActions:
        return ClientFeature.inAppNudges;

      case FeatureSection.analyticsTrackEvents:
      case FeatureSection.analyticsUserProperties:
        return ClientFeature.analytics;
    }
  }
}




// import 'package:nv_flutter_sdk_app/client/features/analytics/analytics_actions.dart';
// import 'package:nv_flutter_sdk_app/client/features/in_app_messages/inpp_message_actions.dart';
// import 'package:nv_flutter_sdk_app/client/features/in_app_nudges/inapp_nudges_actions.dart';
// import 'package:nv_flutter_sdk_app/client/features/push/push_actions.dart';
// import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_definition.dart';

// /// ------------------------------
// /// Top-level Client Features
// /// ------------------------------
// enum ClientFeature {
//   analytics,
//   push,
//   inAppMessages,
//   inAppNudges,
// }

// /// ------------------------------
// /// Feature Sections
// /// ------------------------------
// enum FeatureSection {
//   /// Analytics
//   analyticsTrackEvents,
//   analyticsUserProperties,

//   /// Push
//   pushActions,
//   notificationCenter,

//   /// In-App Messages
//   inAppMessageActions,

//   /// In-App Nudges
//   inAppNudgeActions,
// }

// /// ------------------------------
// /// Central Registry
// /// ------------------------------
// class ClientFeatureRegistry {
//   ClientFeatureRegistry._();

//   /// 🔹 Main API used by FeatureActionScreen
//   static List<FeatureActionDefinition> getActions(
//     FeatureSection section,
//   ) {
//     final actions = _getRawActions(section);

//     /// 🔥 Platform filtering happens HERE
//     return actions
//         .where((action) => action.isSupportedOnCurrentPlatform)
//         .toList();
//   }

//   /// 🔹 Internal raw mapping (no filtering)
//   static List<FeatureActionDefinition> _getRawActions(
//     FeatureSection section,
//   ) {
//     switch (section) {
//       /// ------------------------------
//       /// Analytics
//       /// ------------------------------
//       case FeatureSection.analyticsTrackEvents:
//         return trackEventActions;

//       case FeatureSection.analyticsUserProperties:
//         return userPropertyActions;

//       /// ------------------------------
//       /// Push
//       /// ------------------------------
//       case FeatureSection.pushActions:
//         return sendPushActions;

//       case FeatureSection.notificationCenter:
//         return notificationCenterActions;

//       /// ------------------------------
//       /// In-App Messages
//       /// ------------------------------
//       case FeatureSection.inAppMessageActions:
//         return inAppMessageActions;

//       /// ------------------------------
//       /// In-App Nudges
//       /// ------------------------------
//       case FeatureSection.inAppNudgeActions:
//         return inAppNudgesActions;
//     }
//   }

//   /// ------------------------------
//   /// Section → Parent Feature mapping
//   /// ------------------------------
//   static ClientFeature getParentFeature(FeatureSection section) {
//     switch (section) {
//       case FeatureSection.analyticsTrackEvents:
//       case FeatureSection.analyticsUserProperties:
//         return ClientFeature.analytics;

//       case FeatureSection.pushActions:
//       case FeatureSection.notificationCenter:
//         return ClientFeature.push;

//       case FeatureSection.inAppMessageActions:
//         return ClientFeature.inAppMessages;

//       case FeatureSection.inAppNudgeActions:
//         return ClientFeature.inAppNudges;
//     }
//   }
// }
