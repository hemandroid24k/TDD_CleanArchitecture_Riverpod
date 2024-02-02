import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/data/models/login_response_dto.dart';

void main() {
  group('LoginResponseDto', () {
    test('should convert from and to JSON', () {
      // Arrange
      final loginResponseDto = LoginResponseDto(success: true, message: 'Test Message', token: 'Test Token');

      // Act
      final jsonMap = loginResponseDto.toJson();
      final fromJson = LoginResponseDto.fromJson(jsonMap);

      // Assert
      expect(fromJson.success, equals(true));
      expect(fromJson.message, equals('Test Message'));
      expect(fromJson.token, equals('Test Token'));
    });
  });
}
