import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture_riverpod/core/environment/domain_config.dart';

void main() {
  group('DomainConfig', () {
    test('should return the correct base URL', () {
      // Arrange
      final domainConfig = DomainConfig();

      // Act
      final baseUrl = domainConfig.baseUrl;

      // Assert
      expect(baseUrl, 'https://json-placeholder.mock.beeceptor.com/');
    });
  });
}
