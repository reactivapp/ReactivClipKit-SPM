# ReactivClipKit FAQ

## Initialization

**Q: What's the right way to initialize ReactivClipKit?**  
A: Initialize ReactivClipKit in your SwiftUI App's `init` method using `try ReactivClipInitialize()` within a try-catch block.

**Q: What happens if initialization fails?**  
A: The framework will throw a `ReactivClipInitError` with specific information about what went wrong.

**Q: Can I initialize the framework multiple times?**  
A: No. Subsequent initialization attempts will throw a `multipleInitialization` error.

## Features

**Q: What's the minimum required setup?**  
A: Valid `appIdentifier`, `reactivEventsToken`, `appStoreID`, and `parentBundleIdentifier`.

**Q: How to customize the UI?**  
A: UI customization is managed through the Reactiv Dashboard.

**Q: Do I need to handle push notifications for ReactivClipKit?**
A: Yes. For remote notifications functionality, this setup is required. Your AppDelegate needs three things: (1) set `UNUserNotificationCenter.current().delegate = self`, (2) call `application.registerForRemoteNotifications()` in `didFinishLaunchingWithOptions`, and (3) forward the device token via `NotificationCenter.default.postDeviceTokenReceived(deviceToken:)` in `didRegisterForRemoteNotificationsWithDeviceToken`. Also forward notification taps via `NotificationCenter.default.postNotificationTapped(response:)`. See the [Usage Guide](./Usage.md) for the full AppDelegate example.

**Q: Does ReactivClipKit call `application.registerForRemoteNotifications()` automatically?**
A: No. You must call `application.registerForRemoteNotifications()` in your App Clip host app (typically in `didFinishLaunchingWithOptions`).

**Q: What are initialization options?**
A: Both initializers accept an optional `initializationOptions` dictionary for advanced configuration. Current keys: `CARTLESS_MODE` (Bool, disables cart), `REACTIV_FULL_APP_MODE` (Bool, set to `true` when embedding in a full iOS app — see [Full App Integration](./FullAppIntegration.md)). See the [API Reference](./API.md#initialization-options) for details.

## Full App Integration (2.3+)

**Q: Can I embed ClipKit into my existing iOS app?**
A: Yes, starting with ClipKit **2.3**. Set `"REACTIV_FULL_APP_MODE": true` in `initializationOptions` and wrap your root view in `ReactivClipHost { MyHostHomeScreen() }`. When a Reactiv-owned URL or push notification arrives, ClipKit presents the commerce experience as a full-screen cover over your host content. See the full guide: [Full App Integration](./FullAppIntegration.md).

**Q: Does the host app need to write `.onOpenURL` or `.onContinueUserActivity`?**
A: No — `ReactivClipHost` uses those modifiers internally. Any URL delivered to the scene is validated (only `https://appclip.apple.com/...` accepted) and routed into ClipKit automatically.

**Q: Does the host app need AppDelegate URL methods (`application(_:open:)`, `application(_:continue:)`)?**
A: No. In SwiftUI apps, those would fire in parallel with SwiftUI's modifiers and double-handle. SwiftUI's `.onOpenURL` — which `ReactivClipHost` uses internally — is the idiomatic hook.

**Q: What happens if the user taps a Reactiv push when the host app is in a different screen?**
A: `ReactivClipHost` uses `fullScreenCover` to present the Clip — your host view tree stays mounted beneath. When the user dismisses, they return to the exact screen they were on.

**Q: What URL format triggers ClipKit from the host?**
A: `https://appclip.apple.com/id?p=<your-clip-bundle>&action=<action>[&<param>=<value>]`.

**Q: What if a user taps a merchant-domain URL (App Clip Experience URL) instead of the appclip.apple.com URL?**
A: ClipKit only routes `appclip.apple.com` URLs automatically. Merchant-domain URLs (e.g., `https://shop.yourcompany.com/products/foo`) belong to your app's own navigation. If you want ClipKit to handle a specific merchant URL, translate it to the `appclip.apple.com` equivalent in your own `.onOpenURL` handler and call `NotificationCenter.default.forwardInvocationURL(translatedURL)` explicitly.

**Q: How do I present the Clip differently — as a sheet instead of full screen?**
A: Use the advanced manual integration pattern (opt out of `ReactivClipHost`). Wire `.onOpenURL` / `.onContinueUserActivity` yourself, forward via `NotificationCenter.default.forwardInvocationURL(url)`, hold a `@State var showClipKit: Bool`, and present `ReactivClipView()` via whatever SwiftUI modifier fits — `.sheet`, `.navigationDestination`, custom overlay. See [Full App Integration — Advanced](./FullAppIntegration.md#advanced-opt-out-of-reactivcliphost).

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

**Q: How do I test a landing page locally (e.g. `pages/test`)?**  
A: Run the App Clip with an invocation URL that points at the landing page URL. In Xcode, open **Edit Scheme…** → **Run** → **Arguments** → **Environment Variables**, then enable `_XCAppClipURL` and set it to a full URL like `https://<your-store-domain>/pages/test`. If you see a fallback (“Oops”) screen, confirm the landing page has been published from the Reactiv Dashboard and relaunch the App Clip.

**Q: How do I debug initialization issues?**  
A: Use proper error handling with try-catch and log any errors from initialization. Look for specific error types like `missingAppIdentifier` to pinpoint the issue.

**Q: How can I check if initialization was successful?**  
A: Call `ReactivClipIsInitialized()` which returns a boolean indicating status.

**Q: Why aren't push notifications working?**
A: Verify all three AppDelegate requirements: (1) `UNUserNotificationCenter.current().delegate = self`, (2) `application.registerForRemoteNotifications()`, and (3) `NotificationCenter.default.postDeviceTokenReceived(deviceToken:)` in the device token callback. Missing any of these will prevent remote notifications functionality from working.

**Q: Why aren't notification taps being tracked?**
A: Make sure your AppDelegate calls `NotificationCenter.default.postNotificationTapped(response:)` in the `userNotificationCenter(_:didReceive:withCompletionHandler:)` method.

**Q: Why am I not receiving events from ReactivClipKit?**  
A: Ensure that you've set up event observers after ReactivClipKit is fully initialized. If you're setting up too early, events might not be captured properly.

---

For additional support, contact us at support@reactivapp.com
