import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_field.dart';

enum SupportedPlatform {
  all,
  ios,
  android,
}

enum ActionUIType {
  button, // simple execute
  form, // accordion + inputs
}

typedef FeatureActionExecutor = Future<Map<String, dynamic>?> Function(
  Map<String, dynamic> params,
);

class FeatureActionDefinition {
  final String id;
  final String? title;
  final String? description;
  final String? actionLabel;
  final ActionUIType? uiType;
  final List<FeatureActionField?>? fields;
  final FeatureActionExecutor? execute;
  final bool? showResult;
  final String? resultTitle;
  final SupportedPlatform? supportedPlatform;

  const FeatureActionDefinition({
    required this.id,
    this.title,
    this.description,
    this.uiType = ActionUIType.button,
    this.actionLabel,
    this.fields,
    this.execute,
    this.showResult = false,
    this.resultTitle,
    this.supportedPlatform = SupportedPlatform.all,
  });
}


// import 'dart:io';
// import 'package:flutter/material.dart';

// typedef FeatureExecute = void Function(BuildContext context);

// enum SupportedPlatform {
//   ios,
//   android,
//   all,
// }

// class FeatureActionDefinition {
//   final String id;
//   final String? title;
//   final String? description;
//   final String? actionLabel;
//   final FeatureExecute? execute;
//   final bool? showResult;
//   final String? resultTitle;
//   final SupportedPlatform? supportedPlatform;

//   const FeatureActionDefinition({
//     required this.id,
//     this.title,
//     this.description,
//     this.actionLabel,
//     this.execute,
//     this.showResult = false,
//     this.resultTitle,
//     this.supportedPlatform = SupportedPlatform.all,
//   });

//   /// 🔹 Platform check helper
//   bool get isSupportedOnCurrentPlatform {
//     switch (supportedPlatform) {
//       case SupportedPlatform.all:
//         return true;
//       case SupportedPlatform.ios:
//         return Platform.isIOS;
//       case SupportedPlatform.android:
//         return Platform.isAndroid;
//       default:
//         return true;
//     }
//   }
// }
