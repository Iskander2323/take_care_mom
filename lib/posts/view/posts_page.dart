import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/posts/bloc/posts_bloc.dart';
import 'package:flutter_application_1/posts/view/posts_list.dart';
import 'package:http/http.dart' as http;

class PostsPage extends StatelessWidget {
  const PostsPage({super.key, required this.slug});

  final String slug;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) =>
            PostBloc(httpClient: http.Client())..add(PostFetched(slug)),
        child: PostsList(slug: slug),
      ),
    );
  }
}
