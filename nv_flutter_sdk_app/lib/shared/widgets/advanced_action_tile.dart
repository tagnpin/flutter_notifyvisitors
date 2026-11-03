import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nv_flutter_sdk_app/qa/screens/qa_gate_screen.dart';

import 'package:nv_flutter_sdk_app/shared/providers/app_mode_provider.dart';

class AdvancedActionTile extends ConsumerWidget {
  const AdvancedActionTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final mode = ref.watch(appModeProvider);

    final isQA = mode == AppMode.qa;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => QAGateScreen(
              isExitFlow: isQA,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isQA ? Icons.logout : Icons.lock_outline,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isQA ? 'Exit QA Mode' : 'Enable QA Mode',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isQA
                        ? 'Return to client experience'
                        : 'Access internal testing & diagnostics',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nv_flutter_sdk_app/qa/screens/qa_gate_screen.dart';
// import 'package:nv_flutter_sdk_app/shared/providers/app_mode_provider.dart';

// class AdvancedActionTile extends ConsumerWidget {
//   const AdvancedActionTile({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = Theme.of(context);
//     final mode = ref.watch(appModeProvider);

//     final isQA = mode == AppMode.qa;

//     return InkWell(
//       borderRadius: BorderRadius.circular(12),
//       onTap: () {
//         Navigator.of(context, rootNavigator: true).push(
//           MaterialPageRoute(
//             fullscreenDialog: true,
//             builder: (_) => QAGateScreen(
//               isExitFlow: isQA,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: theme.colorScheme.primary),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               isQA ? Icons.logout : Icons.lock_outline,
//               color: theme.colorScheme.primary,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     isQA ? 'Exit QA Mode' : 'Enable QA Mode',
//                     style: theme.textTheme.titleMedium
//                         ?.copyWith(fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     isQA
//                         ? 'Return to client experience'
//                         : 'Access internal testing & diagnostics',
//                     style: theme.textTheme.bodySmall
//                         ?.copyWith(color: theme.hintColor),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(Icons.chevron_right, color: theme.colorScheme.primary),
//           ],
//         ),
//       ),
//     );
//   }
// }
