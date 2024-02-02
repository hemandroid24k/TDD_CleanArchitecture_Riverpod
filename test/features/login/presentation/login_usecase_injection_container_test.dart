import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture_riverpod/core/injection_container.dart';
import 'package:tdd_clean_architecture_riverpod/core/ui_state/ui_state.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/domain/entity/login_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/presentation/injection/login_usecase_injection_container.dart';

void main() {
  test('postLoginFlowFutureProvider should return a UiState<LoginEntity>', () {
    // Arrange
    final container = ProviderContainer();

    // Make sure to initialize the necessary providers in the container
    container.read(connectivityServiceProvider);
    container.read(loginRepositoryProvider);

    // Replace this with the actual requestBody you want to test
    final requestBody = {'username': 'testuser', 'password': 'testpassword'};

    // Act
    final resultAsyncValue = container.read(postLoginFlowFutureProvider(requestBody));

    // Wait for the Future to complete
    resultAsyncValue.when(
      data: (result) {
        // Assert
        expect(result, isA<UiState<LoginEntity>>());
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
