# ReactivClipKit Examples

Reference Xcode project demonstrating both ReactivClipKit integration paths in a single workspace.

## What's here

```
Examples/
├── ReactivClipKit-Sample.xcodeproj   ← open this in Xcode
├── ReactivClipKit-SampleApp/         ← parent host iOS app (Full App embedding)
│   ├── ReactivClipSampleApp.swift    ← @main App, calls ReactivClipInitialize, wraps in ReactivClipHost
│   ├── AppDelegate.swift             ← push token forward + tap forward + URL forward
│   ├── ContentView.swift             ← placeholder host content
│   └── ReactivClipKit_Sample.entitlements
└── ReactivClipKit-SampleClip/        ← App Clip target (standalone integration)
    ├── ReactivClipKitSampleClipApp.swift
    ├── AppDelegate.swift
    ├── AnalyticsManager.swift
    └── ReactivSampleClip.entitlements
```

## What each target demonstrates

| Target                      | Integration mode                                        | Use as reference for                                                          |
| --------------------------- | ------------------------------------------------------- | ----------------------------------------------------------------------------- |
| `ReactivClipKit-SampleApp`  | Full App embedding (ClipKit inside an existing iOS app) | Hosts that want to embed the Reactiv commerce experience inside their own app |
| `ReactivClipKit-SampleClip` | Standalone App Clip                                     | Pure App Clip integrations                                                    |

The two targets are paired (host + Clip) so you can see how an embedded ClipKit relates to its companion Clip in the same workspace.

## Run it locally

1. Open `ReactivClipKit-Sample.xcodeproj` in Xcode.
2. Fill in the empty string credentials in both `App.swift` files:
   - `ReactivClipKit-SampleApp/ReactivClipSampleApp.swift` — `appIdentifier`, `reactivEventsToken`, `appStoreID`, `parentBundleIdentifier`
   - `ReactivClipKit-SampleClip/ReactivClipKitSampleClipApp.swift` — same set
3. Update `ReactivClipKit-SampleApp/ReactivClipKit_Sample.entitlements` — replace `com.yourcompany.app.Clip` in the `associated-appclip-app-identifiers` array with your Clip's actual bundle ID.
4. In Xcode, set both targets' bundle identifiers and signing team in **Signing & Capabilities**.
5. Plug in a physical device, select it as the run target, build and run the host scheme.

To validate Universal Link routing, see `Documentation/FullAppIntegration.md` → "Local testing".

## Configuration values

| Field                                | Source                                                       |
| ------------------------------------ | ------------------------------------------------------------ |
| `appIdentifier`                      | Reactiv dashboard → App settings                             |
| `reactivEventsToken`                 | Reactiv dashboard → Events configuration                     |
| `appStoreID`                         | App Store Connect → App information                          |
| `parentBundleIdentifier`             | Your parent app's bundle identifier                          |
| `associated-appclip-app-identifiers` | Your App Clip target's bundle identifier (entitlements file) |

## Required ClipKit framework

Both targets link `ReactivClipKit` via Swift Package Manager. If the dependency is missing after cloning:

1. Xcode → File → Add Package Dependencies…
2. URL: `https://github.com/reactivapp/ReactivClipKit-SPM`
3. Select both `ReactivClipKit-SampleApp` and `ReactivClipKit-SampleClip` as the targets to add the library to.

Xcode handles linking and embedding automatically for both targets.

## Companion docs

- `../README.md` — top-level overview
- `../Documentation/FullAppIntegration.md` — full setup guide for the host (this is what `ReactivClipKit-SampleApp` demonstrates)
- `../Documentation/Usage.md` — standalone App Clip integration (what `ReactivClipKit-SampleClip` demonstrates)
- `../Documentation/API.md` — public API reference
- `../Documentation/FAQ.md` — common questions
