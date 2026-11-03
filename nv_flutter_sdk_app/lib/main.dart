import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app/app.dart';

void main() {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // ✅ Keep native splash until app is ready
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    const ProviderScope(
      child: SDKReferenceApp(),
    ),
  );
}
