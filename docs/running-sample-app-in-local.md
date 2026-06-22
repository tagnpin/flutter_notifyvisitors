# Running the NVECTA Flutter Example App Local Integration

The repository includes a sample application located in the `nv_flutter_sdk_app/` directory that demonstrates how to use this package.

Before running the example app, platform-specific configuration is required.

## Prerequisites

- Flutter SDK installed
- Android Studio and/or Xcode installed
- A Firebase project configured for push notifications

---

# Android Setup

## 1. Configure `local.properties` file

The Android example app requires a `local.properties` file in:

```text
nv_flutter_sdk_app/android/local.properties
```

You can either:

#### Option 1 (Recommended): Use the provided template

Copy the example file:

```bash
cp nv_flutter_sdk_app/android/local.properties.example nv_flutter_sdk_app/android/local.properties
```

Then update the values in `local.properties` according to your environment.

#### Option 2: Create the file manually

Inside the Android project root (`nv_flutter_sdk_app/android/`), create a file named:

```text
local.properties
```

Add the required configuration values:

```properties
NV_BRAND_ID=8XXX
NV_BRAND_ENCRYPTION_KEY=51XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

> ## ⚠️ Note
>
> Replace the values above with your own configuration.

---

## 2. Configure Firebase Cloud Messaging (FCM)

The example app uses Firebase Cloud Messaging.

### Create a Firebase Project

1. Open the Firebase Console.
2. Create a new project (or use an existing one).
3. Add an Android app to the project.

### Download `google-services.json`

After registering the Android application:

1. Download the generated `google-services.json` file.
2. Place it in:

```text
nv_flutter_sdk_app/android/app/google-services.json
```

Directory structure:

```text
nv_flutter_sdk_app/
└── android/
    └── app/
        └── google-services.json
```

---

## 3. Run the Example App

```bash
cd example
flutter pub get
flutter run
```

---

# iOS Setup

## 1. Configure `.xcconfig` File

The iOS example app requires a `nvSecrets.xcconfig` file in:

```text
nv_flutter_sdk_app/ios/Flutter/nvSecrets.xcconfig
```

You can either:

#### Option 1 (Recommended): Use the provided template

Copy the example file:

```bash
cp nv_flutter_sdk_app/ios/Flutter/nvSecrets.xcconfig.example nv_flutter_sdk_app/ios/Flutter/nvSecrets.xcconfig
```

Then update the values in `nvSecrets.xcconfig` according to your environment.

#### Option 2: Create the `.xcconfig` file manually

Inside the iOS project, create the required `.xcconfig` file.

Example:

```text
nv_flutter_sdk_app/ios/Flutter/nvSecrets.xcconfig
```

Add the required configuration values:

```xcconfig
NV_BRAND_ID=8XXX
NV_BRAND_ENCRYPTION_KEY=51XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

> ## ⚠️ Note
>
> Replace the values above with your own configuration.

---

## 2. Install Dependencies

```bash
cd example
flutter pub get

cd ios
pod install
cd ..
```

---

## 3. Run the Example App

```bash
flutter run
```

---

# Notes

- The Android example app requires both `local.properties` configuration and Firebase setup.
- The iOS example app only requires the `.xcconfig` configuration file.
- Do not commit sensitive values such as API keys, secrets, or environment-specific configuration files to source control.
