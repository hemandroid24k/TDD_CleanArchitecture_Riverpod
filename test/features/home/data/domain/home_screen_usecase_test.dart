import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture_riverpod/core/usecases/usecase.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/entity/technology_posts_entity.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/repository/home_repository.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/usecase/home_screen_usecase.dart';

// Mock HomeRepository
class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late HomeScreenUseCase homeScreenUseCase;
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    homeScreenUseCase = HomeScreenUseCase(homeRepository: mockHomeRepository);
  });

  group('HomeScreenUseCase', () {
    test('should return success UiState with data when repository returns data', () async {
      // Arrange
      final expectedResponse = [
        TechnologyPostsEntity(
          userId: 1,
          id: 1,
          title: 'Test Title',
          body: 'Test Body',
          link: 'https://example.com',
          commentCount: 10,
        )
      ];
      when(() => mockHomeRepository.getTechnologyUpdates())
          .thenAnswer((_) async => expectedResponse);

      // Act
      final result = await homeScreenUseCase(NoParams());

      // Assert
      expect(result.success, equals(expectedResponse));
      verify(() => mockHomeRepository.getTechnologyUpdates()).called(1);
    });

    test('should return error UiState when repository returns empty list', () async {
      // Arrange
      when(() => mockHomeRepository.getTechnologyUpdates())
          .thenAnswer((_) async => []);

      // Act
      final result = await homeScreenUseCase(NoParams());

      // Assert
      expect(result.error, equals('[]'));
      verify(() => mockHomeRepository.getTechnologyUpdates()).called(1);
    });
  });

  group('handleBackendSoftError', () {
    test('should return success UiState with data when response is not empty', () {
      // Arrange
      final response = [
        TechnologyPostsEntity(
          userId: 1,
          id: 1,
          title: 'Test Title',
          body: 'Test Body',
          link: 'https://example.com',
          commentCount: 10,
        )];

      // Act
      final result = homeScreenUseCase.handleBackendSoftError(response);

      // Assert
      expect(result.success, equals(response));
    });

    test('should return error UiState when response is empty', () {
      // Act
      final result = homeScreenUseCase.handleBackendSoftError([]);

      // Assert
      expect(result.error, equals('[]'));
    });
  });
}
