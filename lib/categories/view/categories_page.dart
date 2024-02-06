import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/categories/bloc/categories_bloc.dart';
import 'package:flutter_application_1/categories/view/categories_list.dart';
import 'package:http/http.dart' as http;

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) =>
            CategorieBloc(httpClient: http.Client())..add(CategorieFetched()),
        child: const CategoriesList(),
      ),
    );
  }
}
