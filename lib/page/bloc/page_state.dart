part of 'page_bloc.dart';

enum PageStatus { initial, success, failure }

final class PageState extends Equatable {
  const PageState({
    this.status = PageStatus.initial,
    this.page,
    this.hasReachedMax = false,
  });

  final PageStatus status;
  final PostViewModel? page;
  final bool hasReachedMax;

  PageState copyWith({
    String? slug,
    PageStatus? status,
    PostViewModel? page,
    bool? hasReachedMax,
  }) {
    return PageState(
      status: status ?? this.status,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${page?.title} }''';
  }

  @override
  List<Object> get props => [status, hasReachedMax];
}
