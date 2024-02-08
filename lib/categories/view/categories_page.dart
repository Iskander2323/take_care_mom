import 'package:flutter/material.dart';
import 'package:flutter_application_1/repository/posts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/categories/bloc/categories_bloc.dart';
import 'package:flutter_application_1/categories/view/categories_list.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CategorieBloc(context.read<PostsRepository>())
          ..add(CategorieFetched()),
        child: const CategoriesList(),
      ),
    );
  }
}
