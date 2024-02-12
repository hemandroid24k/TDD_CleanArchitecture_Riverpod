import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_clean_architecture_riverpod/core/error/exceptions.dart';
import 'package:tdd_clean_architecture_riverpod/core/network/network_info.dart';
import 'package:tdd_clean_architecture_riverpod/core_impl/network_io_service_impl.dart';

class MockHttpClient extends Mock implements http.Client {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri.parse('https://dummy-url.com'));
  });

  group('NetworkIOServiceImpl', () {
    late NetworkIOServiceImpl networkIOService;
    late MockHttpClient mockHttpClient;
    late MockNetworkInfo mockNetworkInfo;

    setUp(() {
      mockHttpClient = MockHttpClient();
      mockNetworkInfo = MockNetworkInfo();
      networkIOService = NetworkIOServiceImpl(client: mockHttpClient, networkInfo: mockNetworkInfo);
    });

    test('should perform a GET request successfully with query parameters', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockHttpClient.get(
        any(),
        headers: any(named: 'headers'),
      )).thenAnswer((_) async => http.Response('{"success":true}', 200));

      final queryParams = {'param1': 'value1', 'param2': 'value2'};

      // Act
      final result = await networkIOService.get('https://example.com', queryParams: queryParams);

      // Assert
      expect(result, '{"success":true}');
    });

    test('should handle BackEnd Hard Error in GET request', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockHttpClient.get(
        any(),
        headers: any(named: 'headers'),
      )).thenAnswer((_) async => http.Response('Error Message', 404));

      // Act & Assert
      expect(() => networkIOService.get('https://example.com'), throwsA(isA<BackendHardError>()));
    });

    test('should perform a POST request successfully', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockHttpClient.post(any(), headers: any(named: 'headers'), body: ""))
          .thenAnswer((realInvocation) async => http.Response('{"success":true}', 200));

      // Act
      final result = await networkIOService.post('https://example.com');

      // Assert
      expect(result, '{"success":true}');
    });

    test('should handle error response in POST request', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockHttpClient.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      )).thenAnswer((_) async => http.Response('Error Message', 404));

      // Act & Assert
      expect(() => networkIOService.post('https://example.com'), throwsA(isA<BackendHardError>()));
    });

    test('should handle InvalidTokenError in POST request', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockHttpClient.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      )).thenAnswer((_) async => http.Response('Unauthorized', 401));

      // Act & Assert
      expect(() => networkIOService.post('https://example.com'), throwsA(isA<InvalidTokenError>()));
    });

    test('should handle NoInternetError in POST request', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act & Assert
      expect(() => networkIOService.post('https://example.com'), throwsA(isA<NoInternetError>()));
    });

    test('should throw NoInternetError when no internet connection', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act & Assert
      expect(() => networkIOService.get('https://example.com'), throwsA(isA<NoInternetError>()));
    });

    // Add more tests for other scenarios (e.g., handling different HTTP status codes, handling exceptions, etc.)

    // Example:
    test('should throw InvalidTokenError when HTTP status is unauthorized', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));

      // Act & Assert
      expect(() => networkIOService.get('https://example.com'), throwsA(isA<InvalidTokenError>()));
    });
  });
}
