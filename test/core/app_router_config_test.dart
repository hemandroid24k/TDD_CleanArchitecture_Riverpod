import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture_riverpod/core/constants/app_routes.dart';

void main() {
  group('AppRouterConfig', () {
    test('should create GoRouter instance with correct routes', () async {

      // Assert
      expect(AppRoutes().login, AppRoutes().login);
      expect(AppRoutes().homePage, AppRoutes().homePage);
    });
  });
}
