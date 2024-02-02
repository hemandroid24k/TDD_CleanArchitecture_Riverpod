import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/data/models/technology_posts_response_dto.dart';

void main() {
  group('TechnologyPostsResponseDto', () {
    test('should convert from and to JSON', () {
      // Arrange
      final techResponseDto = TechnologyPostsResponseDto(
          userId: 619, id: 13, title: 'IronMan', body: 'Founder of stark industries',
          link: 'https://example.com', commentCount: 123);

      // Act
      final jsonMap = techResponseDto.toJson();
      final fromJson = TechnologyPostsResponseDto.fromJson(jsonMap);

      // Assert
      expect(fromJson.id, equals(13));
      expect(fromJson.userId, equals(619));
      expect(fromJson.title, equals('IronMan'));
      expect(fromJson.body, equals('Founder of stark industries'));
      expect(fromJson.link, equals('https://example.com'));
      expect(fromJson.commentCount, equals(123));
    });
  });
}
