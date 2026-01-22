import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nv_flutter_sdk_app/app/app_initializer.dart';

import 'package:nv_flutter_sdk_app/shared/theme/app_theme.dart';

class SDKReferenceApp extends ConsumerWidget {
  const SDKReferenceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sample SDK App',

      // ✅ THEMES APPLIED HERE
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const AppInitializer(),
    );
  }
}
