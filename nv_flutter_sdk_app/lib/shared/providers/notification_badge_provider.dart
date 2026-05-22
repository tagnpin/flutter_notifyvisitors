import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationBadgeNotifier extends StateNotifier<int> {
  NotificationBadgeNotifier() : super(0);

  void update(int count) {
    state = count;
  }

  void reset() {
    state = 0;
  }
}

final notificationBadgeProvider =
    StateNotifierProvider<NotificationBadgeNotifier, int>(
  (ref) => NotificationBadgeNotifier(),
);
