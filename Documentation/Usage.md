# ReactivClipKit Usage Guide

## Prerequisites

Before integrating ReactivClipKit, ensure you have:

1. **Sentry Package**
   - Add the Sentry package to your App Clip target
   - Pass the Sentry SDK class to ReactivClipKit for error reporting

2. **App Clip Configuration**
   - Add `NSAppClipRequestEphemeralUserNotification` key set to `true` in your App Clip's Info.plist to enable notification permissions

## Recommended Integration Pattern

### 1. Create AppDelegate.swift for Notification Handling

```swift
// AppDelegate.swift
import UIKit
import ReactivClipKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set up notification handling for ReactivClipKit
        UNUserNotificationCenter.current().delegate = self

        return true
    }

    // REQUIRED: Forward notification taps to ReactivClipKit
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
import Sentry

@main
struct MyAppClip: App {
    // Connect AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        // Initialize ReactivClipKit
        do {
            try ReactivClipInitialize(
                appIdentifier: "your-app-id",
                reactivEventsToken: "your-events-token",
                appStoreID: "123456789",
                parentBundleIdentifier: "com.yourapp.bundle",
                sentrySDK: SentrySDK.self
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

## Working with Events

ReactivClipKit provides an event system that allows you to receive and respond to user interactions within your app. Events include product views, cart actions, checkout processes, and more.

### Event Handling

You can subscribe to events using the publisher interface:

```swift
// Access the event publisher
let publisher = ReactivClipEvents.publisher

// Subscribe to a specific event
publisher.on(.productViewed) { event in
    if let productData = event.productViewedData {
        // Handle product view event
        print("Product viewed: \(productData.productTitle)")
    }
}

// Subscribe to all events
publisher.onEvent { event in
    // Handle any event
    print("Event received: \(event.type)")
}
```

### Implementation Reference

For a complete implementation example of how to handle events, see the `AnalyticsManager` in the ReactivClipKit-SampleClip example app. This demonstrates best practices for:

- Setting up event subscriptions
- Processing different event types
- Extracting typed data from events
- Integrating with analytics platforms

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

## Multi-Store Initialization

If your brand operates multiple regional storefronts, you can initialize the framework once with an array of `StoreDescriptor` instances instead of a single store identifier.

```swift
let stores: [StoreDescriptor] = [
    StoreDescriptor(uuid: "intl-uuid", storeURL: "https://domain.com",    eventsToken: "token-intl"),
    StoreDescriptor(uuid: "ca-uuid",   storeURL: "https://domain.com/ca", eventsToken: "token-ca"),
    StoreDescriptor(uuid: "au-uuid",   storeURL: "https://domain.com/au", eventsToken: "token-au"),
    StoreDescriptor(uuid: "gb-uuid",   storeURL: "https://domain.com/gb", eventsToken: "token-gb")
]

try ReactivClipInitializeMultiStore(
    stores: stores,
    appStoreID: "123456789",
    parentBundleIdentifier: "com.yourapp.bundle",
    sentrySDK: SentrySDK.self
)
```

`ReactivClipKit` selects the descriptor whose `storeURL` is the longest prefix of the App Clip invocation URL. If no match is found the first descriptor in the array is used as a fallback.
