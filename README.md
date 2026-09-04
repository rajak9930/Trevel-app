# NextRole Travel

A responsive Flutter travel discovery prototype based on the supplied Figma screens. It includes Dashboard, destination details, booking calendar, account settings, drawer navigation, and dark/light theme switching.

## Setup

Requirements: Flutter SDK compatible with Dart `3.13.2` or newer within the project constraint.

```bash
flutter pub get
flutter run
```

## Build APK

```bash
flutter build apk --release
```

## Architecture

The project uses GetX for named routing and reactive application state. Feature screens are grouped under `lib/screens`, reusable UI is under `lib/widgets`, design tokens are under `lib/core/theme`, and sample destination data is under `lib/data/models`.

## Third-party packages

- `get`: reactive state management, named navigation, theme updates, and snackbars.
- `cupertino_icons`: platform icon set included by the Flutter template.

## Assumptions

The supplied reference images do not include exportable source assets, so the prototype uses stable Unsplash image URLs for the hotel and profile imagery. These should be replaced with licensed local assets before production release. The Trips and Calendar tabs are represented in the navigation shell; their full Figma states can be added without changing the routing foundation.

See [docs/response_flow.md](docs/response_flow.md) for the full response-flow document.
