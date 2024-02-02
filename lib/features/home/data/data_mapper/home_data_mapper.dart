import 'package:tdd_clean_architecture_riverpod/features/home/data/models/technology_posts_response_dto.dart';
import 'package:tdd_clean_architecture_riverpod/features/home/domain/entity/technology_posts_entity.dart';

extension TechnologyUpdatesDataMapper on List<TechnologyPostsResponseDto> {
  List<TechnologyPostsEntity> toTechnologyPostsEntity() {
    return map((responseDto) => TechnologyPostsEntity(
        id: responseDto.id,
        userId: responseDto.userId,
        title: responseDto.title,
        body: responseDto.body,
        link: responseDto.link,
        commentCount: responseDto.commentCount)).toList();
  }
}
