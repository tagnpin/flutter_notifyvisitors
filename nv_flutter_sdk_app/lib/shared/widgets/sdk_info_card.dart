import 'package:flutter/material.dart';

import 'info_row.dart';
import 'info_section_title.dart';

class SDKInfoCard extends StatelessWidget {
  final String appVersion;
  final String buildNumber;
  final String environment;

  final String sdkVersion;
  final String brandId;

  final String platform;
  final String osVersion;
  final String deviceId;

  final String advertisingId;
  final String trackingStatus;

  final String pushToken;

  const SDKInfoCard({
    super.key,
    required this.appVersion,
    required this.buildNumber,
    required this.environment,
    required this.sdkVersion,
    required this.brandId,
    required this.platform,
    required this.osVersion,
    required this.deviceId,
    required this.advertisingId,
    required this.trackingStatus,
    required this.pushToken,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// APP INFO
            const InfoSectionTitle(
              title: 'App Info',
            ),

            InfoRow(
              label: 'App Version',
              value: appVersion,
            ),

            InfoRow(
              label: 'Build Number',
              value: buildNumber,
            ),

            InfoRow(
              label: 'Environment',
              value: environment,
            ),

            /// SDK INFO
            const InfoSectionTitle(
              title: 'SDK Info',
            ),

            InfoRow(
              label: 'SDK Version',
              value: sdkVersion,
            ),

            InfoRow(
              label: 'Brand ID',
              value: brandId,
              copyable: true,
            ),

            /// DEVICE
            const InfoSectionTitle(
              title: 'Device',
            ),

            InfoRow(
              label: 'Platform',
              value: platform,
            ),

            InfoRow(
              label: 'OS Version',
              value: osVersion,
            ),

            InfoRow(
              label: 'Device ID',
              value: deviceId,
              copyable: true,
            ),

            InfoRow(
              label: 'Advertising ID',
              value: advertisingId,
              copyable: true,
            ),

            InfoRow(
              label: 'Tracking Status',
              value: trackingStatus,
            ),

            /// PUSH
            const InfoSectionTitle(
              title: 'Push',
            ),

            InfoRow(
              label: 'Push Token',
              value: pushToken,
              copyable: true,
              multiline: true,
            ),
          ],
        ),
      ),
    );
  }
}
