import 'package:equatable/equatable.dart';

class Categorie extends Equatable {
  const Categorie(
      {required this.name, required this.slug, required this.featureImage});

  Categorie.fromJson(Map<String, dynamic> data)
      : name = data['name'],
        slug = data['slug'],
        featureImage = data['feature_image'] ?? "";

  final String name;
  final String slug;
  final String featureImage;

  @override
  List<Object> get props => [name, slug, featureImage];
}
