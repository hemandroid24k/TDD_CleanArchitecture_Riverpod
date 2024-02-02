import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture_riverpod/core/ui_state/ui_state.dart';

void main(){
  test('copyWith should return a new instance with updated values', () {
    // Arrange
    const originalState = UiState<int>(loading: true, error: 'Error', success: 42);

    // Act
    final updatedState = originalState.copyWith(
      loading: false,
      error: 'New Error',
      success: 99,
    );

    // Assert
    expect(updatedState.loading, false);
    expect(updatedState.error, 'New Error');
    expect(updatedState.success, 99);
  });

  test('copyWith should return a new instance with the same values when not provided', () {
    // Arrange
    const originalState = UiState<int>(loading: true, error: 'Error', success: 42);

    // Act
    final updatedState = originalState.copyWith();

    // Assert
    expect(updatedState.loading, true);
    expect(updatedState.error, 'Error');
    expect(updatedState.success, 42);
  });
}