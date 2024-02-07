import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post(
      {required this.title,
      required this.featureImage,
      required this.slug,
      required this.id});

  Post.apiConstructor(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        slug = data['slug'],
        featureImage = data['feature_image'] ?? "";

  final String id;
  final String title;
  final String slug;
  final String featureImage;

  @override
  List<Object> get props => [id, title, slug, featureImage];
}
