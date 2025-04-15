# ReactivClipKit Usage

## Basic Implementation

```swift
import SwiftUI
import ReactivClipKit

@main
struct MyAppClip: App {
    init() {
        ReactivClip.shared.initialize(
            appIdentifier: "your-app-id",
            reactivEventsToken: "your-events-token",
            firebaseSessionIDProvider: Analytics.sessionID,
            firebaseAppInstanceId: Analytics.appInstanceID(),
            appStoreID: "123456",
            parentBundleIdentifier: "com.yourapp.bundle"
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ReactivClipView()
        }
    }
}
```