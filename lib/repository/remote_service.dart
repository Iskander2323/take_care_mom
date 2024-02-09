import 'package:flutter_application_1/app_config.dart';
import 'package:flutter_application_1/page/model/page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/categories/model/categorie.dart';
import 'package:flutter_application_1/posts/model/post.dart';
import 'dart:developer';
import 'dart:convert';

class RemoteService {
  //конструктор для считывания переменных окружения
  //разделить схему запроса и хост в отдельные переменные Done
  RemoteService()
      : _scheme = AppConfig.DEV_SCHEME,
        _host = AppConfig.DEV_HOST;

  final String _scheme;
  final String _host;

  Future<List<CategorieModel>> getCategories() async {
    final response = await http.get(Uri.parse(
        '$_scheme://$_host/ghost/api/content/tags/?key=2b621feea1174695f1666f5cca'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List categories = body['tags'];
      List<CategorieModel> result = [];
      for (Map<String, dynamic> categorie in categories) {
        if (categorie['visibility'] != 'public') continue;
        result.add(CategorieModel.fromJson(categorie));
      }
      return result;
    } else {
      log("Error: ${response.statusCode}");
      throw Exception('Failed to load');
    }
  }

  Future<List<PostModel>> getPosts(String slug) async {
    final response = await http.get(Uri.parse(
        '$_scheme://$_host/ghost/api/content/posts/?key=2b621feea1174695f1666f5cca&filter=tag:$slug'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List posts = body['posts'];
      List<PostModel> result = [];
      for (Map<String, dynamic> post in posts) {
        result.add(PostModel.fromJson(post));
      }
      return result;
    } else {
      log("Error: ${response.statusCode}");
      throw Exception('Failed to load');
    }
  }

  Future<PostViewModel?> getPage(String id) async {
    final response = await http.get(Uri.parse(
        '$_scheme://$_host/ghost/api/content/posts/?key=2b621feea1174695f1666f5cca&filter=id:$id'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List pages = body['posts'];
      if (pages.isEmpty) {
        return null;
      } else {
        return PostViewModel.fromJson(pages[0]);
      }
    } else {
      log("Error: ${response.statusCode}");
      throw Exception('Failed to load');
    }
  }
}
