import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture_riverpod/core/error/exceptions.dart';

void main() {
  group('BaseException', () {
    test('should create an instance of BaseException with code and message', () {
      // Arrange
      final baseException = BaseException(404, 'Not Found');

      // Assert
      expect(baseException.code, 404);
      expect(baseException.message, 'Not Found');
    });
  });

  group('BackendHardError', () {
    test('should create an instance of BackendHardError with code and message', () {
      // Arrange
      final backendHardError = BackendHardError(500, 'Internal Server Error');

      // Assert
      expect(backendHardError.code, 500);
      expect(backendHardError.message, 'Internal Server Error');
    });
  });

  group('BackendSoftError', () {
    test('should create an instance of BackendSoftError with code and message', () {
      // Arrange
      final backendSoftError = BackendSoftError(401, 'Unauthorized');

      // Assert
      expect(backendSoftError.code, 401);
      expect(backendSoftError.message, 'Unauthorized');
    });
  });

  group('NoInternetError', () {
    test('should create an instance of NoInternetError', () {
      // Arrange
      final noInternetError = NoInternetError();

      // Assert
      expect(noInternetError.code, 0);
      expect(noInternetError.message, 'No internet connection');
    });
  });

  group('InvalidTokenError', () {
    test('should create an instance of InvalidTokenError', () {
      // Arrange
      final invalidTokenError = InvalidTokenError();

      // Assert
      expect(invalidTokenError.code, 0);
      expect(invalidTokenError.message, 'Please login and try again.');
    });
  });
}
