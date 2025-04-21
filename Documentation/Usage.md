# ReactivClipKit Usage Guide

## Prerequisites

Before integrating ReactivClipKit, ensure you have:

1. **Sentry Package**
   - Add the Sentry package to your App Clip target
   - No manual initialization needed - ReactivClipKit handles this automatically
   ```swift
   dependencies: [
       .package(url: "https://github.com/getsentry/sentry-cocoa", from: "8.0.0")
   ]
   ```

2. **Firebase Analytics**
   - Firebase is required for app functionality
   - Follow the [official Firebase iOS SDK setup guide](https://firebase.google.com/docs/ios/setup)
   - Firebase must be configured before ReactivClipKit initialization

## Recommended Integration Pattern

### 1. Create AppDelegate.swift for Firebase Configuration and Notification Handling

```swift
// AppDelegate.swift
import UIKit
import FirebaseCore
import ReactivClipKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure Firebase
        FirebaseApp.configure()
        
        // Set up notification handling for ReactivClipKit analytics
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    // REQUIRED: Forward notification taps to ReactivClipKit for analytics
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        // This notifies ReactivClipKit about notification interactions
        NotificationCenter.default.postNotificationTapped(response: response)
        completionHandler()
    }
}
```

### 2. Initialize ReactivClipKit in the App's init method

```swift
// MyAppClip.swift
import SwiftUI
import ReactivClipKit
import FirebaseAnalytics

@main
struct MyAppClip: App {
    // Connect AppDelegate for Firebase configuration
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        // Initialize ReactivClipKit after Firebase is configured
        do {
            try ReactivClipInitialize(
                appIdentifier: "your-app-id",
                reactivEventsToken: "your-events-token",
                firebaseSessionIDProvider: Analytics.sessionID,
                firebaseAppInstanceId: Analytics.appInstanceID(),
                appStoreID: "123456789",
                parentBundleIdentifier: "com.yourapp.bundle"
            )
        } catch {
            print("ReactivClipKit initialization failed: \(error)")
            // Handle initialization failure
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ReactivClipView()
        }
    }
}
```


## Error Handling

ReactivClipKit initialization can throw errors if parameters are missing or invalid. Always use try-catch for proper error handling. Common errors include:

- `missingAppIdentifier`: App ID is empty or invalid
- `missingEventsToken`: Analytics token is missing
- `missingAppStoreID`: App Store ID is missing
- `missingParentBundleID`: Parent bundle ID is missing
- `multipleInitialization`: Framework already initialized

## Checking Initialization Status

You can verify if ReactivClipKit has been properly initialized:

```swift
if ReactivClipIsInitialized() {
    // Framework is ready to use
} else {
    // Framework not initialized yet
}
```