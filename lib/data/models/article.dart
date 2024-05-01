import 'package:hello/domain/entities/articl_entity.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel(
      {this.id,
      this.author,
      this.url,
      this.name,
      this.content,
      this.description,
      this.cretedAt});
  @override
  final int? id;
  @override
  final String? author;
  @override
  final String? url;
  @override
  final String? name;
  @override
  final String? content;
  @override
  final String? description;
  @override
  final String? cretedAt;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      const ArticleModel();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    return map;
  }
}
