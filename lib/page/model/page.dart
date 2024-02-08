import 'package:equatable/equatable.dart';

class PostViewModel extends Equatable {
  const PostViewModel(
      {required this.title,
      required this.featureImage,
      required this.html,
      required this.slug,
      required this.id});

  PostViewModel.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        slug = data['slug'],
        html = data['html'],
        featureImage = data['feature_image'] ?? "";

  final String id;
  final String title;
  final String slug;
  final String html;
  final String featureImage;

  @override
  List<Object> get props => [id, title, slug, html, featureImage];
}
