# ReactivClipKit

Swift Package Manager distribution for ReactivClipKit - a framework to integrate Reactiv Clip into iOS App Clips.

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/your-org/ReactivClipKit-SPM.git", from: "1.0.0")
]
```

## Quick Start

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

## Requirements

- iOS 16.0+
- Xcode 12.0+
- Swift 5.3+

## License

ReactivClipKit is a proprietary framework. Contact Reactiv for licensing details.

## Support

For support inquiries, please contact us at support@reactivapp.com
