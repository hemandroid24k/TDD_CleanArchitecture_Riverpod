import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture_riverpod/core/environment/domain_config.dart';
import 'package:tdd_clean_architecture_riverpod/core/network/network_io_service.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/data/repository/login_repository_impl.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/domain/repository/login_repository.dart';

class MockNetworkIOService extends Mock implements NetworkIOService {}

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  group('LoginRepositoryImpl', () {
    late MockNetworkIOService mockNetworkIOService;
    late LoginRepositoryImpl loginRepositoryImpl;

    setUp(() {
      mockNetworkIOService = MockNetworkIOService();
      loginRepositoryImpl = LoginRepositoryImpl(networkIOService: mockNetworkIOService);
    });

    test('should call the networkIOService.post method with the correct parameters', () async {
      // Arrange
      final requestBody = {'username': 'michael', 'password': 'success-password'};
      final expectedUrl = '${DomainConfig().baseUrl}login';
      when(() => mockNetworkIOService.post(any(), requestData: any(named: 'requestData'), headers: any(named: 'headers')))
          .thenAnswer((invocation) async {
        // Assert
        expect(invocation.positionalArguments[0], equals(expectedUrl));

        // Check for null before decoding
        final requestData = invocation.namedArguments[const Symbol('requestData')];
        expect(requestData, isNotNull);

        // Decode the JSON
        final decodedData = json.decode(requestData.toString());

        // Assert the decoded data
        expect(decodedData, isMap);
        expect(decodedData, equals(requestBody));

        return '{"success":true}';
      });

      // Act
      await loginRepositoryImpl.goLogin(requestBody: requestBody);

      // Verify
      verify(() => mockNetworkIOService.post(any(), requestData: any(named: 'requestData'), headers: any(named: 'headers')))
          .called(1);
    });
  });
}
