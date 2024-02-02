import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_clean_architecture_riverpod/core/injection_container.dart';
import 'package:tdd_clean_architecture_riverpod/core/ui_state/ui_state.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/data/repository/home_repository_impl.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/entity/technology_posts_entity.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/repository/home_repository.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/usecase/home_screen_usecase.dart';

import '../../../../core/usecases/usecase.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) =>
    HomeRepositoryImpl(networkIOService: ref.read(connectivityServiceProvider)));


final homeScreenUpdatesFutureProvider = FutureProvider.autoDispose<UiState<List<TechnologyPostsEntity>>>((ref) async {
  return HomeScreenUseCase(homeRepository: ref.read(homeRepositoryProvider)).call(NoParams());
});