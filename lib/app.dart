import 'package:flutter/material.dart';
import 'package:flutter_application_1/categories/view/categories_page.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_application_1/posts/view/posts_page.dart';

final routes = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: CategoriesPage()),
  '/posts/': (_) => const MaterialPage(child: CategoriesPage()),
  '/posts/:slug': (routeData) {
    final slug = routeData.pathParameters['slug'] ?? ' ';
    return MaterialPage(child: PostsPage(slug: slug));
  }

  /// 'page': (routeData) => MaterialPage(child: PageView()),
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

App startApp() {
  return App(
    routedDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
    routeInformationParser: const RoutemasterParser(),
  );
}
