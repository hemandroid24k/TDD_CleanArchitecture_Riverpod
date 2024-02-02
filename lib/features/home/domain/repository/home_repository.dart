import 'package:tdd_clean_architecture_riverpod/features/home/domain/entity/technology_posts_entity.dart';

abstract class HomeRepository {
  Future<List<TechnologyPostsEntity>> getTechnologyUpdates();
}