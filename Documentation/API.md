# ReactivClipKit API Reference

## Initialization

```swift
// Initialize the framework (throws on error)
try ReactivClipInitialize(
    appIdentifier: String,                      // Required: Your Reactiv App ID
    reactivEventsToken: String,                 // Required: Your analytics token
    appStoreID: String,                         // Required: App Store Connect ID
    parentBundleIdentifier: String,             // Required: Parent app's bundle ID
    sentrySDK: AnyClass? = nil,                 // Sentry SDK class for error reporting
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
// Use as the main view in your App Clip
ReactivClipView()
```

## Notification Handling

```swift
// Forward notification taps to ReactivClipKit (call from UNUserNotificationCenterDelegate's didReceive)
NotificationCenter.default.postNotificationTapped(response: UNNotificationResponse)
```

## Push Token Forwarding

```swift
// Forward the APNs device token to ReactivClipKit for push notification registration
// Call from application(_:didRegisterForRemoteNotificationsWithDeviceToken:)
NotificationCenter.default.postDeviceTokenReceived(deviceToken: Data)
```

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

| Key             | Type   | Default | Description                                                 |
| --------------- | ------ | ------- | ----------------------------------------------------------- |
| `CARTLESS_MODE` | `Bool` | `false` | Disables cart functionality (hides cart button; toast no longer opens cart) |

```swift
try ReactivClipInitialize(
    appIdentifier: "your-app-id",
    reactivEventsToken: "your-events-token",
    appStoreID: "123456789",
    parentBundleIdentifier: "com.yourapp.bundle",
    sentrySDK: SentrySDK.self,
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
    sentrySDK: AnyClass? = nil,                 // Sentry SDK class for error reporting
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