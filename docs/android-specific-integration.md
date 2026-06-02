# Android Integration
This document explains the Android-specific integration steps required for the Flutter plugin.
<br>

# 1. Gradle Configuration

## Project Level `build.gradle`
Add the Google Services Gradle plugin to enable Firebase services such as push notifications.

```gradle
buildscript {
  dependencies {
    	classpath 'com.google.gms:google-services:4.4.2' //Mandatory for using Firebase Messaging, skip if not using FCM
  }
}
```
---
## App Level `build.gradle`
Add this line at the bottom of `app/build.gradle` file.

```gradle
apply plugin: 'com.google.gms.google-services' //skip if not using FCM
```
---
## Minimum SDK Version
Ensure the minSdkVersion is properly configured, as Nvecta requires a minimum Android SDK version of 23.

```gradle
defaultConfig {
    minSdkVersion 23
}
```
---
## Enable Java 8 Compatibility
```gradle
android {
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
}
```
<br>

# 2. Android Manifest Configuration
Open the following file:

```text
android/app/src/main/AndroidManifest.xml
```

---

## Required Permissions

Add the required permissions above the `<application>` tag.

```xml
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.CHANGE_NETWORK_STATE"/>
<uses-permission android:name="android.permission.CHANGE_WIFI_STATE"/>
```

## Disable Android Backup for Plugin Integration

Set `android:allowBackup="false"` inside the `<application>` tag in `AndroidManifest.xml`. This is required for proper plugin integration and helps prevent unexpected restoration of SDK-related data by the Android system.

```xml
<application
    android:allowBackup="false"
    ...>
</application>
```
<br>

# 3. Application Class Setup
Incorporate our registration method into the `onCreate()` function of your application class. If you haven't created your own yet, go ahead and set one up.

## Java Example

```java
package com.example.app;

import android.app.Application;
import com.flutter.notifyvisitors.NotifyvisitorsPlugin;

public class MyApplication extends Application {

   // NOTE: Replace the below with your own NOTIFYVISITORS_BRAND_ID & NOTIFYVISITORS_BRAND_ENCRYPTION_KEY
   private String NOTIFYVISITORS_BRAND_ENCRYPTION_KEY = "##################################";
   private int NOTIFYVISITORS_BRAND_ID = #####;

    @Override
    public void onCreate() {
        super.onCreate();
        NotifyvisitorsPlugin.register(this, NOTIFYVISITORS_BRAND_ID, NOTIFYVISITORS_BRAND_ENCRYPTION_KEY);
    }
}
```

---

## Kotlin Example

```kotlin
package com.example.app

import android.app.Application
import com.flutter.notifyvisitors.NotifyvisitorsPlugin

class MyApplication : Application() {

    // NOTE: Replace the below with your own NOTIFYVISITORS_BRAND_ID & NOTIFYVISITORS_BRAND_ENCRYPTION_KEY
    private val NOTIFYVISITORS_BRAND_ENCRYPTION_KEY: String = "##################################"
    private val NOTIFYVISITORS_BRAND_ID: Int = #####

    override fun onCreate() {
        super.onCreate()
        NotifyvisitorsPlugin.register(this, NOTIFYVISITORS_BRAND_ID, NOTIFYVISITORS_BRAND_ENCRYPTION_KEY);
    }
}
```

---

## Register Application Class

Inside `AndroidManifest.xml`:

```xml
<application
    android:name=".MyApplication"
    ...>
</application>
```

<br>

# 4. Build & Run

Clean and rebuild the Flutter project.

```bash
flutter clean
flutter pub get
flutter run
```

<br>

# 5. Integration Verification

After completing the integration, verify the plugin initialization from Android Studio Logcat or Flutter terminal logs.
---

## Verify Using Android Studio Logcat

Open:

```text
Android Studio → Logcat
```

Filter logs using our plugin tag:

```text
NotifyVisitors
```

Example successful initialization logs:

```text
PlayStore Connection Setup completed!!
This is the first call of NotifyVisitors SDK.
!SDK-VERSION! :: notifyvisitors: v5.8.4
NV BrandID = 1234
DeviceID == x0x0x0x0x0x0x0x0x0
NV_FCM Token : xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```
---
## Verify Using Flutter Terminal Logs

Run the Flutter application using:

```bash
flutter run
```

Check the terminal output for plugin-related logs:

```text
I/NotifyVisitors: This is the first call of NotifyVisitors SDK.
I/NotifyVisitors: !SDK-VERSION! :: notifyvisitors: v5.8.4
I/NotifyVisitors-Flutter: GET LINK INFO !!
I/NotifyVisitors-Flutter: GET EVENT SURVEY INFO !!
I/NotifyVisitors-Flutter: FETCH EVENT SURVEY RESPONSE !!
I/NotifyVisitors: NV BrandID = 1234
```

---

## Recommended Checks

Verify the following after app launch:

- SDK initializes without errors
- Device token is generated successfully
- No crash or ANR appears in logs

<br>

# Support

If you face any issues during integration, please contact the support team or raise an issue directly from the NVECTA Dashboard.
