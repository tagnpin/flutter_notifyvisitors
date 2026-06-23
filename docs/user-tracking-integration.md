# Flutter User Tracking Guide

This document explains how to identify and track users in your Flutter application using the NVECTA Flutter SDK.

Official Documentation: <br>
https://www.nvecta.com/docs/flutter-tracking-users

---


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

# Event Tracking After User Identification

## Overview

To ensure events are properly mapped to user profiles on the NVECTA panel, you must wait for the user identification callback response before triggering any events. 

**Important:** If you call event tracking and user identification in parallel, the SDK may not be able to merge the data correctly on the panel because the user profile hasn't been fully synchronized yet.

---

## Correct Implementation Flow

```text
User Login Triggered
       ↓
Call setUserIdentifier()
       ↓
Wait for Callback Response
       ↓
Check Response Status
       ↓
If Success: Track Events
       ↓
Events Get Mapped to User Profile
```

---

## Implementation: Wait for User Identification Before Events

**DO NOT do this (Parallel calls):**

```dart
// ❌ WRONG - Events triggered in parallel
void handleLogin(String email) {
    // User identification
    Notifyvisitors.shared.setUserIdentifier({"email": email}).then((response) {
        print(response);
    });
    
    // Event triggered immediately (before user sync completes)
    Notifyvisitors.shared.trackEvent("login_successful", {}).then((response) {
        print(response);
    });
}
```

In this approach, the event may be tracked before the user profile is fully synchronized, resulting in the event not being associated with the correct user on the NVECTA panel.

---

**DO this instead (Sequential calls):**

```dart
// ✅ CORRECT - Wait for user identification callback
void handleLogin(String email) {
    var userAttributes = {"email": email, "name": "John Doe"};
    
    // Step 1: Identify User
    Notifyvisitors.shared.setUserIdentifier(userAttributes).then((response) {
        print("User Response: $response");
        
        // Step 2: Check if user identification was successful
        if (response != null && response['status'] == 'success') {
            // Step 3: Only then track the event
            _trackLoginEvent();
        } else {
            print("User identification failed: $response");
        }
    }).catchError((error) {
        print("Error identifying user: $error");
    });
}

// Step 4: Track event in a separate function
void _trackLoginEvent() {
    var eventData = {
        "login_method": "email",
        "timestamp": DateTime.now().toString()
    };
    
    Notifyvisitors.shared.trackEvent("login_successful", eventData).then((response) {
        print("Event tracked: $response");
    }).catchError((error) {
        print("Error tracking event: $error");
    });
}
```

---

## Advanced Implementation: Using Async/Await

For cleaner code, use async/await pattern to handle sequential operations:

```dart
// ✅ CLEAN - Using async/await
Future<void> handleLoginWithAwait(String email, String password) async {
    try {
        // Step 1: Call setUserIdentifier and wait for response
        var identifyResponse = await Notifyvisitors.shared.setUserIdentifier({
            "email": email,
            "name": "User Name"
        });
        
        print("User identification response: $identifyResponse");
        
        // Step 2: Verify success before proceeding
        if (identifyResponse != null && identifyResponse['status'] == 'success') {
            // Step 3: Now safely track the event
            var eventResponse = await Notifyvisitors.shared.trackEvent(
                "login_successful",
                {
                    "email": email,
                    "timestamp": DateTime.now().toString(),
                    "login_method": "email"
                }
            );
            
            print("Event tracked successfully: $eventResponse");
        } else {
            print("User identification failed, event not tracked");
        }
    } catch (e) {
        print("Error during login process: $e");
    }
}
```

---

## Practical Example: User Registration with Event Tracking

```dart
Future<void> registerNewUser(String name, String email, String mobile) async {
    try {
        // Step 1: Identify the user with registration details
        print("Identifying user...");
        var identifyResponse = await Notifyvisitors.shared.setUserIdentifier({
            "name": name,
            "email": email,
            "mobile": mobile,
            "registration_date": DateTime.now().toString()
        });
        
        // Step 2: Validate response
        if (identifyResponse == null || identifyResponse['status'] != 'success') {
            print("Failed to identify user");
            return;
        }
        
        print("User identified successfully");
        
        // Step 3: Track registration event
        var eventResponse = await Notifyvisitors.shared.trackEvent(
            "user_registration",
            {
                "name": name,
                "email": email,
                "mobile": mobile,
                "registration_source": "app",
                "timestamp": DateTime.now().toString()
            }
        );
        
        print("Registration event tracked: $eventResponse");
        
        // Step 4: Optional - Track additional event
        await _trackUserOnboardingStarted(email);
        
    } catch (e) {
        print("Error during user registration: $e");
    }
}

Future<void> _trackUserOnboardingStarted(String email) async {
    try {
        var response = await Notifyvisitors.shared.trackEvent(
            "onboarding_started",
            {"email": email}
        );
        print("Onboarding event tracked: $response");
    } catch (e) {
        print("Error tracking onboarding event: $e");
    }
}
```

---

## Event Tracking After User Properties Update

When updating user properties (e.g., subscription upgrade), follow the same pattern:

```dart
Future<void> upgradeSubscription(String userEmail, String newPlan) async {
    try {
        // Step 1: Update user properties
        var updateResponse = await Notifyvisitors.shared.setUserIdentifier({
            "email": userEmail,
            "subscription_type": newPlan,
            "subscription_updated_at": DateTime.now().toString()
        });
        
        if (updateResponse != null && updateResponse['status'] == 'success') {
            // Step 2: Track the upgrade event
            await Notifyvisitors.shared.trackEvent(
                "subscription_upgraded",
                {
                    "email": userEmail,
                    "new_plan": newPlan,
                    "upgrade_date": DateTime.now().toString()
                }
            );
            
            print("Subscription upgraded and event tracked");
        }
    } catch (e) {
        print("Error upgrading subscription: $e");
    }
}
```

---

## Key Takeaways

1. **Always wait for `setUserIdentifier()` callback** before tracking events
2. **Check the response status** to ensure user identification was successful
3. **Use async/await pattern** for cleaner, more maintainable code
4. **Verify response is not null** before accessing its properties
5. **Handle errors gracefully** with try-catch blocks
6. **Track events only after user sync completes** to ensure proper mapping on NVECTA panel

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
Wait for Response
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
- **Wait for user identification callback before tracking events**
- **Check response status before proceeding**
- **Use async/await for sequential operations**

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

**Remember:** Always wait for the user identification callback response before tracking events to ensure proper data synchronization and event mapping on the NVECTA panel.
