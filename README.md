# Flutter BLoC Template

Reusable Flutter template using:

- `flutter_bloc` for feature state management
- `get_it` for dependency wiring
- `go_router` for routing
- typed `KResult<T>` and `Failure` handling
- repository and service layers
- secure storage abstraction with a demo implementation
- app bootstrap flow and shell navigation
- reusable shared widgets and placeholder feature slots

## Use As Template

1. Create a new repo from this project or copy this directory.
2. Rename the package in `pubspec.yaml`.
3. Replace `flutter_bloc_template` imports with your new package name.
4. Update app labels in `lib/utils/constants.dart`.
5. Swap mock repositories and in-memory storage with production implementations.
6. Generate platform folders with `flutter create .`.
7. Run `flutter pub get`, `flutter analyze`, and `flutter test`.

## Structure

```text
lib/
├── app/
├── models/
├── repositories/
├── services/
├── presentation/
└── utils/
```

## Included Boilerplate

- application bootstrap service for config and session warm-up
- shell layout with bottom navigation and environment badge
- mock API client to replace with real network layer
- key-value storage and secure storage abstractions
- shared cards and empty-state widgets
- example feature, feature catalog page, and settings checklist page

## Example Feature

The included example screen demonstrates:

- feature-level BLoC wiring
- async loading through a service and repository
- secure session bootstrapping
- reusable theme and context extensions
- a folder shape you can copy for new features

## Recommended Customization Order

1. Replace the demo `ExampleRepository` with your remote data source.
2. Replace `MockApiClient` with Dio, Retrofit, or your preferred network stack.
3. Replace `InMemorySecuredStorage` and `InMemoryKeyValueStorage` with real storage.
4. Add feature routes in `lib/app/app_router.dart`.
5. Register new dependencies in `lib/configure.dart`.
6. Copy `presentation/example/` as the starting point for each new feature.

## Notes

- This repository intentionally does not commit generated platform folders.
- The included example is a template seed, not product-specific code.
- Flutter and Dart SDKs are still required locally to run `flutter create .`, `flutter analyze`, and `flutter test`.
