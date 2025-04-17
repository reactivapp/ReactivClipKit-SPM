# ReactivClipKit API Reference

## Initialization

```swift
// Initialize the framework (throws on error)
try ReactivClipInitialize(
    appIdentifier: String,          // Required: Your Reactiv App ID
    reactivEventsToken: String,     // Required: Your analytics token
    firebaseSessionIDProvider: FirebaseSessionIDProvider? = nil,  // Optional: Firebase session callback
    firebaseAppInstanceId: String? = nil,                        // Optional: Firebase instance ID
    appStoreID: String,            // Required: App Store Connect ID
    parentBundleIdentifier: String  // Required: Parent app's bundle ID
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

