import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture_riverpod/core/injection_container.dart';
import 'package:tdd_clean_architecture_riverpod/core/routes/app_router_config.dart';
import 'package:tdd_clean_architecture_riverpod/core/ui_state/ui_state.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/presentation/home_screen.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/presentation/injection/home_screen_injection_container.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/entity/technology_posts_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockHomeScreenUpdatesFutureProvider extends Mock implements UiState<List<TechnologyPostsEntity>> {}

// a generic Listener class, used to keep track of when a provider notifies its listeners
class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  setUpAll(() {
    registerFallbackValue(const UiState<List<TechnologyPostsEntity>>());
  });

  final mockProvider = MockHomeScreenUpdatesFutureProvider();

  testWidgets('HomeScreen shows loading indicator initially', (WidgetTester tester) async {
    when(() => mockProvider.loading); // Use `read()` to simulate provider state

    var container = ProviderContainer(overrides: [routerProvider.overrideWithValue(AppRouterConfig().appRouterConfig)]);

    final listener = Listener<UiState<List<TechnologyPostsEntity>>>();

    container.listen<UiState<List<TechnologyPostsEntity>>>(
        homeScreenUpdatesFutureProvider as ProviderListenable<UiState<List<TechnologyPostsEntity>>>, listener,
        fireImmediately: true);

    verifyNever(() => listener(null, const UiState<List<TechnologyPostsEntity>>()));
  });

  /*testWidgets('TechUpdatesListItem displays content correctly', (tester) async {
    TechnologyPostsEntity mockData = TechnologyPostsEntity(
      title: 'Test Title',
      body: 'Test Body',
      commentCount: 10,
      link: 'https://example.com', userId: 1, id: 1,
    );

    await tester.pumpWidget(
      TechUpdatesListItem(
        technologyPostsData: [mockData],
        index: 0,
      ),
    );

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Body'), findsOneWidget);
    expect(find.text('Comments: 10'), findsOneWidget);
    expect(find.byType(Chip), findsNWidgets(2));
  });

  testWidgets('Home screen should render error message', (WidgetTester tester) async {
    // Mock the error response
    final provider = AutoDisposeProvider.family<UiState<List<TechnologyPostsEntity>>, AsyncError>((ref, error) {
      return UiState.error!(error);
    });

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: ProviderScope(
          child: HomeScreen(),
          overrides: [
            homeScreenUpdatesFutureProvider.overrideWithProvider(provider('Error')),
          ],
        ),
      ),
    );

    // Verify that the error message is rendered.
    expect(find.text('please try after sometime'), findsOneWidget);
  });

  testWidgets('Home screen should render data', (WidgetTester tester) async {
    // Mock the data response
    final provider = Provider((ref) => AsyncValue<List<TechnologyPostsEntity>>.data([
      TechnologyPostsEntity(title: 'Title 1', body: 'Body 1', commentCount: 10, link: 'https://example.com', userId: 1, id: 1),
      // Add more data as needed
    ]));

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: ProviderScope(
          overrides: [homeScreenUpdatesFutureProvider.overrideWithValue(provider)],
          child: const HomeScreen(),
        ),
      ),
    );

    // Verify that the data is rendered.
    expect(find.text('Title 1'), findsOneWidget);
    expect(find.text('Body 1'), findsOneWidget);
    expect(find.byType(TechUpdatesListItem), findsOneWidget);
  });*/
}
