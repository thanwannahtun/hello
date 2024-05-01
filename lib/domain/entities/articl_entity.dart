import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  const ArticleEntity(
      {this.id,
      this.author,
      this.url,
      this.name,
      this.content,
      this.description,
      this.cretedAt});
  final int? id;
  final String? author;
  final String? url;
  final String? name;
  final String? content;
  final String? description;
  final String? cretedAt;

  @override
  List<Object?> get props =>
      [id, author, url, name, content, description, cretedAt];
}
