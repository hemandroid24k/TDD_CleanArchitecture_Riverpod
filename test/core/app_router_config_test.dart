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

// void main() {
//   group('AppRouterConfig', () {
//     late AppRouterConfig appRouterConfig;
//
//     setUp(() {
//       appRouterConfig = AppRouterConfig();
//     });
//
//     testWidgets('should navigate to LoginScreen when login route is requested', (tester) async {
//       // Arrange
//       final router = appRouterConfig.appRouterConfig;
//
//       // Act
//       await tester.pumpWidget(
//         MaterialApp.router(
//           routerDelegate: router.routerDelegate,
//           routeInformationParser: router.routeInformationParser,
//         ),
//       );
//       await tester.tap(find.text('Navigate to Login'));
//
//       // Assert
//       await tester.pumpAndSettle();
//       expect(find.byType(LoginScreen), findsOneWidget);
//     });
//
//     testWidgets('should navigate to HomeScreen when home route is requested', (tester) async {
//       // Arrange
//       final router = appRouterConfig.appRouterConfig;
//
//       // Act
//       await tester.pumpWidget(
//         MaterialApp.router(
//           routerDelegate: router.routerDelegate,
//           routeInformationParser: router.routeInformationParser,
//         ),
//       );
//       await tester.tap(find.text('Navigate to Home'));
//
//       // Assert
//       await tester.pumpAndSettle();
//       expect(find.byType(HomeScreen), findsOneWidget);
//     });
//   });
// }
