import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppEnvironment { prod, staging, qa }

final environmentProvider = FutureProvider<AppEnvironment>((ref) async {
  // later: runtime switching
  return AppEnvironment.prod;
});
