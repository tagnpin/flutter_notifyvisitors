import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/advanced_action_tile.dart';
import 'package:nv_flutter_sdk_app/shared/widgets/section_header.dart';

class QAHomeScreen extends ConsumerWidget {
  const QAHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => false, // 🚫 Disable system back
      child: Scaffold(
        appBar: AppBar(
          title: const Text('QA Mode'),
          automaticallyImplyLeading: false, // 🚫 Remove back arrow
        ),
        body: const Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28),

                Text(
                  'QA Home (Placeholder)',
                  style: TextStyle(fontSize: 16),
                ),

                /// Advanced
                SectionHeader(title: 'Advanced'),
                SizedBox(height: 12),

                AdvancedActionTile(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../shared/providers/qa_gate_provider.dart';

// class QAHomeScreen extends ConsumerWidget {
//   const QAHomeScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('QA Mode'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             // Lock QA and go back to Client mode
//             ref.read(qaGateProvider).lock();
//           },
//         ),
//       ),
//       body: const Center(
//         child: Text(
//           'QA Home (Placeholder)',
//           style: TextStyle(fontSize: 16),
//         ),
//       ),
//     );
//   }
// }
