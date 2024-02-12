import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/categories/bloc/categories_bloc.dart';
import 'package:flutter_application_1/categories/widgets/categorie_list_item.dart';
import 'package:flutter_application_1/categories/widgets/bottom_loader.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategorieBloc, CategorieState>(
        builder: (context, state) {
      switch (state.status) {
        case CategorieStatus.failure:
          return const Center(child: Text('failed to fetch categories'));
        case CategorieStatus.success:
          if (state.categories.isEmpty) {
            return const Center(child: Text('No categories'));
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.categories.length
                    ? const BottomLoader()
                    : CategoriesListItem(categorie: state.categories[index]);
              },
            );
          }
        case CategorieStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
