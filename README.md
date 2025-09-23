# ReactivClipKit

A Swift package that brings Reactiv's rich commerce experiences to iOS App Clips.

> **📢 ReactivClipKit v2.x is now available!** Featuring Liquid Glass design and iOS 26 support. Requires Xcode 26+. [See migration guide](#-version-2x-migration) below.

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
- **v1.x**: Xcode 14+
- **v2.x**: Xcode 26+ (for Liquid Glass and iOS 26 features)

---

## 🚀 Version 2.x Migration

We're excited to announce that Reactiv ClipKit v2.x is now available! This release introduces major updates and paves the way for future innovation.

### **What's New**

- **Liquid Glass**: A sleek new design layer that enhances the look and feel of your App Clips
- **Xcode 26 Compatibility**: ClipKit v2.x has been updated to fully support Xcode 26 and iOS 26 features

### **Important Upgrade Notes**

- **Xcode 26 Required**: To use Reactiv ClipKit v2.x, you must update your Xcode projects to Xcode 26
- **v1.x Support Timeline**: Reactiv ClipKit v1.x will continue to support Xcode 16+ for the next 90 days. After that period, development on v1.x will cease
- **Automatic Protection**: If your ClipKit package dependency is set to "Up to Next Major Version" (default), you will remain on v1.x until you explicitly choose to upgrade

### **Migration Path**

To upgrade to v2.x:

1. Update to Xcode 26
2. Change your package dependency from v1.x to v2.x
3. Test your App Clip with the new Liquid Glass features

### **Recommendation**

To stay current with the latest features and security updates, we strongly recommend upgrading to Xcode 26 and adopting Reactiv ClipKit v2.x as soon as your development timeline allows.

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
