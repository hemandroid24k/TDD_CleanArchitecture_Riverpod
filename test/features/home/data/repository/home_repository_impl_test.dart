import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture_riverpod/core/network/network_info.dart';
import 'package:tdd_clean_architecture_riverpod/core/network/network_io_service.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/data/repository/home_repository_impl.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/entity/technology_posts_entity.dart';

class MockNetworkIOService extends Mock implements NetworkIOService {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  group('HomeRepositoryImpl Tests', () {
    late HomeRepositoryImpl homeRepository;
    late MockNetworkIOService mockNetworkIOService;

    setUp(() {
      mockNetworkIOService = MockNetworkIOService();
      homeRepository = HomeRepositoryImpl(networkIOService: mockNetworkIOService);
    });

    test('getTechnologyUpdates should parse tech updates correctly', () async {
      // Arrange
      when(() => mockNetworkIOService.get(any())).thenAnswer((_) async => '[{"userId": 1, "id": 1, "title": "Title", "body": "Body", "link": "Link", "comment_count": 5}]');

      // Act
      final result = await homeRepository.getTechnologyUpdates();

      // Assert
      expect(result, isA<List<TechnologyPostsEntity>>());
      // Add more assertions based on the expected behavior of parseTechUpdatesResponse
      expect(result.length, 1);
      expect(result[0].title, 'Title');
    });

    test('getTechnologyUpdates should handle unexpected response format', () async {
      // Arrange
      when(() => mockNetworkIOService.get(any())).thenAnswer((_) async => '{"key": "value"}'); // Not a List

      // Act
      final result = await homeRepository.getTechnologyUpdates();

      // Assert
      expect(result, isA<List<TechnologyPostsEntity>>());
      expect(result, isEmpty); // Check that the result is an empty list for unexpected response format
    });

  });
}
