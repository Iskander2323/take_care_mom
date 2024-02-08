import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/bloc/page_bloc.dart';
import 'package:flutter_application_1/page/view/page_view_body.dart';
import 'package:flutter_application_1/repository/posts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostViewPage extends StatelessWidget {
  final String id;
  const PostViewPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            PageBloc(context.read<PostsRepository>())..add(PageFetched(id)),
        child: const PageViewBody(),
      ),
    );
  }
}
