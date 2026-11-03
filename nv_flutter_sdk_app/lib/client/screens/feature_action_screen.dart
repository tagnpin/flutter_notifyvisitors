import 'package:flutter/material.dart';
import 'package:nv_flutter_sdk_app/config/client_feature_registry.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/feature_action/action_tile.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_definition.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_models.dart';

class FeatureActionScreen extends StatelessWidget {
  final FeatureActionArgs args;

  const FeatureActionScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ✅ Load actions from registry
    final List<FeatureActionDefinition> actions =
        ClientFeatureRegistry.getActions(args.section);

    return Scaffold(
      appBar: AppBar(
        title: Text(args.featureTitle),
      ),
      body: actions.isEmpty
          ? Center(
              child: Text(
                'No actions available',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: actions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final action = actions[index];
                return ActionTile(
                  action: action,
                );

                //_ActionTile(action: action);
              },
            ),
    );
  }
}
