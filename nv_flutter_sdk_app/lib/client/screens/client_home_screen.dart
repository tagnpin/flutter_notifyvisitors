import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nv_flutter_sdk_app/client/screens/feature_action_screen.dart';
import 'package:nv_flutter_sdk_app/config/client_feature_registry.dart';
import 'package:nv_flutter_sdk_app/sdk/sdk_manager.dart';
import 'package:nv_flutter_sdk_app/shared/providers/notification_badge_provider.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/advanced_action_tile.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/feature_list_item.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_models.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/sdk_info_section.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/section_header.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  void _openFeature(
    BuildContext context,
    FeatureSection section,
    String title,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FeatureActionScreen(
          args: FeatureActionArgs(
            featureTitle: title,
            section: section,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('NVECTA (Flutter)'),
        centerTitle: false,
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final count = ref.watch(notificationBadgeProvider);

              final theme = Theme.of(context);
              final colors = theme.colorScheme;

              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    onPressed: () {
                      ref.read(notificationBadgeProvider.notifier).update(0);
                      SDKManager.showAdvancedNotificationCenter();
                    },
                  ),
                  if (count > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: colors.error,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$count',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colors.onError,
                            fontSize: 10,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],

        // actions: [
        //   Stack(
        //     children: [
        //       IconButton(
        //         icon: const Icon(Icons.notifications_none),
        //         onPressed: () {},
        //       ),
        //       Positioned(
        //         right: 8,
        //         top: 8,
        //         child: Container(
        //           padding: const EdgeInsets.all(4),
        //           decoration: BoxDecoration(
        //             color: colors.error,
        //             shape: BoxShape.circle,
        //           ),
        //           child: Text(
        //             '3',
        //             style: theme.textTheme.labelSmall?.copyWith(
        //               color: colors.onError,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Text(
              'NVECTA (Flutter) SDK App',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 4),

            /// Subtitle
            Text(
              'Reference app for SDK integration & testing',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 20),

            /// SDK Info
            const SDKInfoCard(
              status: 'Initialized',
              sdkVersion: '3.2.1',
              appVersion: '1.0.0 (100)',
              platform: 'Android',
              deviceId: '7f3c9a2b8d1e...',
              pushToken: 'fcm_abc123xyz...',
            ),

            const SizedBox(height: 28),

            /// Features
            const SectionHeader(title: 'Features'),
            const SizedBox(height: 12),

            /// Push Notifications
            FeatureListItem.accordion(
              icon: Icons.notifications_active_sharp,
              title: 'Push Notifications',
              description: 'Send & manage push notifications',
              children: [
                FeatureChildItem(
                  title: 'Test Push Notifications',
                  onTap: () => _openFeature(
                    context,
                    FeatureSection.pushActions,
                    'Push Notifications',
                  ),
                ),
                FeatureChildItem(
                  title: 'Notification Center',
                  onTap: () => _openFeature(
                    context,
                    FeatureSection.notificationCenter,
                    'Notification Center',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// In-App Messages
            FeatureListItem.simple(
              icon: Icons.message,
              title: 'In-App Messages',
              description: 'show InApp Popup and surveys',
              onTap: () => _openFeature(
                context,
                FeatureSection.inappMessageActions,
                'In-App Messages',
              ),
            ),

            const SizedBox(height: 12),

            /// In-App Nudges
            FeatureListItem.simple(
              icon: Icons.touch_app,
              title: 'In-App Nudges',
              description: 'Show contextual nudges for users',
              onTap: () => _openFeature(
                context,
                FeatureSection.inappNudgeActions,
                'In-App Nudges',
              ),
            ),

            const SizedBox(height: 12),

            /// Analytics
            FeatureListItem.accordion(
              icon: Icons.analytics_outlined,
              title: 'Analytics',
              description: 'Track events & user properties',
              children: [
                FeatureChildItem(
                  title: 'Track Events',
                  onTap: () => _openFeature(
                    context,
                    FeatureSection.analyticsTrackEvents,
                    'Track Events',
                  ),
                ),
                FeatureChildItem(
                  title: 'User Properties',
                  onTap: () => _openFeature(
                    context,
                    FeatureSection.analyticsUserProperties,
                    'User Properties',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            /// Advanced
            const SectionHeader(title: 'Advanced'),
            const SizedBox(height: 12),

            const AdvancedActionTile(),
          ],
        ),
      ),
    );
  }
}
