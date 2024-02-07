import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/page/model/page.dart';
import 'package:flutter_application_1/repository/remote_service.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(const PageState(status: PageStatus.initial)) {
    on<PageFetched>(
      _onPostFetched,
    );
  }

  Future<void> _onPostFetched(
      PageFetched event, Emitter<PageState> emit) async {
    log('IS IT WORKING', name: '_onPostFetched');
    if (state.hasReachedMax) return;
    emit(PageState(status: PageStatus.initial));
    try {
      if (state.status == PageStatus.initial) {
        final page = await _fetchPage(event.id);
        print("Lebd: ${page.length}");
        print(page);
        return emit(state.copyWith(
          status: PageStatus.success,
          page: page,
          hasReachedMax: false,
        ));
      }
      final page = await _fetchPage(event.id);
      emit(page.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PageStatus.success,
              page: List.of(state.page)..addAll(page),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: PageStatus.failure));
    }
  }

  Future<List<PageView>> _fetchPage(String id) async {
    List<PageView> listPost = await RemoteService().getPage(id);
    print(listPost.length);
    return listPost;
  }
}
