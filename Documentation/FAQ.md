# ReactivClipKit FAQ

## Dependencies

**Q: Do I need to install Sentry?**  
A: Yes. Sentry is required for error reporting. Add the Sentry package to your App Clip target, but you don't need to initialize it - ReactivClipKit handles this automatically.

## Initialization

**Q: What's the right way to initialize ReactivClipKit?**  
A: Initialize ReactivClipKit in your SwiftUI App's `init` method using `try ReactivClipInitialize()` within a try-catch block.

**Q: What happens if initialization fails?**  
A: The framework will throw a `ReactivClipInitError` with specific information about what went wrong.

**Q: Can I initialize the framework multiple times?**  
A: No. Subsequent initialization attempts will throw a `multipleInitialization` error.

## Features

**Q: Do I need to manually initialize Sentry?**  
A: No. ReactivClipKit handles all Sentry configuration internally when you pass `SentrySDK.self`. Don't call `SentrySDK.start()` yourself.

**Q: What's the minimum required setup?**  
A: Valid `appIdentifier`, `reactivEventsToken`, `appStoreID`, and `parentBundleIdentifier`. Sentry is optional but recommended.

**Q: How to customize the UI?**  
A: UI customization is managed through the Reactiv Dashboard.

**Q: Do I need to handle push notifications for ReactivClipKit?**  
A: Yes. Set up `UNUserNotificationCenterDelegate` in your AppDelegate and call `NotificationCenter.default.postNotificationTapped(response:)` from the `userNotificationCenter(_:didReceive:withCompletionHandler:)` method. This integration enables proper notification processing.

## Events

**Q: How do I receive events from ReactivClipKit?**  
A: Use the `ReactivClipEvents` interface to access the event publisher:
```swift
let publisher = ReactivClipEvents.publisher
publisher.on(.productViewed) { event in
    // Handle product viewed event
}
```

**Q: What event types are available?**  
A: ReactivClipKit provides events for product views, cart actions, checkout processes, screen navigation, and more. See the [API Reference](./API.md#event-types) for the complete list.

**Q: How do I access data from the events?**  
A: Events provide type-safe data through convenience properties:
```swift
publisher.on(.cartItemAdded) { event in
    if let cartData = event.cartItemAddedData {
        print("Cart ID: \(cartData.cartId)")
        // Access other properties...
    }
}
```

**Q: When should I set up event handlers?**  
A: Set up event handling after ReactivClipKit is initialized, typically in your App's init method or immediately after initialization.

**Q: Can I observe all events at once?**  
A: Yes, use the `onEvent` method to subscribe to all events:
```swift
ReactivClipEvents.publisher.onEvent { event in
    print("Received event: \(event.type.rawValue)")
    // Handle any event type
}
```

**Q: How do I unsubscribe from events?**  
A: Call `removeAllHandlers()` on the publisher:
```swift
ReactivClipEvents.publisher.removeAllHandlers()
```

## Troubleshooting

**Q: Why am I getting "Framework already initialized" warnings?**  
A: You're likely attempting to initialize the framework multiple times. Check your app lifecycle and ensure you're only initializing once in your App's `init`.

**Q: Why isn't my App Clip showing any content?**  
A: Verify your App ID and tokens are correct, and check for initialization errors in your logs.

**Q: How do I debug initialization issues?**  
A: Use proper error handling with try-catch and log any errors from initialization. Look for specific error types like `missingAppIdentifier` to pinpoint the issue.

**Q: How can I check if initialization was successful?**  
A: Call `ReactivClipIsInitialized()` which returns a boolean indicating status.

**Q: Why aren't notifications being processed?**  
A: Make sure your AppDelegate implements `UNUserNotificationCenterDelegate` and calls `NotificationCenter.default.postNotificationTapped(response:)` when notifications are tapped.

**Q: Why am I not receiving events from ReactivClipKit?**  
A: Ensure that you've set up event observers after ReactivClipKit is fully initialized. If you're setting up too early, events might not be captured properly.

---

For additional support, contact us at support@reactivapp.com 