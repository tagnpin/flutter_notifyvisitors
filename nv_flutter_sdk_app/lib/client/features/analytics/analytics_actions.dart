import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nv_flutter_sdk_app/sdk/sdk_manager.dart';
import 'package:nv_flutter_sdk_app/sdk/sdk_samples_data/sample_events.dart';
import 'package:nv_flutter_sdk_app/sdk/sdk_samples_data/sample_user.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_definition.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_field.dart';

/// -------------------------
/// TRACK EVENT ACTIONS
/// -------------------------
final trackEventActions = [
  /// -------------------------
  /// SIMPLE BUTTON ACTION
  /// -------------------------
  FeatureActionDefinition(
    id: 'track_default_event',
    title: 'Track Default Event',
    description: 'Tracks a default analytics event',
    actionLabel: 'Track',
    resultTitle: "Default Event Tracking Result:",
    showResult: true,
    execute: (params) async {
      final sampleEvent = SampleEvents.purchaseEvent();
      dynamic result = await SDKManager.trackEvent(
          eventName: sampleEvent['eventName'],
          attributes: sampleEvent['attributes'],
          ltv: sampleEvent['ltv'] ?? '10',
          scope: sampleEvent['scope'] ?? '1');

      debugPrint('Tracking default event');
      return result;
    },
  ),

  FeatureActionDefinition(
    id: 'track_screen',
    title: 'Track Screen',
    description: 'Tracks screen_view event',
    actionLabel: 'Track Screen',
    execute: (params) async {
      debugPrint('Tracking screen view event');
      SDKManager.trackScreen(
          "flutter_client_home_screen_${Platform.operatingSystem}");
      return null;
    },
  ),

  /// -------------------------
  /// FORM / ACCORDION ACTION
  /// -------------------------
  FeatureActionDefinition(
    id: 'track_custom_event',
    uiType: ActionUIType.form,
    title: 'Track Custom Event',
    description: 'Tracks a custom event with parameters',
    actionLabel: 'Track Event',
    showResult: true,
    resultTitle: 'Event Response',
    fields: [
      const FeatureActionField(
        key: 'event_name',
        label: 'Event Name',
        required: true,
      ),
      const FeatureActionField(
        key: 'event_attributes',
        label: 'Event Attributes (JSON)',
        type: FieldType.json,
        hint: "{\"key\": \"value\"}",
      ),
      const FeatureActionField(
        key: 'event_ltv',
        label: 'LTV',
      ),
      const FeatureActionField(
        key: 'event_scope',
        label: 'Scope',
        required: true,
        type: FieldType.number,
      ),
    ],
    execute: (params) async {
      String eventName = params['event_name'];
      dynamic attributes = params['event_attributes'] ?? <String, dynamic>{};
      String ltv = params['event_ltv'];

      int scopeInt = params['event_scope'];
      String scopeStr = scopeInt.toString();
      debugPrint(
          'Tracking custom event: {eventName = $eventName, attributes = $attributes, ltv = $ltv, scope = $scopeStr}');
      final result = await SDKManager.trackEvent(
        eventName: eventName,
        attributes: attributes,
        ltv: ltv,
        scope: scopeStr,
      );

      return {
        'request': params,
        'callback': result,
      };
    },
  ),
];

/// -------------------------
/// TRACK USER ACTIONS
/// -------------------------
final List<FeatureActionDefinition> userPropertyActions = [
  FeatureActionDefinition(
    id: 'set_user_details',
    title: 'Set User Details',
    description: 'Creates a known user profile',
    actionLabel: 'Set User Details',
    showResult: true,
    resultTitle: 'user tracking response:',
    execute: (params) async {
      final sampleUser =
          SampleUser.withDynamicEmail(SDKManager.currentDateTime);
      final result = await SDKManager.setUserDetails(sampleUser);
      debugPrint('Setting user details');
      return result;
    },
  ),
  FeatureActionDefinition(
    id: 'get_nv_uid',
    title: 'Get NV-UID',
    description: 'Fetch current NV-UID',
    actionLabel: 'Get NV-UID',
    showResult: true,
    resultTitle: 'NV-UID:',
    execute: (params) async {
      debugPrint('Fetching NV-UID');
      final result = await SDKManager.getNVUID();
      debugPrint('final Current NV-UID: $result');
      return result;
    },
  ),
  FeatureActionDefinition(
    id: 'set_custom_user_property',
    uiType: ActionUIType.form,
    title: 'Set Custom User Property',
    description: 'Set a custom user property',
    actionLabel: 'Set Custom User Property',
    showResult: true,
    resultTitle: 'User Tracking Response:',
    fields: [
      const FeatureActionField(
        key: 'user_params',
        label: 'User Parameters (JSON)',
        type: FieldType.json,
        required: true,
      )
    ],
    execute: (params) async {
      debugPrint(
          "Setting custom user with user_params: ${params['user_params']}");
      Map<String, dynamic> result = {};
      await SDKManager.setUserDetails(params).then((callback) {
        result = callback;
        debugPrint('Custom user property set successfully: $callback');
      });
      debugPrint('setCustomUserProperty result: $result');
      return result;
    },
  ),
];
