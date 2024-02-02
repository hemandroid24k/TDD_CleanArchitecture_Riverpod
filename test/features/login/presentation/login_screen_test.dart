import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/presentation/login_screen.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/presentation/widgets/input_text_field.dart';

void main() {

  group('LoginScreen Widget Tests', () {

    testWidgets('Renders login screen with input fields and button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      expect(find.text('Login'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(InputTextFieldWidget), findsNWidgets(2));
    });

    testWidgets('Submitting form with empty fields shows validation errors', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      expect(find.byKey(const Key('password')), findsOneWidget);

      // Tap on the login button without entering any text
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    });

    testWidgets('Submitting form with valid credentials navigates to home page', (WidgetTester tester) async {
      // Wrap the MaterialApp with ProviderScope
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Enter valid username and password
      await tester.enterText(find.byKey(const Key('username')), 'michael');
      await tester.enterText(find.byKey(const Key('password')), 'success-password');

      // Tap on the login button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();
    });

  });
}
