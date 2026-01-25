import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nv_flutter_sdk_app/navigation/client_router.dart';
import 'package:nv_flutter_sdk_app/navigation/qa_router.dart';
import 'package:nv_flutter_sdk_app/shared/providers/app_mode_provider.dart';

class AppGate extends ConsumerWidget {
  const AppGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(appModeProvider);

    return mode == AppMode.qa ? const QARouter() : const ClientRouter();
  }
}








// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nv_flutter_sdk_app/navigation/client_router.dart';
// import 'package:nv_flutter_sdk_app/navigation/qa_router.dart';
// import 'package:nv_flutter_sdk_app/shared/providers/app_mode_provider.dart';

// class AppGate extends ConsumerWidget {
//   const AppGate({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final mode = ref.watch(appModeProvider);
//     return mode == AppMode.qa ? const QARouter() : const ClientRouter();
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nv_flutter_sdk_app/navigation/client_router.dart';
// import 'package:nv_flutter_sdk_app/navigation/qa_router.dart';
// import 'package:nv_flutter_sdk_app/shared/providers/app_mode_provider.dart';

// class AppGate extends ConsumerWidget {
//   const AppGate({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final mode = ref.watch(appModeProvider);

//     return mode == AppMode.qa ? QARouter().build() : ClientRouter().build();
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nv_flutter_sdk_app/navigation/client_router.dart';
// import 'package:nv_flutter_sdk_app/navigation/qa_router.dart';
// import 'package:nv_flutter_sdk_app/shared/providers/app_mode_provider.dart';

// class AppGate extends ConsumerWidget {
//   const AppGate({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final mode = ref.watch(appModeProvider);

//     //return mode == AppMode.qa ? QARouter() : ClientRouter();

//     return mode == AppMode.qa ? const QARouter() : const ClientRouter();
//   }
// }
