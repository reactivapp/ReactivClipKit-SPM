# ReactivClipKit

A Swift framework for integrating Reactiv Clip experiences into iOS App Clips.

## Installation

Add the following dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/reactivapp/ReactivClipKit-SPM.git", from: "1.0.0")
]
```

Or add it directly through Xcode:
1. File > Add Packages...
2. Enter repository URL: `https://github.com/reactivapp/ReactivClipKit-SPM.git`
3. Select version requirements and target

## Required Dependencies

### 1. Sentry

Add Sentry to your App Clip target:

```swift
dependencies: [
    .package(url: "https://github.com/getsentry/sentry-cocoa", from: "8.0.0")
]
```

**Note:** ReactivClipKit will handle Sentry initialization automatically.

## Quick Start

### 📹 Integration Tutorial Video

For a complete step-by-step visual guide, watch our integration tutorial:

**[ReactivClipKit Integration Tutorial](https://drive.google.com/file/d/1w1gd9TzY35dkec0mh_TIA53DD5iE66Dk/view?usp=sharing)**

This video covers the entire integration process from setup to implementation.

### Step 1: Initialize ReactivClipKit in App's init

```swift
// MyAppClip.swift
import SwiftUI
import ReactivClipKit

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
                parentBundleIdentifier: "com.yourapp.bundle"
            )
        } catch {
            print("ReactivClipKit initialization failed: \(error)")
        }
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
- Xcode 14.0+
- Swift 5.7+

## Documentation

See the [Documentation folder](./Documentation) for detailed guides:

- [Usage Guide](./Documentation/Usage.md)
- [API Reference](./Documentation/API.md)
- [FAQ](./Documentation/FAQ.md)

## Support

For support inquiries, contact us at support@reactivapp.com

## License

ReactivClipKit is proprietary software. Please contact Reactiv for licensing details.
