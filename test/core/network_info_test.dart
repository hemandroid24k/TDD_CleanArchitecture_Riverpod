import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tdd_clean_architecture_riverpod/core_impl/network_info_impl.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  group('NetworkInfoImpl', () {
    late NetworkInfoImpl networkInfo;
    late MockConnectivity mockConnectivity;

    setUp(() {
      mockConnectivity = MockConnectivity();
      networkInfo = NetworkInfoImpl(mockConnectivity);
    });

    test('should return true when connectivity is available', () async {
      // Arrange
      when(() => mockConnectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.mobile);

      // Act
      final isConnected = await networkInfo.isConnected;

      // Assert
      expect(isConnected, true);
    });

    test('should return false when connectivity is not available', () async {
      // Arrange
      when(() => mockConnectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.none);

      // Act
      final isConnected = await networkInfo.isConnected;

      // Assert
      expect(isConnected, false);
    });
  });
}
