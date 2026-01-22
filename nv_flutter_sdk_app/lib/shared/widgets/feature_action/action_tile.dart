import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nv_flutter_sdk_app/shared/utils/json_utils.dart';
import 'package:nv_flutter_sdk_app/shared/utils/platform_utils.dart';

import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_definition.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_field.dart';

class ActionTile extends StatefulWidget {
  final FeatureActionDefinition action;

  const ActionTile({
    super.key,
    required this.action,
  });

  @override
  State<ActionTile> createState() => _ActionTileState();
}

class _ActionTileState extends State<ActionTile> {
  bool _expanded = false;
  bool _loading = false;

  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String?> _errors = {};

  Map<String, dynamic>? _rawResult;
  Map<String, dynamic>? _parsedResult;

  @override
  void initState() {
    super.initState();
    for (final field in widget.action.fields ?? []) {
      if (field != null) {
        _controllers[field.key] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  // ------------------------------------------------------------
  // Validation
  // ------------------------------------------------------------
  bool _validate() {
    _errors.clear();

    for (final field in widget.action.fields ?? []) {
      if (field == null) continue;

      final value = _controllers[field.key]?.text.trim() ?? '';

      if (field.required && value.isEmpty) {
        _errors[field.key] = 'Required';
        continue;
      }

      if (field.type == FieldType.json && value.isNotEmpty) {
        if (!JsonUtils.isValidJson(value)) {
          _errors[field.key] = 'Invalid JSON';
        }
      }
    }

    setState(() {});
    return _errors.isEmpty;
  }

  // ------------------------------------------------------------
  // Execute
  // ------------------------------------------------------------
  Future<void> _execute() async {
    if (!_validate()) return;

    final params = <String, dynamic>{};

    for (final field in widget.action.fields ?? []) {
      if (field == null) continue;

      final raw = _controllers[field.key]!.text.trim();
      params[field.key] =
          raw.isEmpty ? null : JsonUtils.parseFieldValue(field.type, raw);
    }

    setState(() {
      _loading = true;
      _rawResult = null;
      _parsedResult = null;
    });

    try {
      final result = await widget.action.execute?.call(params);
      if (!mounted) return;

      setState(() {
        _rawResult = result;
        _parsedResult = JsonUtils.tryPrettyJson(result);
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _rawResult = {'error': e.toString()};
      });
    } finally {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  // ------------------------------------------------------------
  // Build
  // ------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    if (!PlatformUtils.isSupported(
      widget.action.supportedPlatform ?? SupportedPlatform.all,
    )) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      color: colorScheme.surface,
      child: widget.action.uiType == ActionUIType.form
          ? _buildAccordion(theme)
          : _buildSimpleButton(theme),
    );
  }

  // ------------------------------------------------------------
  // Simple Button Action
  // ------------------------------------------------------------
  Widget _buildSimpleButton(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.action.title ?? widget.action.id,
            style: theme.textTheme.titleMedium,
          ),
          if (widget.action.description != null) ...[
            const SizedBox(height: 6),
            Text(
              widget.action.description!,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
          const SizedBox(height: 12),
          _buildActionButton(theme),
          if (widget.action.showResult == true && _rawResult != null) ...[
            const Divider(),
            _buildResultSection(theme),
          ],
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Accordion Action
  // ------------------------------------------------------------
  Widget _buildAccordion(ThemeData theme) {
    return ExpansionTile(
      initiallyExpanded: _expanded,
      onExpansionChanged: (v) => setState(() => _expanded = v),
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      title: Text(
        widget.action.title ?? widget.action.id,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: widget.action.description != null
          ? Text(
              widget.action.description!,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            )
          : null,
      children: [
        ..._buildFields(theme),
        const SizedBox(height: 12),
        _buildActionButton(theme),
        if (widget.action.showResult == true && _rawResult != null) ...[
          const Divider(),
          _buildResultSection(theme),
        ],
      ],
    );
  }

  // ------------------------------------------------------------
  // Fields
  // ------------------------------------------------------------
  List<Widget> _buildFields(ThemeData theme) {
    return (widget.action.fields ?? [])
        .whereType<FeatureActionField>()
        .map((field) {
      final isJsonLike =
          field.type == FieldType.json || field.type == FieldType.array;

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: _controllers[field.key],
          maxLines: isJsonLike ? 6 : 1,
          keyboardType: field.type == FieldType.number
              ? TextInputType.number
              : TextInputType.text,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            labelText: field.label,
            hintText: isJsonLike ? '{ "key": "value" }' : null,
            errorText: _errors[field.key],
          ),
        ),
      );
    }).toList();
  }

  // ------------------------------------------------------------
  // Action Button
  // ------------------------------------------------------------
  Widget _buildActionButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _loading ? null : _execute,
        child: _loading
            ? SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: theme.colorScheme.onPrimary,
                ),
              )
            : Text(widget.action.actionLabel ?? 'Execute'),
      ),
    );
  }

  // ------------------------------------------------------------
  // Result Section
  // ------------------------------------------------------------
  Widget _buildResultSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.action.resultTitle != null)
          Text(
            widget.action.resultTitle!,
            style: theme.textTheme.titleSmall,
          ),
        const SizedBox(height: 8),
        _buildResultBlock(
          theme: theme,
          title: 'Raw',
          content: const JsonEncoder.withIndent('  ').convert(_rawResult),
        ),
        if (_parsedResult != null) ...[
          const SizedBox(height: 8),
          _buildResultBlock(
            theme: theme,
            title: 'Parsed',
            content: const JsonEncoder.withIndent('  ').convert(_parsedResult),
          ),
        ],
      ],
    );
  }

  Widget _buildResultBlock({
    required ThemeData theme,
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.labelLarge),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                content,
                style: theme.textTheme.bodySmall
                    ?.copyWith(fontFamily: 'monospace'),
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: IconButton(
                icon: const Icon(Icons.copy, size: 18),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: content));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
