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
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategorieBloc, CategorieState>(
        builder: (context, state) {
      switch (state.status) {
        case CategorieStatus.failure:
          return const Center(child: Text('failed to fetch posts'));
        case CategorieStatus.success:
          if (state.categories.isEmpty) {
            return const Center(child: Text('no posts'));
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.categories.length
                  ? const BottomLoader()
                  : CategoriesListItem(categorie: state.categories[index]);
            },
            itemCount: state.hasReachedMax
                ? state.categories.length
                : state.categories.length,
            controller: _scrollController,
          );
        case CategorieStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<CategorieBloc>().add(CategorieFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
