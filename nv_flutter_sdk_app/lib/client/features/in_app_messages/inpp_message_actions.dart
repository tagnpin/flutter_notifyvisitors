import '../../../sdk/sdk_manager.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_definition.dart';

final List<FeatureActionDefinition> inAppMessageActions = [
  FeatureActionDefinition(
    id: 'showInAppWalkthrough',
    title: 'Show InApp Walkthrough',
    description: 'Show InApp Walkthrough',
    actionLabel: 'Show InApp Walkthrough',
    execute: (params) async {
      SDKManager.showInAppMessage('walkthrough');
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'showAlert',
    title: 'Show Alert',
    description: 'Show Alert Message Popup',
    actionLabel: 'Show Alert',
    execute: (params) async {
      SDKManager.showInAppMessage('alert');
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'showConfirmationDialog',
    title: 'Show Confirmation Dialog',
    description: 'Show Confirmation Dialog Message Popup',
    actionLabel: 'Show Confirmation Dialog',
    execute: (params) async {
      SDKManager.showInAppMessage('confirmation');
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'showPopup',
    title: 'Show Popup',
    description: 'Show Modal inApp Message Popup',
    actionLabel: 'Show Popup',
    execute: (params) async {
      SDKManager.showInAppMessage('modalpopup');
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'showFullPopup',
    title: 'Show Full Popup',
    description: 'Show Full Screen inApp Message Popup',
    actionLabel: 'Show Full Popup',
    execute: (params) async {
      SDKManager.showInAppMessage('fullpopup');
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'showStickyBar',
    title: 'Show Sticky Bar',
    description: 'Show Sticky Bar inApp Message Popup',
    actionLabel: 'Show Sticky Bar',
    execute: (params) async {
      SDKManager.showInAppMessage('stickybar');
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'showSurvey',
    title: 'Show Survey',
    description: 'Show Modal Survey',
    actionLabel: 'Show Survey',
    execute: (params) async {
      SDKManager.showInAppMessage('modalsurvey');
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'showFullSurvey',
    title: 'Show Full Screen Survey',
    description: 'Show Full Screen Survey',
    actionLabel: 'Show Full Screen Survey',
    execute: (params) async {
      SDKManager.showInAppMessage('fullsurvey');
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'showNPSSurvey',
    title: 'Show Star Rating / NPS Survey',
    description: 'Show Star Rating / NPS inAPP Survey',
    actionLabel: 'show Star Rating / NPS Survey',
    execute: (params) async {
      SDKManager.showInAppMessage('rating_nps_survey');
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'showSpinWheel',
    title: 'show Spin the Wheel',
    description: 'show Spin the Wheel',
    actionLabel: 'show Spin the Wheel',
    execute: (params) async {
      SDKManager.showInAppMessage('spin_the_wheel');
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'showScratchCard',
    title: 'Show Scratch Card',
    description: 'Show Scratch Card',
    actionLabel: 'Show Scratch Card',
    execute: (params) async {
      SDKManager.showInAppMessage('scratch_card');
      return null;
    },
  ),
  FeatureActionDefinition(
    id: 'showNudges',
    title: 'Show Nudge Banner (if Available)',
    description: 'Show Nudge Banner (if Available)',
    actionLabel: 'Show Nudge Banner (if Available)',
    execute: (params) async {
      SDKManager.showInAppMessage('nudges');
      return null;
    },
  ),
];
