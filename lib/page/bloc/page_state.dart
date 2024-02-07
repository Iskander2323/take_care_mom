part of 'page_bloc.dart';

enum PageStatus { initial, success, failure }

final class PageState extends Equatable {
  const PageState({
    //this.slug = slug,
    this.status = PageStatus.initial,
    this.page = const <PageView>[],
    this.hasReachedMax = false,
  });

  // final String slug;
  final PageStatus status;
  final List<PageView> page;
  final bool hasReachedMax;

  PageState copyWith({
    String? slug,
    PageStatus? status,
    List<PageView>? page,
    bool? hasReachedMax,
  }) {
    return PageState(
      // slug: slug ?? this.slug,
      status: status ?? this.status,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${page.length} }''';
  }

  @override
  List<Object> get props => [status, page, hasReachedMax];
}
