// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technology_posts_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TechnologyPostsResponseDto _$TechnologyPostsResponseDtoFromJson(
        Map<String, dynamic> json) =>
    TechnologyPostsResponseDto(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      link: json['link'] as String?,
      commentCount: json['comment_count'] as int?,
    );

Map<String, dynamic> _$TechnologyPostsResponseDtoToJson(
        TechnologyPostsResponseDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'link': instance.link,
      'comment_count': instance.commentCount,
    };
