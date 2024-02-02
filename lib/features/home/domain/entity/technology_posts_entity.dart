class TechnologyPostsEntity {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;
  final String? link;
  final int? commentCount;

  TechnologyPostsEntity({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    required this.link,
    required this.commentCount,
  });

}