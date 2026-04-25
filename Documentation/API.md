# ReactivClipKit API Reference

## Initialization

```swift
// Initialize the framework (throws on error)
try ReactivClipInitialize(
    appIdentifier: String,                      // Required: Your Reactiv App ID
    reactivEventsToken: String,                 // Required: Your analytics token
    appStoreID: String,                         // Required: App Store Connect ID
    parentBundleIdentifier: String,             // Required: Parent app's bundle ID
    initializationOptions: [String: Any]? = nil // Optional: See Initialization Options below
)
```

## Initialization Status

```swift
// Check if framework is initialized
let isInitialized: Bool = ReactivClipIsInitialized()
```

## Main View Component

```swift
// Use as the main view in your App Clip (standalone integration)
ReactivClipView()
```

## Full App Host Container (2.3+)

For embedding ClipKit in an existing iOS SwiftUI app — wraps your host content and presents the Clip experience as a full-screen cover when a Reactiv URL or push arrives. Dismiss signals observed automatically.

```swift
public struct ReactivClipHost<HostContent: View>: View {
    public init(@ViewBuilder hostContent: @escaping () -> HostContent)
}

// Usage:
ReactivClipHost {
    MyHostHomeScreen()
}
```

Behavior:

- Renders `hostContent()` by default
- Observes valid invocation URLs and Reactiv push taps → presents `ReactivClipView()` as `.fullScreenCover`
- Observes `ReactivClipCommands.publisher` for `.clipDismissRequested` → dismisses the cover
- Drains cold-start URL/push buffers on first appear — no lost invocations during app launch
- Only valid if `REACTIV_FULL_APP_MODE: true` was set at init

See [Full App Integration](./FullAppIntegration.md) for complete setup.

## Invocation URL Forwarding (2.3+)

Forward a URL to ClipKit's invocation pipeline. Validates scheme and host; non-matching URLs silently dropped with a warning log.

```swift
// Accepts only https://appclip.apple.com/... URLs; everything else silently dropped
NotificationCenter.default.forwardInvocationURL(_ url: URL)
```

You typically don't call this yourself — `ReactivClipHost` calls it internally for URLs delivered via `.onOpenURL` / `.onContinueUserActivity`. Direct calls are useful for manual integration (advanced).

## Notification Handling

### Standalone App Clip integration

```swift
// Forward notification taps (call from UNUserNotificationCenterDelegate's didReceive)
NotificationCenter.default.postNotificationTapped(response: UNNotificationResponse)
```

### Full App integration (2.3+)

```swift
// Inspects the push payload for Reactiv-owned notifications:
// - Reactiv push: routed into ClipKit; ReactivClipHost presents the Clip
// - Anything else: ifNotReactiv runs so your app handles it
NotificationCenter.default.handleReactivNotificationTap(
    response: UNNotificationResponse,
    ifNotReactiv: @escaping () -> Void = {}
)
```

## Push Token Forwarding

```swift
// ReactivClipKit does not call application.registerForRemoteNotifications() for you.
// Required for remote notifications functionality.
// Forward the APNs device token to ReactivClipKit for push notification registration.
// Call from application(_:didRegisterForRemoteNotificationsWithDeviceToken:)
NotificationCenter.default.postDeviceTokenReceived(deviceToken: Data)
```

## Commands Publisher (2.3+)

Control-signal stream — separate from the analytics events publisher. Used for host apps to observe presentation control signals like dismiss.

```swift
import Combine

public enum ReactivClipCommands {
    public static var publisher: AnyPublisher<ReactivClipCommand, Never> { get }
}

public struct ReactivClipCommand: Equatable {
    public let type: ReactivClipCommandType
    public let timestamp: Date
}

public enum ReactivClipCommandType: String, CaseIterable, Codable {
    case clipDismissRequested
}
```

Example — react to dismiss yourself (only if you opted out of `ReactivClipHost`, which observes this internally):

