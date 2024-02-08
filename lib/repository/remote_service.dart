import 'package:flutter_application_1/page/model/page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/categories/model/categorie.dart';
import 'package:flutter_application_1/posts/model/post.dart';
import 'dart:convert';

class RemoteService {
  Future<List<Categorie>> getCategories() async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.24:4001/ghost/api/content/tags/?key=2b621feea1174695f1666f5cca'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List categories = [];
      try {
        categories = body['tags'] as List;
      } catch (e) {
        print(e);
      }
      List<Categorie> result = [];
      for (Map<String, dynamic> categorie in categories) {
        if (categorie['visibility'] != 'public') continue;
        result.add(Categorie.fromJson(categorie));
      }
      return result;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Post>> getPosts(String slug) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.24:4001/ghost/api/content/posts/?key=2b621feea1174695f1666f5cca&filter=tag:$slug'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List posts = [];
      try {
        posts = body['posts'] as List;
      } catch (e) {
        print(e);
      }
      List<Post> result = [];
      for (Map<String, dynamic> post in posts) {
        result.add(Post.apiConstructor(post));
      }
      return result;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<PageView>> getPage(String id) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.24:4001/ghost/api/content/posts/?key=2b621feea1174695f1666f5cca&filter=id:$id'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List pages = [];
      try {
        pages = body['posts'] as List;
      } catch (e) {
        print(e);
      }
      List<PageView> result = [];
      for (Map<String, dynamic> post in pages) {
        result.add(PageView.apiConstructor(post));
      }
      return result;
    } else {
      throw Exception('Failed to load');
    }
  }
}
