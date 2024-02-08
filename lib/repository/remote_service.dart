import 'package:flutter_application_1/page/model/page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/categories/model/categorie.dart';
import 'package:flutter_application_1/posts/model/post.dart';
import 'dart:convert';

class RemoteService {
  //конструктор для считывания переменных окружения
  //разделить схему запроса и хост в отдельные переменные Done
  //покрыть логами все внешние запросы

  String _schema = 'http';
  String _host = '192.168.1.24:4001';

  Future<List<CategorieModel>> getCategories() async {
    final response = await http.get(Uri.parse(
        '$_schema://$_host/ghost/api/content/tags/?key=2b621feea1174695f1666f5cca'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List categories = [];
      try {
        categories = body['tags'] as List;
      } catch (e) {
        print(e);
      }
      List<CategorieModel> result = [];
      for (Map<String, dynamic> categorie in categories) {
        if (categorie['visibility'] != 'public') continue;
        result.add(CategorieModel.fromJson(categorie));
      }
      return result;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<PostModel>> getPosts(String slug) async {
    final response = await http.get(Uri.parse(
        '$_schema://$_host/ghost/api/content/posts/?key=2b621feea1174695f1666f5cca&filter=tag:$slug'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List posts = [];
      try {
        posts = body['posts'] as List;
      } catch (e) {
        print(e);
      }
      List<PostModel> result = [];
      for (Map<String, dynamic> post in posts) {
        result.add(PostModel.fromJson(post));
      }
      return result;
    } else {
      throw Exception('Failed to load');
    }
  }

  //переделать так чтобы возращала только объект Done
  //переименовать модель Done
  Future<PostViewModel?> getPage(String id) async {
    final response = await http.get(Uri.parse(
        '$_schema://$_host/ghost/api/content/posts/?key=2b621feea1174695f1666f5cca&filter=id:$id'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List pages = [];
      try {
        pages = body['posts'] as List;
      } catch (e) {
        print(e);
      }
      PostViewModel? page;
      for (Map<String, dynamic> post in pages) {
        page = PostViewModel.fromJson(post);
      }
      return page;
    } else {
      throw Exception('Failed to load');
    }
  }
}
