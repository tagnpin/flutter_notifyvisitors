import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nv_flutter_sdk_app/config/qa_gate_config.dart';
import 'package:nv_flutter_sdk_app/shared/providers/qa_gate_provider.dart';

class QAGateScreen extends ConsumerStatefulWidget {
  final bool isExitFlow;
  const QAGateScreen({
    super.key,
    this.isExitFlow = false,
  });

  @override
  ConsumerState<QAGateScreen> createState() => _QAGateScreenState();
}

class _QAGateScreenState extends ConsumerState<QAGateScreen> {
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isError = false;
  bool _isSubmitting = false;

  void _submitPin() {
    if (_pinController.text != QAGateConfig.qaPin) {
      setState(() {
        _isError = true;
        _isSubmitting = false;
      });
      return;
    }

    final qaGate = ref.read(qaGateProvider);

    if (widget.isExitFlow) {
      // 🔁 EXIT QA MODE
      qaGate.lock();
    } else {
      // 🔓 ENTER QA MODE
      qaGate.unlock();
    }

    // Always close PIN screen
    Navigator.of(context, rootNavigator: true).pop();
  }

  // void _submitPin() async {
  //   if (_pinController.text != _qaPin) {
  //     setState(() {
  //       _isError = true;
  //       _isSubmitting = false;
  //     });
  //     return;
  //   }

  //   // 1️⃣ Unlock QA
  //   ref.read(qaGateProvider).unlock();

  //   // 2️⃣ CLOSE the QA Gate screen
  //   Navigator.of(context, rootNavigator: true).pop();

  //   // 3️⃣ Stop loader
  //   setState(() {
  //     _isSubmitting = false;
  //   });
  // }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 🚫 disable back button / gesture
      child: Scaffold(
        appBar: AppBar(
          title: const Text('QA Access'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Enter QA PIN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: 6,
                    decoration: InputDecoration(
                      labelText: 'PIN',
                      errorText: _isError ? 'Invalid PIN' : null,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'PIN is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitPin,
                      child: _isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Verify'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nv_flutter_sdk_app/shared/providers/qa_gate_provider.dart';
// import '../../shared/providers/app_mode_provider.dart';

// class QAGateScreen extends ConsumerStatefulWidget {
//   const QAGateScreen({super.key});

//   @override
//   ConsumerState<QAGateScreen> createState() => _QAGateScreenState();
// }

// class _QAGateScreenState extends ConsumerState<QAGateScreen> {
//   final controller = TextEditingController();
//   String? error;

//   @override
//   Widget build(BuildContext context) {
//     // ✅ THIS is the key fix
//     ref.listen<AppMode>(appModeProvider, (_, next) {
//       if (next == AppMode.qa) {
//         Navigator.of(context).pop(); // close PIN screen
//       }
//     });

//     return Scaffold(
//       appBar: AppBar(title: const Text('QA Access')),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             const Text(
//               'Enter QA PIN',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: controller,
//               keyboardType: TextInputType.number,
//               obscureText: true,
//               maxLength: 4,
//               decoration: InputDecoration(
//                 errorText: error,
//                 border: const OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 final success =
//                     ref.read(qaGateProvider).unlock(controller.text);
//                 if (!success) {
//                   setState(() => error = 'Invalid PIN');
//                 }
//               },
//               child: const Text('Unlock QA Mode'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
