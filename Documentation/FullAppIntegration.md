# Full App Integration

Integrate ReactivClipKit into an existing iOS SwiftUI application so Reactiv-owned URLs and push notifications present the Reactiv commerce experience inside your app.

> **Status**: Introduced in ClipKit **2.3**. Public API stable for the 2.3.x line. A namespace reorganization is planned for 3.x with a migration guide published before release. Early 2.3.x integrators will be notified.

---

## Audience

You ship an existing iOS app (your brand, your codebase). You want to add Reactiv's commerce experience — product detail, collections, cart, checkout — without building it yourself. ClipKit is the framework that renders that experience inside your app.

---

## Prerequisites

|                 |                                                                                                          |
| --------------- | -------------------------------------------------------------------------------------------------------- |
| iOS             | 16.0+ (iOS 26 supported with Xcode 26)                                                                   |
| Xcode           | 16.0+ (26 recommended)                                                                                   |
| Swift           | 5.9+                                                                                                     |
| App entry point | SwiftUI (`@main App`). UIKit and React Native integration paths are on the roadmap but not covered here. |
| Package manager | Swift Package Manager                                                                                    |

UIKit host integrators: contact Reactiv — we can share the interim pattern.

---

## Install

Full App Integration requires ClipKit **2.3 or later**.

**Xcode UI:** _File → Add Package Dependencies…_ → `https://github.com/reactivapp/ReactivClipKit-SPM` → version rule _Up to Next Major_, pin `2.3.0` or later → link `ReactivClipKit` to your app target.

**`Package.swift`:**

```swift
dependencies: [
  .package(url: "https://github.com/reactivapp/ReactivClipKit-SPM", from: "2.3.0")
]
```

---

## Credentials

Four values, issued by the Reactiv team via the dashboard:

| Value                    | Description                                                    |
| ------------------------ | -------------------------------------------------------------- |
| `reactivAppIdentifier`   | UUID of your Reactiv app record                                |
| `reactivEventsToken`     | Bearer token (JWT) for events + push APIs                      |
| `appStoreID`             | App Store Connect numeric app ID (used for store links)        |
| `parentBundleIdentifier` | Your iOS app's bundle identifier (e.g., `com.yourcompany.app`) |

If you don't have these, request them from your Reactiv integration contact before starting integration.

---

## Production requirements

Your App Clip bundle must be registered under your parent app in App Store Connect. Reactiv handles provisioning — coordinate with your integration contact.

---

## Integration — three steps

Only three places in your app touch ClipKit:

### Step 1 — Initialize at launch

In your `@main App` struct's `init()`:

```swift
import ReactivClipKit
import SwiftUI

@main
struct MyHostApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  init() {
    try? ReactivClipInitialize(
      appIdentifier: "<reactivAppIdentifier>",
      reactivEventsToken: "<reactivEventsToken>",
      appStoreID: "<appStoreID>",
      parentBundleIdentifier: "com.yourcompany.app",
      initializationOptions: [
        "REACTIV_FULL_APP_MODE": true
      ]
    )
  }
  // body below
}
```

`REACTIV_FULL_APP_MODE: true` activates embedded mode. What it changes:

