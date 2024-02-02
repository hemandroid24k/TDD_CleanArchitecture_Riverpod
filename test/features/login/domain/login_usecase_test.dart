import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/domain/entity/login_entity.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/domain/repository/login_repository.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/domain/usecase/login_usecase.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  group('LoginUseCase', () {
    late LoginUseCase loginUseCase;
    late MockLoginRepository mockLoginRepository;

    setUp(() {
      mockLoginRepository = MockLoginRepository();
      loginUseCase = LoginUseCase(loginRepository: mockLoginRepository);
    });

    test('should return success UI state when login is successful', () async {
      // Arrange
      final params = {'username': 'testuser', 'password': 'testpassword'};
      final successResponse = LoginEntity(success: true, message: 'Success', token: 'dgdfdfs');

      when(() => mockLoginRepository.goLogin(requestBody: params)).thenAnswer((_) async => successResponse);

      // Act
      final result = await loginUseCase.call(params);

      // Assert
      expect(result.loading, equals(false));
      expect(result.error, isNull);
      expect(result.success, equals(successResponse));
    });

    test('should return error UI state when login is unsuccessful', () async {
      // Arrange
      final params = {'username': 'testuser', 'password': 'testpassword'};
      final errorResponse = LoginEntity(success: false, message: 'Invalid credentials', token: '');

      when(() => mockLoginRepository.goLogin(requestBody: params)).thenAnswer((_) async => errorResponse);

      // Act
      final result = await loginUseCase.call(params);

      // Assert
      expect(result.error, equals('Invalid credentials'));
    });

  });
}
