import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final qaGateProvider = ChangeNotifierProvider<QAGateController>((ref) {
  return QAGateController();
});

class QAGateController extends ChangeNotifier {
  bool _isUnlocked = false;
  Timer? _timer;

  bool get isUnlocked => _isUnlocked;

  void unlock({Duration duration = const Duration(hours: 2)}) {
    _isUnlocked = true;

    _timer?.cancel();
    _timer = Timer(duration, lock);

    notifyListeners();
  }

  void lock() {
    _isUnlocked = false;
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }
}
