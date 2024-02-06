import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/categories/model/categorie.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_application_1/categories/model/remote_service.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategorieBloc extends Bloc<CategorieEvent, CategorieState> {
  CategorieBloc({required this.httpClient})
      : super(const CategorieState(status: CategorieStatus.initial)) {
    on<CategorieFetched>(
      _onCategorieFetched,
      // transformer: throttleDuration
    );
  }

  Future<void> _onCategorieFetched(
      CategorieFetched event, Emitter<CategorieState> emit) async {
    if (state.hasReachedMax) return;
    emit(CategorieState(status: CategorieStatus.initial));
    try {
      if (state.status == CategorieStatus.initial) {
        final categories = await _fetchCategories();
        print("Lebd: ${categories.length}");
        print(categories);
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

  final http.Client httpClient;

  Future<List<Categorie>> _fetchCategories([int startIndex = 0]) async {
    List<Categorie> listCate = await RemoteService().getCategories();
    print(listCate.length);
    return listCate;
  }
}
