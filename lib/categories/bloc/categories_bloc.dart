import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/categories/model/categorie.dart';
import 'package:flutter_application_1/repository/posts_repository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategorieBloc extends Bloc<CategorieEvent, CategorieState> {
  CategorieBloc(this._postsRepository)
      : super(const CategorieState(status: CategorieStatus.initial)) {
    on<CategorieFetched>(
      _onCategorieFetched,
    );
  }
  final PostsRepository _postsRepository;
  Future<void> _onCategorieFetched(
      CategorieFetched event, Emitter<CategorieState> emit) async {
    if (state.hasReachedMax) return;
    emit(const CategorieState(status: CategorieStatus.initial));
    try {
      if (state.status == CategorieStatus.initial) {
        final categories = await _postsRepository.getCategories();
        return emit(state.copyWith(
          status: CategorieStatus.success,
          categories: categories,
          hasReachedMax: false,
        ));
      }
      final categories = await _postsRepository.getCategories();
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
}
