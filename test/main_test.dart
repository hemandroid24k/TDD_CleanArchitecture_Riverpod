import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture_riverpod/core/injection_container.dart';
import 'package:tdd_clean_architecture_riverpod/core/routes/app_router_config.dart';
import 'package:tdd_clean_architecture_riverpod/main.dart';

void main() {
  testWidgets('MyApp widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [routerProvider.overrideWithValue(AppRouterConfig().appRouterConfig)],
        child: const MyApp(),
      ),
    );

    await tester.pump();

    // Verify that MyApp is successfully built and does not throw any errors.
    expect(find.byType(MyApp), findsOneWidget);

    // Verify that MaterialApp.router is part of the widget tree.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}