import 'package:equatable/equatable.dart';

class Categorie extends Equatable {
  const Categorie(
      {required this.name, required this.slug, required this.feature_image});

  Categorie.apiConstructor(Map<String, dynamic> data)
      : name = data['name'],
        slug = data['slug'],
        feature_image = data['feature_image'] ?? "";

  final String name;
  final String slug;
  final String feature_image;

  @override
  List<Object> get props => [name, slug, feature_image];
}
