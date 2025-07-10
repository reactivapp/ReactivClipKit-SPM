# ReactivClipKit

A Swift package that brings Reactiv's rich commerce experiences to iOS App Clips.

---

## ✨ Features

- Plug-and-play App Clip storefront powered by Reactiv
- Built-in analytics stream with typed events
- Single-store **and** multi-store initialization modes

---

## 📦 Installation (Swift Package Manager)

```swift
.dependencies = [
    .package(url: "https://github.com/reactivapp/ReactivClipKit-SPM.git", from: "1.0.0")
]
```

Add the package in **Xcode → File → Add Packages…** and select the **ReactivClipKit** product for your App Clip target.

### Required dependency

```swift
.package(url: "https://github.com/getsentry/sentry-cocoa", from: "8.0.0")
```

ReactivClipKit will initialise Sentry automatically if the SDK class is supplied.

---

## 🚀 Quick start

### 1 · Single-store initialization

```swift
try ReactivClipInitialize(
    appIdentifier: "your-reactiv-app-id",
    reactivEventsToken: "your-events-token",
    appStoreID: "123456789",
    parentBundleIdentifier: "com.yourapp.bundle",
    sentrySDK: SentrySDK.self
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
    parentBundleIdentifier: "com.yourapp.bundle",
    sentrySDK: SentrySDK.self
)
```

The framework chooses the descriptor whose `storeURL` is the longest prefix of the invocation URL. If nothing matches, the first descriptor acts as a fallback.

### 3 · Launch the view

```swift
ReactivClipView()
```

---

## 📹 Video tutorial

Watch the end-to-end integration walk-through → **[ReactivClipKit Integration Tutorial](https://drive.google.com/file/d/1w1gd9TzY35dkec0mh_TIA53DD5iE66Dk/view?usp=sharing)**

---

## 🛠 Requirements

- iOS 16+
- Xcode 14+

---

## 📚 Documentation

Detailed guides live in the `Documentation` folder:

- [Usage](./Documentation/Usage.md)
- [API reference](./Documentation/API.md)
- [FAQ](./Documentation/FAQ.md)

---

## 🤝 Support

Need help? → support@reactivapp.com

---

## 🔒 License

ReactivClipKit is proprietary software. Contact Reactiv for licensing details.
