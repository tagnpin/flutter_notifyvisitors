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

<br>

> **Integration methods**
>
> - **`flutter_notifyvisitors` 1.6.6 and later:** Supports both Simplified Integration (recommended) and the existing Manual Integration.
> - **Versions earlier than `1.6.6`:** Support the existing Manual Integration only.

**Note:** Upgrading to version `1.6.6` or later does not require you to change your existing Manual Integration. You can continue using it or switch to Simplified Integration whenever you choose.

---

## Prerequisites

Before proceeding, ensure that:

- Flutter is installed and configured.
- Xcode is installed.
- CocoaPods is installed.
- The NotifyVisitors Flutter plugin has been added to your project's `pubspec.yaml`.
- You have your `Brand ID` and `Secret Key` from the **NVECTA** Dashboard.

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

The credential configuration depends on the integration method you choose.

### Simplified Integration (`flutter_notifyvisitors` 1.6.6 and later)

Provide the `BrandID` and `SecretKey` through the `NVConfiguration` object during SDK registration.

You do not need to add `nvBrandID` or `nvSecretKey` to `Info.plist`.

### Manual Integration (all package versions)

If you use the existing `nvInitialize()` method, including when using `flutter_notifyvisitors` 1.6.6 or later, the SDK continues to read the `BrandID` and `SecretKey` from `Info.plist`.

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

### Import the SDK

Before calling any NotifyVisitors APIs from your `AppDelegate`, import the SDK.

<details>
<summary>Swift</summary>

If your Swift `AppDelegate` cannot access `NotifyvisitorsPlugin`, create an **Objective-C Bridging Header** and import:

```objc
#import <flutter_notifyvisitors/NotifyvisitorsPlugin.h>
```

Name the bridging header using:

```text
YOUR_PROJECT_NAME-Bridging-Header.h
```

Example:

```text
Runner-Bridging-Header.h
```

Configure the path under:

**Target → Build Settings → Swift Compiler - General → Objective-C Bridging Header**

Example:

```text
Runner/Runner-Bridging-Header.h
```

> **Note**
>
> A bridging header is only required if your Swift project cannot directly access the Objective-C plugin APIs.

</details>

<details>
<summary>Objective-C</summary>

Import the SDK header in `AppDelegate.m`:

```objc
#import <flutter_notifyvisitors/NotifyvisitorsPlugin.h>
```

</details>

### AppDelegate Integration

Choose the integration method you want to use.

### Option 1: Simplified Integration (Recommended)

**Requires `flutter_notifyvisitors` version `1.6.6` or later.**

The simplified integration uses a configuration-based registration function. It initializes the SDK and automatically handles the required application lifecycle, deep-link, and underlying push notification integration.

You only need to create an `NVConfiguration` object, provide your SDK credentials and settings, and initialise the SDK from `didFinishLaunchingWithOptions` as shown below example code.

You do not need to manually forward the SDK lifecycle or deep-link callbacks shown in the Manual Integration section.

#### Swift

```swift
import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        var nvMode: String? = nil

        #if DEBUG
            nvMode = "debug"
        #else
            nvMode = "live"
        #endif

        let config = NVConfiguration()
        config.brandID = 1234
        config.secretKey = "YOUR_SECRET_KEY"
        config.appMode = nvMode

        NotifyvisitorsPlugin.nvRegister(withConfiguration: config)

        GeneratedPluginRegistrant.register(with: self)

        return super.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
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

    NSString *nvMode = @"live";
    #if DEBUG
        nvMode = @"debug";
    #endif

    NVConfiguration *config = [[NVConfiguration alloc] init];
    config.brandID = 1234;
    config.secretKey = @"YOUR_SECRET_KEY";
    config.appMode = nvMode;
    config.trackingAuthorizationWaitTimeInterval = 40;

    [NotifyvisitorsPlugin nvRegisterWithConfiguration:config];

    [GeneratedPluginRegistrant registerWithRegistry:self];

    return [super application:application
        didFinishLaunchingWithOptions:launchOptions];
}

@end
```

</details>

#### Configuration properties

| Property    | Description                                                                          |
| ----------- | ------------------------------------------------------------------------------------ |
| `brandID`   | Your NotifyVisitors Brand ID.                                                        |
| `secretKey` | Your NotifyVisitors Secret Key.                                                      |
| `appMode`   | Application environment. Use `debug` for Debug builds and `live` for Release builds. |

### Option 2: Manual Integration (Available in All Versions)

You can continue using the existing Manual Integration with any supported `flutter_notifyvisitors` version, including version `1.6.6` and later.

This means you can upgrade the package without changing your existing integration.

The `nvInitialize()` function reads the Brand ID and Secret Key from `Info.plist`. You must also forward the required application lifecycle and URL callbacks to the SDK from your `AppDelegate` as shown in example below.

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

## Next Steps

Once the SDK has been successfully integrated, you can continue with:

- [🎯 Tracking Screens](/docs/screen-tracking.md)
- [🔔 Push Notifications (iOS Specific)](/docs/ios-push-integration.md)
- [🎯 Tracking Events](/docs/event-tracking-integration.md)
- [👤 Tracking Users](/docs/user-tracking-integration.md)
- [💬 In-App Notifications](/docs/inapp-integration.md)
- [📥 Notification Center](/docs/notification-center-integration.md)

Refer to the official documentation for detailed implementation guides.

---

# Support

If you encounter any issues during integration:

- Contact the NVECTA Support Team.
- Raise a support request directly from the NVECTA Dashboard.
