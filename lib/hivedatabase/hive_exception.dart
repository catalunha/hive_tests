class HiveException implements Exception {
  final String message;
  final int? code;

  HiveException({this.message = '', this.code});

  @override
  String toString() => '$runtimeType (message: $message, code: $code)';
}

// class HiveICantOpenDirectoryException extends HiveException {
//   HiveICantOpenDirectoryException({String message = '', int? code})
//       : super(message: message, code: code);
// }

// class HiveICantInitException extends HiveException {
//   HiveICantInitException({String message = '', int? code})
//       : super(message: message, code: code);
// }

// class HiveICantOpenTheBoxException extends HiveException {
//   HiveICantOpenTheBoxException({String message = '', int? code})
//       : super(message: message, code: code);
// }

// class HiveICantGetTheBoxException extends HiveException {
//   HiveICantGetTheBoxException({String message = '', int? code})
//       : super(message: message, code: code);
// }

// class HiveUnregisteredBoxException extends HiveException {
//   HiveUnregisteredBoxException({String message = '', int? code})
//       : super(message: message, code: code);
// }

// class HiveICantDeleteBoxException extends HiveException {
//   HiveICantDeleteBoxException({String message = '', int? code})
//       : super(message: message, code: code);
// }

// class HiveICantGetValueException extends HiveException {
//   HiveICantGetValueException({String message = '', int? code})
//       : super(message: message, code: code);
// }

// class HiveICantPutValueException extends HiveException {
//   HiveICantPutValueException({String message = '', int? code})
//       : super(message: message, code: code);
// }

// class HiveICantAddValueException extends HiveException {
//   HiveICantAddValueException({String message = '', int? code})
//       : super(message: message, code: code);
// }

// class HiveICantCloseBoxesException extends HiveException {
//   HiveICantCloseBoxesException({String message = '', int? code})
//       : super(message: message, code: code);
// }

// class HiveICantCloseBoxException extends HiveException {
//   HiveICantCloseBoxException({String message = '', int? code})
//       : super(message: message, code: code);
// }

// class HiveICantCastDataException extends HiveException {
//   HiveICantCastDataException({String message = '', int? code})
//       : super(message: message, code: code);
// }

// class HiveICantDeleteValueException extends HiveException {
//   HiveICantDeleteValueException({String message = '', int? code})
//       : super(message: message, code: code);
// }
