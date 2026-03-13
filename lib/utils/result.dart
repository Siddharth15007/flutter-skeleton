import 'package:flutter_skeleton/models/failure.dart';

sealed class KResult<T> {
  const KResult();

  R fold<R>(
    R Function(Failure failure) onError,
    R Function(T value) onValue,
  );

  const factory KResult.value(T value) = KValueResult<T>;
  const factory KResult.error(Failure error) = KErrorResult<T>;
}

class KValueResult<T> extends KResult<T> {
  final T value;

  const KValueResult(this.value);

  @override
  R fold<R>(
    R Function(Failure failure) onError,
    R Function(T value) onValue,
  ) {
    return onValue(value);
  }
}

class KErrorResult<T> extends KResult<T> {
  final Failure error;

  const KErrorResult(this.error);

  @override
  R fold<R>(
    R Function(Failure failure) onError,
    R Function(T value) onValue,
  ) {
    return onError(error);
  }
}
