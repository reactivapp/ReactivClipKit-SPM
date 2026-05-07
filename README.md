# ReactivClipKit

A Swift package that brings Reactiv's rich commerce experiences to iOS App Clips.

---

## ✨ Features

- Plug-and-play App Clip storefront powered by Reactiv
- **NEW in 2.3: Full App embedding** — drop ClipKit into your existing iOS app; Reactiv URLs and pushes present the Clip experience inside your app
- Built-in analytics stream with typed events
- Single-store **and** multi-store initialization modes

---

## 📦 Installation (Swift Package Manager)

```swift
.dependencies = [
    .package(url: "https://github.com/reactivapp/ReactivClipKit-SPM.git", from: "2.0.0")
]
```

Add the package in **Xcode → File → Add Packages…** and select the **ReactivClipKit** product for your App Clip target.

---

## 🚀 Quick start

### 1 · Single-store initialization

```swift
try ReactivClipInitialize(
    appIdentifier: "your-reactiv-app-id",
    reactivEventsToken: "your-events-token",
    appStoreID: "123456789",
    parentBundleIdentifier: "com.yourapp.bundle"
)
```

### 2 · Multi-store initialization

```swift
let stores: [StoreDescriptor] = [
    StoreDescriptor(uuid: "intl-uuid", storeURL: "https://domain.com",    eventsToken: "token-intl"),
    StoreDescriptor(uuid: "ca-uuid",   storeURL: "https://domain.com/ca", eventsToken: "token-ca"),
    StoreDescriptor(uuid: "au-uuid",   storeURL: "https://domain.com/au", eventsToken: "token-au"),
    StoreDescriptor(uuid: "gb-uuid",   storeURL: "https://domain.com/gb", eventsToken: "token-gb")
]

try ReactivClipInitializeMultiStore(
    stores: stores,
    appStoreID: "123456789",
    parentBundleIdentifier: "com.yourapp.bundle"
)
```

The framework chooses the descriptor whose `storeURL` is the longest prefix of the invocation URL. If nothing matches, the first descriptor acts as a fallback.

### 3 · Launch the view

```swift
ReactivClipView()
```

### Remote notifications requirement

For remote notifications functionality, your App Clip integration must:

1. Call `application.registerForRemoteNotifications()` yourself. `ReactivClipKit` does not call this API automatically.
2. Forward APNs device token in `application(_:didRegisterForRemoteNotificationsWithDeviceToken:)` using `NotificationCenter.default.postDeviceTokenReceived(deviceToken:)`
3. Forward notification taps using `NotificationCenter.default.postNotificationTapped(response:)`

See the full `AppDelegate` example in [Usage](./Documentation/Usage.md#recommended-integration-pattern).

---

## 📱 Full App Integration (2.3+)

Starting with **ClipKit 2.3**, ClipKit can be embedded inside an existing iOS SwiftUI app. When a Reactiv-owned URL or push notification arrives, ClipKit presents the commerce experience as a full-screen cover over your host content. When the user dismisses, they return exactly where they were.

Pin the Full App integration via:

```swift
.package(url: "https://github.com/reactivapp/ReactivClipKit-SPM.git", from: "2.3.0")
```

Five integration touchpoints:

1. **Initialize** with `"REACTIV_FULL_APP_MODE": true` in `initializationOptions`
2. **Wrap your root view** in `ReactivClipHost { MyHostHomeScreen() }`
3. **Forward the APNs device token** in `application(_:didRegisterForRemoteNotificationsWithDeviceToken:)` via `NotificationCenter.default.postDeviceTokenReceived(deviceToken:)`
4. **Forward push taps** in `userNotificationCenter(_:didReceive:withCompletionHandler:)` via `NotificationCenter.default.handleReactivNotificationTap(response:ifNotReactiv:)`
5. **Forward `appclip.apple.com` Universal Links** in `application(_:continue:_:restorationHandler:)` via `NotificationCenter.default.forwardInvocationURL(_:)` — required when your app uses third-party SDKs (Branch, OneSignal, Firebase, Klaviyo) that swizzle Universal Link delivery

```swift
@main
struct MyHostApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        try? ReactivClipInitialize(
            appIdentifier: "<uuid>",
            reactivEventsToken: "<token>",
            appStoreID: "<id>",
            parentBundleIdentifier: "com.yourcompany.app",
            initializationOptions: ["REACTIV_FULL_APP_MODE": true]
        )
    }

    var body: some Scene {
        WindowGroup {
            ReactivClipHost { MyHostHomeScreen() }
        }
    }
}
```

URL forwarding, presentation, dismissal, and cold-start buffering are all handled by `ReactivClipHost` internally — you don't write `.onOpenURL` or `.onContinueUserActivity` yourself.

**See the full guide:** [Documentation/FullAppIntegration.md](./Documentation/FullAppIntegration.md) — prerequisites, AppDelegate hooks, troubleshooting.

---

## 📹 Video tutorial

Watch the end-to-end integration walk-through → **[ReactivClipKit Integration Tutorial](https://drive.google.com/file/d/1w1gd9TzY35dkec0mh_TIA53DD5iE66Dk/view?usp=sharing)**

---

## 🛠 Requirements

- iOS 16+
- Xcode 26+

---

## 📚 Documentation

Detailed guides live in the `Documentation` folder:

- [Usage](./Documentation/Usage.md) — standalone App Clip integration
- **[Full App Integration](./Documentation/FullAppIntegration.md)** — embed ClipKit in an existing iOS SwiftUI app (2.3+)
- [API reference](./Documentation/API.md)
- [FAQ](./Documentation/FAQ.md)

### 🧪 Testing a Landing Page locally

If the Reactiv Dashboard is configured to send users to a landing page such as `pages/test`, you can test that flow locally by running your App Clip with an invocation URL.

In Xcode: **Edit Scheme…** → **Run** → **Arguments** → enable `_XCAppClipURL` and set it to a full URL like `https://<your-store-domain>/pages/test`.

See: [Usage → Testing a Landing Page Locally](./Documentation/Usage.md#testing-a-landing-page-locally)

---

## 🤝 Support

Need help? → support@reactivapp.com

---

## 🔒 License

ReactivClipKit is proprietary software. Contact Reactiv for licensing details.
