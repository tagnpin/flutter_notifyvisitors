# iOS Integration

This guide explains the iOS-specific configuration required to integrate the NotifyVisitors Flutter plugin into your Flutter application.

**Official Documentation:**
https://www.nvecta.com/docs/flutter-ios-integration

---

## Overview

The iOS integration consists of the following steps:

1. Install iOS dependencies
2. Configure SDK credentials
3. Configure the AppDelegate
4. Initialize the SDK
5. Verify the integration
6. Configure Push Notifications (optional)

---

## Prerequisites

Before proceeding, ensure that:

- Flutter is installed and configured.
- Xcode is installed.
- CocoaPods is installed.
- The NotifyVisitors Flutter plugin has been added to your project's `pubspec.yaml`.
- You have your **Brand ID** and **Secret Key** from the NVECTA Dashboard.

---

## 1. Install iOS Dependencies

From the root directory of your Flutter project, install the iOS dependencies by running:

```bash
cd ios
pod install
cd ..
```

---

## 2. Configure SDK Credentials

Open the iOS project using:

```text
ios/Runner.xcworkspace
```

Open **Info.plist** and add the following keys.

```xml
<key>nvBrandID</key>
<integer>YOUR_BRAND_ID</integer>

<key>nvSecretKey</key>
<string>YOUR_SECRET_KEY</string>

<key>nvPushCategory</key>
<string>nvpush</string>
```

### SDK Configuration

| Key              | Type   | Description                                                  |
| ---------------- | ------ | ------------------------------------------------------------ |
| `nvBrandID`      | Number | Your NotifyVisitors Brand ID                                 |
| `nvSecretKey`    | String | Your NotifyVisitors Secret Key                               |
| `nvPushCategory` | String | Push notification category. Use the default value: `nvpush`. |

> **Tip**
>
> You can edit `Info.plist` either as a **Property List** or as **Source Code**. Both approaches produce the same result.

> **Important**
>
> Replace the sample values above with your actual Brand ID and Secret Key available from the NVECTA Dashboard.

---

## 3. Configure AppDelegate

The SDK uses iOS application lifecycle callbacks to support:

- Session tracking
- Analytics
- Deep-link handling
- SDK lifecycle management

Forward the following callbacks from your `AppDelegate`.

### Swift

```swift
import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        NotifyvisitorsPlugin.nvInitialize()

        GeneratedPluginRegistrant.register(with: self)

        return super.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
    }

    override func applicationDidEnterBackground(
        _ application: UIApplication
    ) {
        NotifyvisitorsPlugin.applicationDidEnterBackground(application)
    }

    override func applicationWillEnterForeground(
        _ application: UIApplication
    ) {
        NotifyvisitorsPlugin.applicationWillEnterForeground(application)
    }

    override func applicationDidBecomeActive(
        _ application: UIApplication
    ) {
        NotifyvisitorsPlugin.applicationDidBecomeActive(application)
    }

    override func applicationWillTerminate(
        _ application: UIApplication
    ) {
        NotifyvisitorsPlugin.applicationWillTerminate()
    }

    override func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        NotifyvisitorsPlugin.openUrl(app, open: url)

        return super.application(
            app,
            open: url,
            options: options
        )
    }
}
```

<details>
<summary>Objective-C</summary>

```objective-c
#import "AppDelegate.h"
#import <Flutter/Flutter.h>
#import <flutter_notifyvisitors/NotifyvisitorsPlugin.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [NotifyvisitorsPlugin nvInitialize];

    [GeneratedPluginRegistrant registerWithRegistry:self];

    return [super application:application
didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [NotifyvisitorsPlugin applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [NotifyvisitorsPlugin applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [NotifyvisitorsPlugin applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [NotifyvisitorsPlugin applicationWillTerminate];
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    [NotifyvisitorsPlugin openUrl:app openURL:url];

    return [super application:app
                      openURL:url
                      options:options];
}

@end
```

</details>

### Lifecycle Methods

| Method                             | Description                                                          |
| ---------------------------------- | -------------------------------------------------------------------- |
| `nvInitialize()`                   | Initializes the SDK.                                                 |
| `applicationDidEnterBackground()`  | Notifies the SDK when the application enters the background.         |
| `applicationWillEnterForeground()` | Notifies the SDK when the application returns to the foreground.     |
| `applicationDidBecomeActive()`     | Starts or resumes SDK session tracking.                              |
| `applicationWillTerminate()`       | Allows the SDK to perform cleanup before the application terminates. |
| `openUrl()`                        | Handles custom URL schemes and deep links.                           |

> **Note**
>
> These lifecycle callbacks are required for proper SDK functionality, including analytics, session tracking, and deep-link processing.

---

## 4. Verify the Integration

Build and launch the application.

Verify that:

- The application builds successfully.
- The SDK initializes without errors.
- Initialization logs appear in the Xcode console.
- No runtime exceptions are reported.

If the SDK does not initialize correctly:

1. Verify that `NotifyvisitorsPlugin.nvInitialize()` is called from `didFinishLaunchingWithOptions`.
2. Ensure all required lifecycle callbacks are forwarded to the SDK.
3. Run:

```bash
flutter clean
flutter pub get
```

4. Reinstall CocoaPods dependencies:

```bash
cd ios
pod install
```

5. Clean and rebuild the project in Xcode.

---

## 5. Push Notifications

To enable Push Notifications for iOS, follow the dedicated [Push Notifications](/docs/ios-push-integration.md) Integration guide.

This guide covers:

- APNs configuration
- Push capabilities
- Device token registration
- Rich notifications
- Notification handling

---

## Next Steps

Once the SDK has been successfully integrated, you can continue with:

- [Push Notifications](/docs/ios-push-integration.md)
- [Event Tracking](/docs/event-tracking-integration.md)
- [User Identification](/docs/user-tracking-integration.md)
- [In-App Messaging](/docs/inapp-integration.md)
- [Screen View Tracking](/docs/screen-tracking.md)
- [Configure Notification Center](/docs/notification-center-integration.md)

Refer to the official documentation for detailed implementation guides.

---

# Support

If you encounter any issues during integration:

- Contact the NVECTA Support Team.
- Raise a support request directly from the NVECTA Dashboard.
