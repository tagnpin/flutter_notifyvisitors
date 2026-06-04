# Flutter User Tracking Guide

This document explains how to identify and track users in your Flutter application using the NVECTA Flutter SDK.

Official Documentation: <br>
https://www.nvecta.com/docs/flutter-tracking-users

---

<br>

# What is User Tracking?

User tracking allows you to associate app activity, events, purchases, and engagement data with a specific user profile.

By identifying users, you can:

- Build unified customer profiles
- Personalize campaigns and notifications
- Track user journeys across sessions
- Segment users based on behavior
- Measure retention and engagement

In NVECTA, user profiles are created automatically and can later be linked to known user information such as email, mobile number, customer ID, or other identifiers.

---

<br>

# Basic User Tracking Flow

```text
User Registers / Logs In
          ↓
Flutter Application
          ↓
Identify User
          ↓
NVECTA User Profile Updated
          ↓
Events & Campaigns Linked To User
```

Example:

```text
User signs up
      ↓
Set Email & Mobile Number
      ↓
NVECTA creates/updates user profile
      ↓
Future events are mapped to the same user
```

---

# Step 1: Import Flutter Package

```dart
import 'package:flutter_notifyvisitors/flutter_notifyvisitors.dart';
```

---

<br>

# Step 2: Create User Profile

Use the User Tracking API after user login or registration.

```dart
var attributes = {"email": "john@example.com","mobile": "9876543210","name": "John Doe"};
Notifyvisitors.shared.setUserIdentifier(attributes).then((response) {
    print(response);
});
```

---

<br>

# Common User Attributes

The following attributes are commonly used while identifying users.

| Attribute | Description |
|------------|-------------|
| email | User email address |
| mobile | Mobile number |
| name | Full name |
| userID | Unique customer identifier |
| gender | User gender |
| city | User city |
| country | User country |
| subscription_type | Current plan |
| customer_type | Premium, Free, etc. |

---

<br>

# Step 3: Track Additional User Attributes

You can enrich user profiles with custom attributes.

```dart
var attributes = {
    "email": "john@example.com",
    "name": "John Doe",
    "city": "Delhi",
    "plan": "Premium",
    "customer_type": "Gold"
  };
Notifyvisitors.shared.setUserIdentifier(attributes).then((response) {
    print(response);
  }
);
```

---

<br>

# User Profile Best Practices

### Identify Users After Login

Always call user tracking after successful login or signup.

```text
Login Success
      ↓
Track User
      ↓
Track Events
```

---

### Use Consistent Identifiers

Use the same email, mobile number, or customer ID across sessions.

```text
Good:
john@example.com

Bad:
john@gmail.com
john.doe@gmail.com
```

---

### Update User Properties When Changed

Whenever user details change, update the profile again.

Examples:

- Email updated
- Mobile number changed
- Subscription upgraded
- User moved to another city

---

<br>

# Example: User Registration

```dart
var attributes = {"name":"John Doe","email":"john@example.com","mobile":"9876543210"};
Notifyvisitors.shared.setUserIdentifier(attributes).then((response) {
    print(response);
});
```

After this, any event tracked by the SDK becomes associated with the identified user profile.

---

<br>

# Example: Subscription Upgrade

```dart
var attributes = {"email": "john@example.com","subscription_type": "Premium","membership_status": "Active"};
Notifyvisitors.shared.setUserIdentifier(attributes).then((response) {
    print(response);
});
```

---

## User Tracking Callback Response

| STATUS | MESSAGE | TYPE |
|----------|----------|----------|
| Success | User profile updated successfully | `0` |
| Fail | Invalid user data found | `1` |
| Fail | Context not found | `2` |
| Fail | Authentication failed | `3` |
| Fail | No internet connection found | `4` |
| Fail | User tracking disabled from panel | `5` |
| Fail | Internal processing error | `6` |

<br>

# Verify User Tracking

## From Flutter Terminal

Run:

```bash
flutter run
```

Look for user tracking logs:

```text
I/NotifyVisitors-Flutter: SET USER IDENTIFIER !!
I/NotifyVisitors-Flutter:  !! ATTRIBUTES : {"name":"Ram"}
I/flutter: User Response = {"status":"success","message":"User registered successfully","type":13.9}
```

---

## From Android Studio Logcat

Open:

```text
Android Studio → Logcat
```

Filter using:

```text
NotifyVisitors
```

Example logs:

```text
SET USER IDENTIFIER !!
!! ATTRIBUTES : {"name":"Ram"}
```

---

<br>

# Recommended Flow

```text
App Launch
    ↓
User Login
    ↓
Track User Profile
    ↓
Track Custom Events
    ↓
Send Push Notifications
    ↓
Create User Segments
```

---

# Best Practices

- Track users immediately after login/signup
- Always use a unique identifier
- Keep profile information updated
- Avoid storing sensitive information
- Maintain consistent attribute naming
- Use custom attributes for segmentation

---

<br>

# Common Use Cases

## User Signup

```dart
Notifyvisitors.shared.setUserIdentifier({"email": "john@example.com","name": "John Doe"}).then((response) {});
```

---

## User Login

```dart
Notifyvisitors.shared.setUserIdentifier({"userID": "12345","email": "john@example.com"}).then((response) {});
```

---

## Premium Subscription

```dart
Notifyvisitors.shared.setUserIdentifier({"userID": "12345","subscription": "Premium"}).then((response) {});
```

---

<br>

# Summary

User tracking enables NVECTA to create a unified customer profile by linking user attributes, events, purchases, and engagement activities to a single user.

With proper user identification, you can:

- Build customer profiles
- Segment audiences
- Personalize campaigns
- Improve retention
- Analyze customer behavior

