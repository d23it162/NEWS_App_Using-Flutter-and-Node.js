import 'package:hive/hive.dart';

part 'article.g.dart'; // Generated file

@HiveType(typeId: 0)
class Article {
  @HiveField(0)
  final String? source;

  @HiveField(1)
  final String? author;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final String url;

  @HiveField(5)
  final String? urlToImage;

  @HiveField(6)
  final DateTime publishedAt;

  @HiveField(7)
  final String? content;

  Article({
    this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json['source']?['name'],
      author: json['author'],
      title: json['title'] ?? '',
      description: json['description'],
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: DateTime.parse(json['publishedAt'] ?? DateTime.now().toIso8601String()),
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': {'name': source},
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
    };
  }
}