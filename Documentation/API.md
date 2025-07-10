# ReactivClipKit API Reference

## Initialization

```swift
// Initialize the framework (throws on error)
try ReactivClipInitialize(
    appIdentifier: String,          // Required: Your Reactiv App ID
    reactivEventsToken: String,     // Required: Your analytics token
    appStoreID: String,            // Required: App Store Connect ID
    parentBundleIdentifier: String, // Required: Parent app's bundle ID
    sentrySDK: AnyClass? = nil     // Sentry SDK class for error reporting
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
// Extension on NotificationCenter for handling notification taps
// Call this from UNUserNotificationCenterDelegate's didReceive method
NotificationCenter.default.postNotificationTapped(response: UNNotificationResponse)
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
    case applicationOpened

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

### Multi-Store initializer

```swift
// Initialize the framework for multiple storefronts (throws on error)
try ReactivClipInitializeMultiStore(
    stores: [StoreDescriptor],         // Required: descriptors for each storefront
    appStoreID: String,               // Required: App Store Connect ID
    parentBundleIdentifier: String,   // Required: Parent app's bundle ID
    sentrySDK: AnyClass? = nil        // Sentry SDK class for error reporting
)
```
