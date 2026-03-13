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
- `kflavor`-based native flavor setup
- Dio integration points and API interceptor template
- auth feature seed and paginated search seed
- GitHub Actions workflows for CI and flavor builds

## Use As Template

1. Create a new repo from this project or copy this directory.
2. Rename the package in `pubspec.yaml`.
3. Replace `flutter_bloc_template` imports with your new package name.
4. Update app labels in `lib/utils/constants.dart`.
5. Swap mock repositories and in-memory storage with production implementations.
6. Generate platform folders with `flutter create .`.
7. Run `flutter pub get`.
8. Run `dart run kflavor generate`.
9. Run `flutter analyze` and `flutter test`.

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
- Dio API client and interceptor scaffolding
- key-value storage and secure storage abstractions
- shared cards and empty-state widgets
- example feature, auth seed, paginated list seed, feature catalog page, and settings checklist page
- `flavors.yaml` for `dev`, `stage`, and `prod`
- GitHub Actions templates in `.github/workflows/`

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
4. Update flavor identifiers, bundle IDs, and URLs in `flavors.yaml`.
5. Run `dart run kflavor generate`.
6. Replace `ApiClient` registration in `configure.dart` with `DioApiClient`.
7. Add feature routes in `lib/app/app_router.dart`.
8. Register new dependencies in `lib/configure.dart`.
9. Copy `presentation/example/`, `presentation/auth/`, or `presentation/paginated_template/` as the starting point for each new feature.

## Flavor Workflow

1. Edit [flavors.yaml](/home/siddharthparekh40/flutter-skeleton/flavors.yaml) for your app IDs, bundle IDs, names, and URLs.
2. Generate platform flavor files with `dart run kflavor generate`.
3. Build or run with flavor-specific defines. Example:

```bash
flutter run --flavor dev \
  --dart-define=FLAVOR=dev \
  --dart-define=APP_NAME="Flutter BLoC Template Dev" \
  --dart-define=BASE_URL=https://dev-api.example.com \
  --dart-define=ENABLE_LOGS=true
```

The runtime flavor object is [lib/app/app_flavor.dart](/home/siddharthparekh40/flutter-skeleton/lib/app/app_flavor.dart). The bootstrap flow reads from it and exposes the selected flavor in the app shell.

## Feature Seeds

- [lib/presentation/auth/auth_screen.dart](/home/siddharthparekh40/flutter-skeleton/lib/presentation/auth/auth_screen.dart): login/logout starter module
- [lib/presentation/paginated_template/paginated_template_screen.dart](/home/siddharthparekh40/flutter-skeleton/lib/presentation/paginated_template/paginated_template_screen.dart): search + pagination starter module
- [lib/repositories/remote_repository/dio_api_client.dart](/home/siddharthparekh40/flutter-skeleton/lib/repositories/remote_repository/dio_api_client.dart): real HTTP client integration point
- [.github/workflows/flutter_ci.yml](/home/siddharthparekh40/flutter-skeleton/.github/workflows/flutter_ci.yml): analyze and test workflow

## Notes

- This repository intentionally does not commit generated platform folders.
- The included example is a template seed, not product-specific code.
- Flutter and Dart SDKs are still required locally to run `flutter create .`, `flutter analyze`, and `flutter test`.