- Suppresses standalone-only UI (App Store overlay, Update Now prompts, webview download CTA)
- Scopes notification cancellation to ClipKit-scheduled IDs (never touches your app's notifications)
- Skips permission prompt and `registerForRemoteNotifications` — your host owns that. Forward the token (see Step 3) and ClipKit registers it with Reactiv's push API
- Analytics platform: `"Reactiv Clip Embedded"`
- Enables `ReactivClipHost`'s URL-forwarding pipeline

Other options: `CARTLESS_MODE: Bool` — browse-only.

### Step 2 — Wrap your root view in `ReactivClipHost`

```swift
var body: some Scene {
  WindowGroup {
    ReactivClipHost {
      MyHostHomeScreen()
    }
  }
}
```

`ReactivClipHost` owns URL forwarding, push presentation via `fullScreenCover`, dismiss handling, and cold-start buffering. Placement: anywhere — scene root preferred for robustness.

**Do not** add your own `.onOpenURL` / `.onContinueUserActivity` at the scene level, or `application(_:open:)` / `application(_:continue:)` in your AppDelegate. All would double-fire.

### Step 3 — AppDelegate hooks

Add two forwarding hooks to your existing `AppDelegate`. ClipKit assumes your app already sets `UNUserNotificationCenter.current().delegate`, requests permission, and calls `registerForRemoteNotifications` — don't duplicate.

```swift
import ReactivClipKit
import UIKit
import UserNotifications

extension AppDelegate {
  // Forward the APNs device token so ClipKit can register it with Reactiv's push API.
  func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    NotificationCenter.default.postDeviceTokenReceived(deviceToken: deviceToken)
  }

  // Forward notification taps. ClipKit handles Reactiv pushes; the closure runs for everything else.
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    NotificationCenter.default.handleReactivNotificationTap(response: response) {
      // Not a Reactiv push — your app's own routing runs here.
      // Leave empty if your app has no other push types.
    }
    completionHandler()
  }
}
```

**What each method does:**

- `didRegisterForRemoteNotificationsWithDeviceToken`: forward the APNs device token via `NotificationCenter.default.postDeviceTokenReceived(deviceToken:)`. ClipKit registers it with Reactiv's push API on your behalf. ClipKit never requests permission or calls `registerForRemoteNotifications` itself — it reuses the token your existing setup obtained.
- `userNotificationCenter(_:didReceive:…)`: forward notification taps via `NotificationCenter.default.handleReactivNotificationTap(response:ifNotReactiv:)`. ClipKit inspects the payload for a `reactiv_kind` key:
  - Present → it's a Reactiv push; ClipKit routes the payload into its pipeline and `ReactivClipHost` presents the Clip
  - Absent → the `ifNotReactiv` closure runs. Route to your app's own push handlers here, or leave empty
- `userNotificationCenter(_:willPresent:…)`: decide how notifications display when your app is foreground. `[.banner, .sound, .list]` shows a standard banner. Customize as your app prefers.

---

## Complete minimal example

Four files, ~80 lines of integration code total, including the `AppDelegate`:

**`MyHostApp.swift`:**

```swift
import ReactivClipKit
import SwiftUI

@main
struct MyHostApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  init() {
    try? ReactivClipInitialize(
      appIdentifier: "<your-uuid>",
      reactivEventsToken: "<your-token>",
      appStoreID: "<your-app-store-id>",
      parentBundleIdentifier: "com.yourcompany.app",
      initializationOptions: [
        "REACTIV_FULL_APP_MODE": true
      ]
    )
  }

  var body: some Scene {
    WindowGroup {
      ReactivClipHost {
        MyHostHomeScreen()
      }
    }
  }
}
```

**`AppDelegate.swift`:** as shown in Step 3 above.

**`MyHostHomeScreen.swift`:** your own view — whatever your app normally renders. Not shown; it's your code.

That's it. Three integration touchpoints. Everything else — URL delivery, push routing, presentation, dismissal, cold-start buffering, double-fire prevention — is inside ClipKit.

---

## Caveats worth knowing

### App Clip Experience URLs (merchant-domain invocation URLs)

Some merchants configure App Clip Experience URLs in App Store Connect — URLs on the merchant's own domain (e.g., `https://shop.yourcompany.com/products/foo`) that trigger the Clip. When such a URL is tapped and the parent app is installed, iOS delivers the URL to the parent app.

**ClipKit's validator rejects these URLs** — their host is your merchant domain, not `appclip.apple.com`. They fall through to your app's own routing (which is correct — your merchant URLs belong to your app's navigation, not ClipKit's).

If you want ClipKit to handle a specific merchant URL, translate it to the `appclip.apple.com` equivalent in your own `.onOpenURL` / `.onContinueUserActivity` handler and forward explicitly:

```swift
.onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { activity in
  guard let url = activity.webpageURL, url.host == "shop.yourcompany.com" else { return }
  if let translated = translateToAppClipURL(url) {
    NotificationCenter.default.forwardInvocationURL(translated)
  }
}
```

Adding that `.onContinueUserActivity` at the scene level doesn't conflict with `ReactivClipHost`'s internal modifier — they fire in parallel, each handling its own scope, ClipKit's validator filters out non-`appclip.apple.com` URLs from the host's forward.

### Foreground presentation options

`[.banner, .sound, .list]` from `willPresent` gives a standard banner. If you want stricter control — e.g., suppress Reactiv banners while your user is in a checkout flow — inspect `notification.request.content.userInfo["reactiv_kind"]` and conditionally return different options. ClipKit has no opinion here; it's your host UX decision.

---

## Testing

### Simulate push notifications

Create a `.apns` file with payload, including a `Simulator Target Bundle` key:

```json
{
  "Simulator Target Bundle": "com.yourcompany.app",
  "aps": {
    "alert": { "title": "Back in stock", "body": "Your favorite is back" },
    "sound": "default"
  },
  "reactiv_kind": "product",
  "reactiv_handle": "heavyweight-tee"
}
```

Deliver it:

```bash
xcrun simctl push booted com.yourcompany.app ./my-payload.apns
```

Or drag the `.apns` file onto the simulator window. Works in foreground, background, and cold-start states.

If you have multiple simulators booted, use the specific UDID:

```bash
xcrun simctl list devices booted   # find the UDID
xcrun simctl push <UDID> com.yourcompany.app ./my-payload.apns
```

### Simulate invocation URLs

In production, Universal Links routed via Apple's AASA are how these URLs reach the app. In simulator, you can route URLs directly if your app has the Associated Domains entitlement and is registered in App Store Connect:

```bash
xcrun simctl openurl booted "https://appclip.apple.com/id?p=com.yourcompany.app.Clip&action=home"
```

If your dev build doesn't have that setup, add a custom URL scheme to your `Info.plist` for development testing only, translate it to the https form in an `.onOpenURL` modifier, and forward. This keeps dev testing isolated from production paths. Example development-only modifier:

```swift
// Dev-only helper — remove from release builds
extension View {
  func forwardDevSchemeURLs() -> some View {
    self.onOpenURL { url in
      guard url.scheme?.lowercased() == "devtest" else { return }
      var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
      components?.scheme = "https"
      if let https = components?.url {
        NotificationCenter.default.forwardInvocationURL(https)
      }
    }
  }
}

// Apply in your App's body, Debug builds only:
ReactivClipHost { MyHostHomeScreen() }
#if DEBUG
  .forwardDevSchemeURLs()
#endif
```

---

## Troubleshooting

**Clip never appears after a push tap**

- Confirm `"REACTIV_FULL_APP_MODE": true` is set in `initializationOptions`. Without it, ClipKit runs in standalone mode and full-app features are disabled.
- Confirm your `AppDelegate` forwards tap via `NotificationCenter.default.handleReactivNotificationTap(response:ifNotReactiv:)` in `userNotificationCenter(_:didReceive:…)`.
- Confirm the push payload has `reactiv_kind`. Without it, ClipKit treats the push as non-Reactiv (your `ifNotReactiv` closure runs instead).

**Clip never appears after a universal link tap**

- Confirm `applinks:appclip.apple.com` is in Associated Domains entitlement.
- Confirm your Clip bundle is registered under your parent app in App Store Connect. Apple's AASA is populated from that registration.
- Confirm your URL has exactly `https://appclip.apple.com` host — anything else is rejected by the validator.
- If you see `Rejected invocation URL` in the console, that's the validator firing correctly on a non-matching URL.

**Clip appears, but at home screen instead of the expected destination**

- Your Reactiv push had `reactiv_kind` but was missing the required field (e.g., `reactiv_handle`). ClipKit falls back to home in that case rather than ignoring the push. Check your backend push pipeline for missing payload fields.

**Cold-start push tap doesn't present the Clip**

- `ReactivClipHost` handles cold-start URL buffering internally via `AppClipNotificationObserversInstaller.hasPendingReactivPresentation()`. If it's not working: verify your `ReactivClipHost` is actually mounted at app launch (check it's in the root scene, not inside a conditionally-mounted branch that hasn't rendered yet).

**Foreground push notification banner doesn't appear**

- Your `willPresent` must return at least `.banner` in its completion handler. `[.banner, .sound, .list]` is standard.

---

## Advanced: opt out of `ReactivClipHost`

Rare cases where you want full manual control — custom presentation chrome, presentation state that integrates with your own app router, VIPER/TCA store patterns — you can skip `ReactivClipHost` and wire things manually.

Touch points you take over:

```swift
import Combine

struct RootView: View {
  @State private var showClipKit = false
  @State private var cancellables: Set<AnyCancellable> = []

  var body: some View {
    MyHostHomeScreen()
      // You choose the presentation idiom — .fullScreenCover, .sheet, .navigationDestination, inline swap, custom overlay
      .fullScreenCover(isPresented: $showClipKit) {
        ReactivClipView()
      }
      // Touch point 2: inspect and forward URLs yourself
      .onOpenURL { url in
        guard url.scheme?.lowercased() == "https", url.host == "appclip.apple.com" else { return }
        NotificationCenter.default.forwardInvocationURL(url)
        showClipKit = true
      }
      .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { activity in
        guard let url = activity.webpageURL, url.host == "appclip.apple.com" else { return }
        NotificationCenter.default.forwardInvocationURL(url)
        showClipKit = true
      }
      // Observe dismiss requests
      .onAppear {
        guard cancellables.isEmpty else { return }
        ReactivClipCommands.publisher
          .filter { $0.type == .clipDismissRequested }
          .sink { _ in showClipKit = false }
          .store(in: &cancellables)
      }
  }
}
```

For push-triggered presentation from the `AppDelegate`, bridge UIKit to SwiftUI via a shared observable:

```swift
@MainActor
final class HostPresentationState: ObservableObject {
  static let shared = HostPresentationState()
  @Published var showClipKit = false
  private init() {}
}
```

Then `AppDelegate.userNotificationCenter(_:didReceive:…)` flips `HostPresentationState.shared.showClipKit = true` when `userInfo["reactiv_kind"] != nil`.

Caveats of manual integration:

- You reimplement the cold-start URL drain yourself (observe `NotificationCenter.default.publisher(for: Notification.Name("com.reactivapp.invocationURLReceived"))` in addition to `.onOpenURL`, or the cold-start path misses URLs delivered before SwiftUI mounts)
- You lose `ReactivClipHost`'s double-fire protection between `.onOpenURL` and `.onContinueUserActivity` if you attach them in multiple places in the view tree
- You're on your own for state preservation, animation timing, etc.

Almost all integrations should use `ReactivClipHost`.

---

## Versioning and compatibility

ReactivClipKit follows semantic versioning. The public API documented here — `ReactivClipHost`, `NotificationCenter.forwardInvocationURL(_:)`, `NotificationCenter.handleReactivNotificationTap(response:ifNotReactiv:)`, `NotificationCenter.postDeviceTokenReceived(deviceToken:)`, `ReactivClipCommands.publisher`, `ReactivClipEvents.publisher` — was introduced in **2.3** and is stable for the 2.3.x line.

A namespace reorganization is planned for 3.x. Early 2.3.x integrators will receive a migration guide before 3.0 ships, and an overlapping support period will be provided.

Report issues at `https://github.com/reactivapp/ReactivClipKit-SPM/issues` or contact your Reactiv integration team.
