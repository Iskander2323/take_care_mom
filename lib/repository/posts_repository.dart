import "package:flutter_application_1/categories/model/categorie.dart";
import "package:flutter_application_1/page/model/page.dart";
import "package:flutter_application_1/posts/model/post.dart";
import "package:flutter_application_1/repository/remote_service.dart";

class PostsRepository {
  final _remoteService = RemoteService();

  Future<List<CategorieModel>> getCategories() async {
    final categorie = await _remoteService.getCategories();
    return categorie;
  }

  Future<List<PostModel>> getPosts(String slug) async {
    final post = await _remoteService.getPosts(slug);
    return post;
  }

  Future<PostViewModel?> getPage(String id) async {
    final page = await _remoteService.getPage(id);
    return page;
  }
}
