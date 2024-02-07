import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post(
      {required this.title, required this.feature_image, required this.slug, required this.id});

  Post.apiConstructor(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        slug = data['slug'],
        feature_image = data['feature_image'] ?? "";

  final String id;
  final String title;
  final String slug;
  final String feature_image;

  @override
  List<Object> get props => [id, title, slug, feature_image];
}
