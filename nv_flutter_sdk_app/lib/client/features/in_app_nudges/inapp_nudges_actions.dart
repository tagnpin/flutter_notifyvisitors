import '../../../sdk/sdk_manager.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_definition.dart';

final List<FeatureActionDefinition> inAppNudgesActions = [
  FeatureActionDefinition(
    id: 'inAppNudges',
    title: 'Show InApp Nudges',
    description: 'Show InApp Nudges',
    actionLabel: 'Show InApp Nudges',
    execute: (params) async {
      SDKManager.showInAppMessage('Show InApp Nudges');
      return null;
    },
  ),
  const FeatureActionDefinition(
    id: 'nativeDisplay',
    title: 'Native Display',
    description: 'Show native display inside your parent view',
    actionLabel: 'SNative Display',
  ),
];
