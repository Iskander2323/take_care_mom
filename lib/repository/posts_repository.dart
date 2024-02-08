import "package:flutter_application_1/categories/model/categorie.dart";
import "package:flutter_application_1/repository/remote_service.dart";

class ArticleRepository {
  ArticleRepository({RemoteService? remoteService})
      : _remoteService = remoteService ?? RemoteService();

  final RemoteService _remoteService;

  Future<List<Categorie>> getCategories() async {
    final categorie = await _remoteService.getCategories();
    return categorie;
  }
}
