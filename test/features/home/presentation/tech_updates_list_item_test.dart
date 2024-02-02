import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/entity/technology_posts_entity.dart';

import 'package:tdd_clean_architecture_riverpod/features/home/presentation/widgets/tech_updates_list_item.dart';

void main() {
  testWidgets('TechUpdatesListItem should render correctly', (WidgetTester tester) async {
    // Create a TechnologyPostsEntity for testing
    final TechnologyPostsEntity testPost = TechnologyPostsEntity(
      title: 'Test Title',
      body: 'Test Body',
      commentCount: 5,
      link: 'https://www.example.com', userId: 1, id: 1,
    );

    // Set up a mock HTTP client to simulate the network behavior
    final httpClient = MockClient((http.Request request) async {
      if (request.url.host == 'https://images.squarespace-cdn.com/content/v1/57ed3edb37c58182f815c65f/1634633624522-OMCIHLPLCUO4ICTYRZZZ/shutterstock_1196754286.jpg?format=1500w') {
        // Respond with a dummy image for the specified URL
        return http.Response.bytes(
          List.filled(100, 0), // Empty image bytes
          200,
        );
      }
      // Handle other requests as needed
      return http.Response('', 200);
    });

    // Build our widget and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TechUpdatesListItem(
            technologyPostsData: [testPost],
            index: 0,
          ),
        ),
      ),
    );

    // Verify that the title and body are rendered
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Body'), findsOneWidget);

    // Verify that the comment count is rendered
    expect(find.text('Comments: 5'), findsOneWidget);

    // Verify that the "Visit Website" chip is rendered
    expect(find.text('Visit Website'), findsOneWidget);

    // Tap on the "Visit Website" chip and check if the onTap callback is called
    await tester.tap(find.text('Visit Website'));
    await tester.pump();

    // Verify that the onTap callback was called
    expect(
      tester.takeException(),
      contains('Tapped on URL: https://images.squarespace-cdn.com/content/v1/57ed3edb37c58182f815c65f/1634633624522-OMCIHLPLCUO4ICTYRZZZ/shutterstock_1196754286.jpg?format=1500w'),
    );
  });
}
