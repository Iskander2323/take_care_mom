import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/page/model/page.dart';
import 'package:flutter_application_1/repository/posts_repository.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc(this._pageRepository)
      : super(const PageState(status: PageStatus.initial)) {
    on<PageFetched>(
      _onPostFetched,
    );
  }
  final PostsRepository _pageRepository;
  Future<void> _onPostFetched(
      PageFetched event, Emitter<PageState> emit) async {
    if (state.hasReachedMax) return;
    emit(const PageState(status: PageStatus.initial));
    try {
      if (state.status == PageStatus.initial) {
        final page = await _pageRepository.getPage(event.id);
        return emit(state.copyWith(
          status: PageStatus.success,
          page: page,
          hasReachedMax: false,
        ));
      }
      final page = await _pageRepository.getPage(event.id);
      emit(state.copyWith(
        status: PageStatus.success,
        page: page,
        hasReachedMax: false,
      ));
    } catch (_) {
      emit(state.copyWith(status: PageStatus.failure));
    }
  }
}
