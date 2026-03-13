# Flutter Skeleton

Reusable Flutter starter using:

- `flutter_bloc` for feature state management
- `get_it` for dependency wiring
- `go_router` for routing
- typed `KResult<T>` and `Failure` handling
- repository and service layers
- secure storage abstraction with a demo implementation

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

## Example Feature

The included example screen demonstrates:

- feature-level BLoC wiring
- async loading through a service and repository
- secure session bootstrapping
- reusable theme and context extensions

## Next Steps

1. Install Flutter and Dart locally.
2. Run `flutter pub get`.
3. Run `flutter create .` if you want platform folders generated in-place.
4. Run `flutter test` and `flutter analyze`.
