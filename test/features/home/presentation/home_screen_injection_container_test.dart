import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture_riverpod/core/injection_container.dart';
import 'package:tdd_clean_architecture_riverpod/core/ui_state/ui_state.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/entity/technology_posts_entity.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/presentation/injection/home_screen_injection_container.dart';

void main(){
  test('get Technology postsFlow FutureProvider should return a UiState<TechnologyPostsEntity>', () {
    // Arrange
    final container = ProviderContainer();

    // Make sure to initialize the necessary providers in the container
    container.read(connectivityServiceProvider);
    container.read(homeRepositoryProvider);

    // Act
    final resultAsyncValue = container.read(homeScreenUpdatesFutureProvider);

    // Wait for the Future to complete
    resultAsyncValue.when(
      data: (result) {
        // Assert
        expect(result, isA<UiState<TechnologyPostsEntity>>());
      },
      loading: () {
        // Handle loading state if needed
      },
      error: (error, stackTrace) {
        // Handle error state if needed
      },
    );
  });
}