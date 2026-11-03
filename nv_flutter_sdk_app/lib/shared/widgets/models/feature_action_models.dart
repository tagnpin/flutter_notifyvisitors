import 'package:flutter/material.dart';
import 'package:nv_flutter_sdk_app/config/client_feature_registry.dart';

class FeatureActionListItem {
  final String title;
  final String description;
  final VoidCallback? onTap;

  FeatureActionListItem({
    required this.title,
    required this.description,
    this.onTap,
  });
}

class FeatureActionArgs {
  final String featureTitle;
  final FeatureSection section;

  FeatureActionArgs({
    required this.featureTitle,
    required this.section,
  });
}


// class FeatureActionArgs {
//   final String featureTitle;
//   final List<FeatureActionListItem> actions;

//   FeatureActionArgs({
//     required this.featureTitle,
//     required this.actions,
//   });
// }

// class FeatureActionArgs {
//   final String featureTitle;
//   final ClientFeature feature;

//   FeatureActionArgs({
//     required this.featureTitle,
//     required this.feature,
//   });
// }
