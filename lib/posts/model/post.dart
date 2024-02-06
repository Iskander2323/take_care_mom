import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post(
      {required this.title, required this.feature_image, required this.html});

  Post.apiConstructor(Map<String, dynamic> data)
      : title = data['title'],
        html = data['html'],
        feature_image = data['feature_image'] ?? "";

  final String title;
  final String html;
  final String feature_image;

  @override
  List<Object> get props => [title, html, feature_image];
}
