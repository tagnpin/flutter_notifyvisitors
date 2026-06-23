# Screen Tracking (Flutter)

This guide explains how to track screen views in your Flutter app using the NVECTA / Notifyvisitors SDK. Screen tracking helps you understand which screens users visit, how long they stay, and the sequence of screens they view.

---

## Why track screens?

- Measure user flows and funnels
- Understand which screens keep users engaged
- Personalize messages based on user journeys
- Build screen-based segments for campaigns

---

## Recommended approach

If the SDK provides a dedicated screen tracking API use it. If not, use the generic event tracker to send a `screen_view` event with a `screen_name` and optional metadata. Always track screens after navigation completes so the correct screen name is recorded.

Example event payload:

```json
{
  "event": "screen_view",
  "screen_name": "HomeScreen",
  "timestamp": "2026-06-23T12:34:56Z",
  "user_id": "12345"
}
```

---

## Simple Example (using trackEvent)

Use the SDK's event API to send a screen view. This works even if there is no built-in screen API.

```dart
// Send a screen view event
Notifyvisitors.shared.trackEvent("screen_view", {
  "screen_name": "HomeScreen",
  "timestamp": DateTime.now().toIso8601String(),
});
```

Call this after the screen is visible (for example in `initState` or when navigation completes).

---

## Best practice: use a RouteObserver for automatic tracking

Integrate Flutter's `RouteObserver` to automatically track screens as users navigate your app.

1. Create a RouteObserver in a central place (usually where you build your MaterialApp):

```dart
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

MaterialApp(
  navigatorObservers: [routeObserver],
  // ... other properties
);
```

2. Make your page's State implement `RouteAware` and subscribe to the observer:

```dart
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    _sendScreenView();
  }

  @override
  void didPopNext() {
    // Called when returning to this screen
    _sendScreenView();
  }

  void _sendScreenView() {
    Notifyvisitors.shared.trackEvent("screen_view", {
      "screen_name": "HomePage",
      "timestamp": DateTime.now().toIso8601String(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text('Home')),
    );
  }
}
```

This ensures the `screen_view` event is sent whenever the page becomes visible.

---

## Track screen duration

To measure how long a user stays on a screen, send an entry and exit event or include a `duration` field when leaving the screen.

Example:

```dart
DateTime _enteredAt;

void _sendScreenEnter() {
  _enteredAt = DateTime.now();
  Notifyvisitors.shared.trackEvent("screen_enter", {"screen_name": "HomePage", "timestamp": _enteredAt.toIso8601String()});
}

void _sendScreenExit() {
  final exitAt = DateTime.now();
  final duration = exitAt.difference(_enteredAt).inSeconds;
  Notifyvisitors.shared.trackEvent("screen_exit", {"screen_name": "HomePage", "duration_seconds": duration});
}
```

Call `_sendScreenEnter()` when the screen appears and `_sendScreenExit()` when it disappears (for example in `didPush`/`didPop` or in `dispose` / `didPopNext` depending on your flow).

---

## Best practices

- Always include a consistent `screen_name` (use the same string for the same screen)
- Avoid sending sensitive user data in screen events
- Debounce rapid navigation to avoid noisy events
- Wait for user identification (if applicable) before relying on user-linked analytics — identify the user first to associate screen events with their profile
- Use descriptive names like `HomePage`, `Profile/Edit`, `Checkout/Review`

---

## Quick checklist

- [ ] Add a RouteObserver to MaterialApp
- [ ] Subscribe pages to RouteObserver
- [ ] Send `screen_view` (or `screen_enter`/`screen_exit`) events with `screen_name`
- [ ] Optionally include timestamps, user id, and duration
- [ ] Keep screen names consistent across the app

---

If you want, I can also add a short sample that wires RouteObserver into `main.dart` and exports a reusable mixin to make adding screen tracking to new pages easier.