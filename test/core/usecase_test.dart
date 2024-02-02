import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture_riverpod/core/usecases/usecase.dart';

void main() {
  group('NoParams', () {
    test('should return an empty list for props', () {
      // Arrange
      final noParams = NoParams();

      // Act
      final props = noParams.props;

      // Assert
      expect(props, isEmpty);
    });
  });
}
