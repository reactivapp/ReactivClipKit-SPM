# ReactivClipKit API

## ReactivClip

```swift
// Initialize the framework
ReactivClip.shared.initialize(
    appIdentifier: String,
    reactivEventsToken: String,
    firebaseSessionIDProvider: (() -> String?)?,  // Optional
    firebaseAppInstanceId: String?,              // Optional
    appStoreID: String,
    parentBundleIdentifier: String
)
```

## ReactivClipView

```swift
// Use as the main view in your app
ReactivClipView()
```
