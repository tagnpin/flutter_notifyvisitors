import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool copyable;
  final bool multiline;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.copyable = false,
    this.multiline = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment:
            multiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          if (copyable)
            IconButton(
              icon: const Icon(Icons.copy, size: 18),
              visualDensity: VisualDensity.compact,
              tooltip: 'Copy',
              onPressed: () async {
                await Clipboard.setData(
                  ClipboardData(text: value),
                );

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Copied to clipboard'),
                    ),
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}
