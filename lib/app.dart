import 'package:flutter/material.dart';
import 'package:flutter_application_1/categories/view/categories_page.dart';
import 'package:flutter_application_1/page/view/page_view_page.dart';
import 'package:flutter_application_1/repository/posts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_application_1/posts/view/posts_page.dart';

final routes = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: CategoriesPage()),
  '/posts/': (_) => const MaterialPage(child: CategoriesPage()),
  '/posts/:slug': (routeData) {
    final slug = routeData.pathParameters['slug'] ?? '';
    return MaterialPage(child: PostsPage(slug: slug));
  },
  '/page/': (_) => const MaterialPage(child: CategoriesPage()),
  '/page/:id': (routeData) {
    final id = routeData.pathParameters['id'] ?? '';
    return MaterialPage(child: PostViewPage(id: id));
  },
});

class App extends MaterialApp {
  const App({
    super.key,
    required RouterDelegate<Object> routedDelegate,
    required RouteInformationParser<Object> routeInformationParser,
  }) : super.router(
            routerDelegate: routedDelegate,
            routeInformationParser: routeInformationParser);
}

Widget startApp(PostsRepository postsRepository) {
  return RepositoryProvider.value(
    value: postsRepository,
    child: App(
      routedDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
      routeInformationParser: const RoutemasterParser(),
    ),
  );
}
