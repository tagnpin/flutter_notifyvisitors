import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nv_flutter_sdk_app/shared/providers/qa_gate_provider.dart';

class SectionCard extends StatefulWidget {
  final String title;
  final List<String> items;
  final bool isAdvanced;

  const SectionCard({
    super.key,
    required this.title,
    required this.items,
    this.isAdvanced = false,
  });

  @override
  State<SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<SectionCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: Icon(
              _expanded ? Icons.expand_less : Icons.expand_more,
            ),
            onTap: () => setState(() => _expanded = !_expanded),
          ),
          if (_expanded)
            Column(
              children: widget.items.map((item) {
                return _buildItem(context, item);
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String item) {
    return Consumer(
      builder: (context, ref, _) {
        return ListTile(
          title: Text(item),
          onTap: () {
            if (widget.isAdvanced && item == 'Enable QA Mode') {
              _showQAPinDialog(context, ref);
            }
          },
        );
      },
    );
  }

  void _showQAPinDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Enter QA PIN'),
        content: TextField(
          controller: controller,
          obscureText: true,
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Unlock'),
            onPressed: () async {
              final success =
                  await ref.read(qaGateProvider).unlockWithPin(controller.text);

              if (success && context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
