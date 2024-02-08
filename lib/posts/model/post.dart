import 'package:equatable/equatable.dart';

class PostModel extends Equatable {
  const PostModel(
      {required this.title,
      required this.featureImage,
      required this.slug,
      required this.id});

  PostModel.fromJson(Map<String, dynamic> data)
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