```swift
let subscription = ReactivClipCommands.publisher
    .filter { $0.type == .clipDismissRequested }
    .sink { _ in
        // User tapped the dismiss chevron in the Clip's toolbar
    }
```

Delivered on the main queue.

---

## Event Handling

ReactivClipKit provides a robust event system with strongly-typed data models.

### Accessing the Event Publisher

```swift
// Access the event publisher through the official public interface
let publisher = ReactivClipEvents.publisher

// Subscribe to a specific event type
publisher.on(.productViewed) { event in
    // Handle event
}

// Subscribe to all events
publisher.onEvent { event in
    // Handle any event
}

// Remove all event handlers
publisher.removeAllHandlers()
```

### Event Types

ReactivClipKit exposes these event types:

```swift
// Available event types
enum ReactivClipEventType: String {
    // Product events
    case productViewed
    case productShared

    // Cart events
    case cartItemAdded
    case cartItemRemoved
    case cartItemUpdated
    case cartView

    // Checkout events
    case checkoutStarted
    case checkoutSuccess
    case checkoutFailed

    // App events
    case screenViewed
    case notificationOpened
    case notificationScheduled
    case applicationOpened

    // Collection events
    case collectionViewed

    // UI interaction events
    case buttonTapped
    case searchFocus
    case searchApplied

    // Custom events
    case custom
}
```

### Accessing Typed Event Data

ReactivClipKit provides typed data models for each event type:

```swift
// Using convenience properties (recommended)
publisher.on(.productViewed) { event in
    if let productData = event.productViewedData {
        let productId = productData.productId
        let productTitle = productData.productTitle
        let productPrice = productData.productPrice

        // Use typed data...
    }
}

// Generic access method
publisher.on(.cartItemAdded) { event in
    if let cartData: CartItemAddedData = event.typedData() {
        // Use typed data...
    }
}
```

## Error Types

The initialization can throw the following errors:

```swift
// Possible initialization errors
enum ReactivClipInitError: Error {
    case missingAppIdentifier    // App ID is empty or invalid
    case missingEventsToken      // Analytics token is missing
    case missingAppStoreID       // App Store ID is missing
    case missingParentBundleID   // Parent bundle ID is missing
    case multipleInitialization  // Framework already initialized
}
```

## Initialization Options

Both initializers accept an optional `initializationOptions` dictionary:

| Key                     | Type   | Default | Description                                                                                                            |
| ----------------------- | ------ | ------- | ---------------------------------------------------------------------------------------------------------------------- |
| `CARTLESS_MODE`         | `Bool` | `false` | Disables cart functionality (hides cart button; toast no longer opens cart)                                            |
| `REACTIV_FULL_APP_MODE` | `Bool` | `false` | Set to `true` when embedding ClipKit in an existing full iOS app. See [Full App Integration](./FullAppIntegration.md). |

```swift
try ReactivClipInitialize(
    appIdentifier: "your-app-id",
    reactivEventsToken: "your-events-token",
    appStoreID: "123456789",
    parentBundleIdentifier: "com.yourapp.bundle",
    initializationOptions: [
        "CARTLESS_MODE": true
    ]
)
```

## Multi-Store Initializer

```swift
// Initialize the framework for multiple storefronts (throws on error)
try ReactivClipInitializeMultiStore(
    stores: [StoreDescriptor],                  // Required: descriptors for each storefront
    appStoreID: String,                         // Required: App Store Connect ID
    parentBundleIdentifier: String,             // Required: Parent app's bundle ID
    initializationOptions: [String: Any]? = nil // Optional: See Initialization Options above
)
```

### StoreDescriptor

```swift
public struct StoreDescriptor {
    public let uuid: String       // Store UUID from Reactiv Dashboard
    public let storeURL: String   // Store URL (e.g., "https://domain.com/ca")
    public let eventsToken: String // Analytics token for this store
}
```

The framework selects the descriptor whose `storeURL` is the longest prefix of the App Clip invocation URL. If no match is found, the first descriptor is used as a fallback.
