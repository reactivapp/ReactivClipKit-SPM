# ReactivClipKit

A Swift framework for integrating Reactiv Clip experiences into iOS App Clips.

## Installation

Add the following dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/reactivapp/ReactivClipKit-SPM.git", from: "1.0.0")
]
```

Or add it directly through Xcode:
1. File > Add Packages...
2. Enter repository URL: `https://github.com/reactivapp/ReactivClipKit-SPM.git`
3. Select version requirements and target

## Required Dependencies

### 1. Sentry

Add Sentry to your App Clip target:

```swift
dependencies: [
    .package(url: "https://github.com/getsentry/sentry-cocoa", from: "8.0.0")
]
```

**Note:** ReactivClipKit will handle Sentry initialization automatically.

### 2. Firebase Analytics

Add Firebase to your App Clip target:

1. Follow the [official Firebase iOS SDK installation guide](https://firebase.google.com/docs/ios/setup)
2. Add Firebase Analytics to your App Clip target
3. Pass Firebase session information during ReactivClipKit initialization

## Quick Start

### Step 1: Configure Firebase

Your App Clip needs to configure Firebase before initializing ReactivClipKit. Create an AppDelegate.swift file for this purpose:

```swift
// AppDelegate.swift
import UIKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure Firebase
        FirebaseApp.configure()
        return true
    }
}
```

### Step 2: Initialize ReactivClipKit in App's init

```swift
// MyAppClip.swift
import SwiftUI
import ReactivClipKit
import FirebaseAnalytics

@main
struct MyAppClip: App {
    // Connect AppDelegate to configure Firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        // Initialize ReactivClipKit
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
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ReactivClipView()
        }
    }
}
```

## Requirements

- iOS 16.0+
- Xcode 14.0+
- Swift 5.7+

## Documentation

See the [Documentation folder](./Documentation) for detailed guides:

- [Usage Guide](./Documentation/Usage.md)
- [API Reference](./Documentation/API.md)
- [FAQ](./Documentation/FAQ.md)

## Support

For support inquiries, contact us at support@reactivapp.com

## License

ReactivClipKit is proprietary software. Please contact Reactiv for licensing details.
