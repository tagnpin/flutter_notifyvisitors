# iOS Integration

This document explains the iOS-specific integration steps required for the Flutter plugin.

Official Documentation:  
https://www.nvecta.com/docs/flutter-ios-integration

---

<br>

# 1. Cocoapods Install

Once you have completed the Plugin Installation step, inside the terminal, go to the ios folder located within your Flutter Project root folder using cd command, then run this command from terminal

```ruby
    cd ios && pod install && cd ..
```

For example, if your Project is saved on Desktop and its root folder name is my_flutter_app, then go to your project's ios folder by using the following command

```ruby
    $ cd ~/Desktop/my_flutter_app/ios && pod install && cd ..
```

---

# 2. Configure info.plist

To configure your info.plist, go to ios folder inside your Flutter Project root folder and open your iOS project into Xcode by double click on `.xcworkspace` file and once your Flutter iOS project is open in Xcode, go to `info.plist`, open `info.plist` file as source code (right-click on info.plist and click on Open as >> Source code) and add the following code in it.

```xml
<key>nvBrandID</key>
         <integer>Your BRANDID comes here</integer>
              <key>nvSecretKey</key>
	        <string>Your SECRET KEY comes here</string>
             <key>nvPushCategory</key>
                       <string>nvpush</string>
```

### OR

You can simply open the `info.plist` file as `Property List` and add the keys which work the same as above.

1. Add a new row again and set up a `nvBrandID` as Number and fill this field with your `BRANDID`

   ![BrandID Setup](images/ios/integration/InfoPlist_BrandID.png)

2. Add a new row again and set up a `nvSecretKey` as String and fill this field with your `SECRET KEY`

   ![BrandID Setup](images/ios/integration/InfoPlist_SecretKey.png)

3. Add a new row again and set up a `nvPushCategory` as String and set it’s value nvpush.

   ![Push Category Setup](images/ios/integration/InfoPlist_nvPushCategory.png)

## ⚠️ Important Note

In the example provided above, dummy Brand ID and Secret Key has been mentioned. Kindly login to your account to see your credentials.

# 3. Import SDK Headers

Before calling any NotifyVisitors iOS APIs from your `AppDelegate`, import the SDK header.

## Objective-C

Add the following import statement to your `AppDelegate.m` file:

```objc
#import <flutter_notifyvisitors/NotifyvisitorsPlugin.h>
```

## Swift

If your Flutter iOS project uses Swift and needs to access the Objective-C SDK APIs directly, create a bridging header file:

```text
YOUR_PROJECT_NAME-Bridging-Header.h
```

For example:

```text
Runner-Bridging-Header.h
```

Add the following import statement:

```objc
#import <flutter_notifyvisitors/NotifyvisitorsPlugin.h>
```

### Configure the Bridging Header

Open:

```text
Xcode → Target → Build Settings
```

Search for:

```text
Objective-C Bridging Header
```

Set the value to:

```text
YOUR_PROJECT_NAME/YOUR_PROJECT_NAME-Bridging-Header.h
```

For example:

```text
Runner/Runner-Bridging-Header.h
```

> **Note**
>
> A bridging header is only required when Swift code needs to access Objective-C SDK APIs directly.

## 4. Initialize SDK (iOS)

The iOS SDK requires application lifecycle callbacks for session tracking, analytics, and deep-link handling.

### AppDelegate Integration

Add the following code to your `AppDelegate` file.

<details>
<summary>Swift</summary>

```swift
import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // Initialize NotifyVisitors SDK
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

</details>

<details>
<summary>Objective-C</summary>

```objective-c
#import "AppDelegate.h"
#import <Flutter/Flutter.h>
#import <NotifyvisitorsPlugin/NotifyvisitorsPlugin.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Initialize NotifyVisitors SDK
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

The SDK uses the following application lifecycle callbacks:

| Method                             | Purpose                                           |
| ---------------------------------- | ------------------------------------------------- |
| `nvInitialize()`                   | Initializes the SDK                               |
| `applicationDidEnterBackground()`  | Tracks app background events                      |
| `applicationWillEnterForeground()` | Tracks app foreground transitions                 |
| `applicationDidBecomeActive()`     | Starts and resumes user sessions                  |
| `applicationWillTerminate()`       | Performs SDK cleanup before app termination       |
| `openUrl()`                        | Handles deep-link routing and URL scheme launches |

> **Note**
>
> These callbacks are required for accurate session tracking, analytics collection, and deep-link processing on iOS.

### Verify Integration

After launching the application, verify that the SDK initializes successfully by checking the Xcode console logs.

If the SDK is not initialized:

1. Confirm that `NotifyvisitorsPlugin.nvInitialize()` is called in `didFinishLaunchingWithOptions`.
2. Verify that all lifecycle methods are forwarded to the SDK.
3. Clean and rebuild the iOS project.
4. Run `flutter clean` and `flutter pub get`, then rebuild the application.

```

```

# 5. Push Notifications

NotifyVisitors Flutter plugin enables you to send push notifications to your mobile apps from our dashboard. Kindly refer to our [Push Notifications](/docs/ios-push-integration.md) integration guide available on the next page.

<br>

# Support

If you face any issues during integration, please contact the support team or raise an issue directly from the NVECTA Dashboard.
