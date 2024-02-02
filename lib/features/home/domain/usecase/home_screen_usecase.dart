import 'package:tdd_clean_architecture_riverpod/core/ui_state/ui_state.dart';
import 'package:tdd_clean_architecture_riverpod/core/usecases/usecase.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/entity/technology_posts_entity.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/repository/home_repository.dart';

class HomeScreenUseCase implements UseCase<UiState<List<TechnologyPostsEntity>>, NoParams> {
  final HomeRepository homeRepository;

  HomeScreenUseCase({required this.homeRepository});

  @override
  Future<UiState<List<TechnologyPostsEntity>>> call(NoParams params) {
    return homeRepository
        .getTechnologyUpdates()
        .then((List<TechnologyPostsEntity> response) => handleBackendSoftError(response));
  }

  UiState<List<TechnologyPostsEntity>> handleBackendSoftError(List<TechnologyPostsEntity> response) {
    if (response.isNotEmpty) {
      return UiState(success: response);
    } else {
      return UiState(error: response.toString());
    }
  }
}
