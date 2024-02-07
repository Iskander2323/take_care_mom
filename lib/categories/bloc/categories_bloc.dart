import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/categories/model/categorie.dart';
import 'package:flutter_application_1/repository/remote_service.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategorieBloc extends Bloc<CategorieEvent, CategorieState> {
  CategorieBloc()
      : super(const CategorieState(status: CategorieStatus.initial)) {
    on<CategorieFetched>(
      _onCategorieFetched,
    );
  }

  Future<void> _onCategorieFetched(
      CategorieFetched event, Emitter<CategorieState> emit) async {
    if (state.hasReachedMax) return;
    emit(const CategorieState(status: CategorieStatus.initial));
    try {
      if (state.status == CategorieStatus.initial) {
        final categories = await _fetchCategories();
        return emit(state.copyWith(
          status: CategorieStatus.success,
          categories: categories,
          hasReachedMax: false,
        ));
      }
      final categories = await _fetchCategories(state.categories.length);
      emit(categories.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: CategorieStatus.success,
              categories: List.of(state.categories)..addAll(categories),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: CategorieStatus.failure));
    }
  }

  Future<List<Categorie>> _fetchCategories([int startIndex = 0]) async {
    List<Categorie> listCate = await RemoteService().getCategories();
    return listCate;
  }
}
