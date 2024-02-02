import 'package:json_annotation/json_annotation.dart';
part 'technology_posts_response_dto.g.dart';

@JsonSerializable()
class TechnologyPostsResponseDto {
  @JsonKey(name: "userId")
  final int? userId;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "body")
  final String? body;
  @JsonKey(name: "link")
  final String? link;
  @JsonKey(name: "comment_count")
  final int? commentCount;

  TechnologyPostsResponseDto({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    required this.link,
    required this.commentCount,
  });

  factory TechnologyPostsResponseDto.fromJson(Map<String, dynamic> json) => _$TechnologyPostsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TechnologyPostsResponseDtoToJson(this);
}
