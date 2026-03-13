import 'package:flutter_skeleton/utils/constants.dart';

sealed class Failure {
  const Failure();

  String get message;
}

class InternalFailure extends Failure {
  const InternalFailure();

  @override
  String get message => ErrorMessages.internalError;
}

class ValidationFailure extends Failure {
  final String error;

  const ValidationFailure({required this.error});

  @override
  String get message => error;
}

class StorageFailure extends Failure {
  final String error;

  const StorageFailure({required this.error});

  @override
  String get message => error;
}
