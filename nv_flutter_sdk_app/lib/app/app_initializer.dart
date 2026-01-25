import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nv_flutter_sdk_app/shared/providers/app_bootstrap_provider.dart';
// import '../shared/providers/environment_provider.dart';
import 'app_gate.dart';

class AppInitializer extends ConsumerWidget {
  const AppInitializer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final envState = ref.watch(environmentProvider);
    final envState = ref.watch(appBootstrapProvider);

    return envState.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) {
        // ❌ Remove splash even on error
        FlutterNativeSplash.remove();
        return Scaffold(
          body: Center(child: Text('Init error: $e')),
        );
      },
      data: (_) {
        // ✅ Remove splash ONLY when ready
        FlutterNativeSplash.remove();
        return const AppGate();
      },
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../shared/providers/environment_provider.dart';
// import 'app_gate.dart';

// class AppInitializer extends ConsumerWidget {
//   const AppInitializer({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final envState = ref.watch(environmentProvider);

//     return envState.when(
//       loading: () => const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       ),
//       error: (e, _) => Scaffold(
//         body: Center(child: Text('Init error: $e')),
//       ),
//       data: (_) => const AppGate(),
//     );
//   }
// }
