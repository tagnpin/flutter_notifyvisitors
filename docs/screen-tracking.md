# Screen Tracking Guide

## 📱 What is Screen Tracking?

Screen tracking monitors which screens (pages) your users visit in your Flutter app. Think of it like a visitor counter for each page - it records when users open a screen and how long they stay there.

**Simple Example:**
- User opens your app → Home screen is tracked
- User navigates to Profile → Profile screen is tracked
- User goes back to Home → Home is tracked again

## ❓ Why Should You Use Screen Tracking?

### 1. **Understand Your Users**
- See which screens users visit most
- Find out where users spend the most time
- Understand how users navigate through your app

### 2. **Improve Your App**
- Identify slow or buggy screens
- Find screens that users leave quickly (and fix them)
- Make data-driven decisions about new features

### 3. **Track User Goals**
- See how many users complete important actions
- Find where users get stuck or stop using the app
- Measure if your changes actually helped

### 4. **Debug Problems**
- When a user reports a bug, see exactly which screens they visited before it happened
- Understand the sequence of screens leading to a crash

---

## 🚀 How to Implement Screen Tracking

### ⚠️ Important: Manual Tracking Required

**On hybrid platforms (like web and some Android/iOS implementations), screens do NOT track automatically.** You must manually call the tracking function on every screen.

### The Basic Function

```dart
Notifyvisitors.trackScreen('ScreenName');
```

This one line of code tells the plugin: *"User is now on 'ScreenName'"*

---

## 📋 Implementation Methods

Choose one method below based on your app structure:

---

### **Method 1: Manual Tracking in Each Screen (Simplest)**

Use this method if you have a small number of screens or just want to start simple.

#### How it works:
Add the tracking call to each screen's `initState()` method.

```dart
import 'package:flutter/material.dart';
import 'package:notifyvisitors/notifyvisitors.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Track this screen when it opens
    Notifyvisitors.trackScreen('Home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text('Welcome to Home Screen')),
    );
  }
}
```

---

### **Method 2: Navigation Observer (Recommended)**

Use this method if you want **automatic tracking** with minimal code. It works by watching all navigation changes.

#### Step 1: Create a Custom Navigation Observer

Create a new file `lib/observers/analytics_observer.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:notifyvisitors/notifyvisitors.dart';

class AnalyticsObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _trackScreen(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _trackScreen(newRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _trackScreen(previousRoute);
  }

  void _trackScreen(Route? route) {
    if (route != null) {
      String screenName = route.settings.name ?? 'Unknown';
      Notifyvisitors.trackScreen(screenName);
    }
  }
}
```

#### Step 2: Add to Your MaterialApp

In your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'observers/analytics_observer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: HomeScreen(),
      // Add this line
      navigatorObservers: [AnalyticsObserver()],
      routes: {
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
```

**How it works:**
- Every time a user navigates to a new screen, the observer automatically tracks it
- Uses the route name from `Navigator.pushNamed('routeName')`

**Example Usage:**

```dart
// In your app, when you navigate
Navigator.pushNamed(context, '/profile');
// ✅ Automatically tracked as 'profile'
```
---

### **Method 3: Wrapper Widget**

Use this method if you prefer wrapping screens or not using named routes.

#### Create a Tracked Widget Wrapper

Create `lib/widgets/tracked_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:notifyvisitors/notifyvisitors.dart';

class TrackedScreen extends StatefulWidget {
  final String screenName;
  final Widget child;

  const TrackedScreen({
    required this.screenName,
    required this.child,
  });

  @override
  State<TrackedScreen> createState() => _TrackedScreenState();
}

class _TrackedScreenState extends State<TrackedScreen> {
  @override
  void initState() {
    super.initState();
    Notifyvisitors.trackScreen(widget.screenName);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
```

#### Usage in Your Screens

```dart
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TrackedScreen(
      screenName: 'Profile',
      child: Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: Center(child: Text('User Profile')),
      ),
    );
  }
}
```
---

### **Method 4: GoRouter Integration (Modern Routing)**

If you're using GoRouter (recommended for modern Flutter apps):

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notifyvisitors/notifyvisitors.dart';

final router = GoRouter(
  observers: [AnalyticsRouterObserver()],
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      name: 'home',
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
      name: 'profile',
    ),
  ],
);

class AnalyticsRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != null) {
      Notifyvisitors.trackScreen(route.settings.name!);
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
```

---

## ✅ Best Practices

### 1. **Use Meaningful Screen Names**
```dart
// ❌ Bad
Notifyvisitors.trackScreen('Screen1');

// ✅ Good
Notifyvisitors.trackScreen('HomePage');
Notifyvisitors.trackScreen('UserProfile');
Notifyvisitors.trackScreen('ProductDetail_12345');
```

### 2. **Be Consistent**
- Use the same screen name every time you visit that screen
- Use camelCase or PascalCase consistently

### 3. **Track Important Flows**
Focus on tracking screens that matter:
- Login/Signup flows
- Purchase/Checkout flows
- Onboarding screens
- Error/Help screens

### 4. **Include Context When Needed**
```dart
// Good: Includes item ID for detailed analytics
Notifyvisitors.trackScreen('ProductDetail_${productId}');
```

---
