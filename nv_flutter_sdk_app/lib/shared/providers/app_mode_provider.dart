import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'qa_gate_provider.dart';

enum AppMode { client, qa }

final appModeProvider = FutureProvider<AppMode>((ref) async {
  final isQAUnlocked = ref.watch(
    qaGateProvider.select((q) => q.isUnlocked),
  );

  return isQAUnlocked ? AppMode.qa : AppMode.client;
});
