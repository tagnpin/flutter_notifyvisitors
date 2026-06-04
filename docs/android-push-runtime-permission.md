# Notification Runtime Permission (Android)

Starting with Android 13 (API Level 33), applications must request notification permission at runtime before sending push notifications.

Official Documentation: <br>
https://www.nvecta.com/docs/flutter-notification-runtime-permission-android

NVECTA provides three different ways to handle notification permission requests:

1. Use your own custom permission UI.
2. Use NVECTA's customizable permission prompt.
3. Use the native Android system permission prompt.

## Import Package

```dart
import 'package:flutter_notifyvisitors/PushPromptInfo.dart';
```

---

<br>

# Option 1: Use Your Own Permission UI

If your application already has a custom permission screen or onboarding flow, you can inform the NVECTA SDK whether the user allowed or denied notification permission.

```dart
Notifyvisitors.shared.enablePushPermission(isAllowed);
```

### Parameters

| Parameter | Type | Description                                                                      |
| --------- | ---- | -------------------------------------------------------------------------------- |
| isAllowed | bool | Pass `true` if the user granted notification permission, otherwise pass `false`. |

### Example

```dart
Notifyvisitors.shared.enablePushPermission(true);
```

### When to Use

* You already have a custom-designed permission screen.
* You want full control over the permission request flow.
* You want to show an educational screen before triggering the Android permission dialog.

---

<br>

# Option 2: Use NVECTA's Custom Permission Prompt

NVECTA provides pre-built permission prompt templates that can be customized to match your application's branding.

The prompt contains:

* Title
* Description
* Allow Button
* Deny Button

## Configure Prompt Design

```dart
PushPromptInfo design = PushPromptInfo();

design.title = "Get Notified";
design.titleTextColor = "#000000";
design.description = "Enable notifications to receive important updates and offers.";
design.descriptionTextColor = "#000000";
design.backgroundColor = "#EBEDEF";
design.buttonOneText = "Allow";
design.buttonOneTextColor = "#FFFFFF";
design.buttonOneBackgroundColor = "#26a524";
design.buttonOneBorderColor = "#6db76c";
design.buttonOneBorderRadius = 0;
design.buttonTwoText = "Cancel";
design.buttonTwoTextColor = "#FFFFFF";
design.buttonTwoBackgroundColor = "#FF0000";
design.buttonTwoBorderColor = "#6db76c";
design.buttonTwoBorderRadius = 0;
design.numberOfSessions = "3";
design.setResumeInDays = "1";
design.setNumberOfTimesPerSession = "6";

Notifyvisitors.shared.pushPermissionPrompt(design, (response) {
    print(response);
  },
);
```

## Session Control Parameters

### numberOfSessions

Determines how many app sessions the prompt should be shown after a user dismisses it.

A new session is created when:

* The app is launched for the first time.
* The user returns after 30 minutes of inactivity.

Example:

```dart
design.numberOfSessions = "3";
```

The prompt will appear for the next 3 sessions if the user continues to dismiss it.

---

### resumeInDays

Controls when the prompt should reappear after all configured sessions are exhausted.

Example:

```dart
design.setResumeInDays = "10";
```

The prompt will remain hidden for 10 days and become eligible to show again from the 11th day.

---

### setNumberOfTimesPerSession

Controls the maximum number of times the prompt can be shown within a single session.

```dart
design.setNumberOfTimesPerSession = "6";
```

---

<br>

# Option 3: Use Native Android Permission Prompt

If you prefer the standard Android system permission dialog, use:

```dart
Notifyvisitors.shared.nativePushPermissionPrompt().then((response) {
  print(response);
});
```

### Sample Response

```json
{
  "status": "success",
  "message": "Popup launched. User granted permission."
}
```

## Important

>Android generally allows notification permission requests only a limited number of times.

>If the user repeatedly denies permission, the application may need to redirect them to the device's notification settings page to enable notifications manually.

---

<br>

# Callback Responses

The callback from both Option 2 and Option 3 can return the following responses.

| Status  | Message                                                                        |
| ------- | ------------------------------------------------------------------------------ |
| Success | Push permission is already active on this device.                              |
| Success | Popup launched. User granted permission.                                       |
| Success | Push Notification Settings is enabled by default on Android versions below 13. |
| Success | Push Notification Settings is ON.                                              |
| Fail    | Popup launched. User denied NVECTA's custom permission prompt.                 |
| Fail    | Popup launched. User denied permission.                                        |
| Error   | Something went wrong with error `<error>`                                      |

---

<br>

# Recommended Approach

For the best user experience:

1. Show an educational screen explaining the benefits of notifications.
2. Display NVECTA's custom permission prompt (Option 2).
3. Trigger the Android system permission dialog.
4. If permission is denied, guide users to app notification settings.

This approach generally results in higher notification opt-in rates because users understand why the permission is being requested before seeing the system prompt.
