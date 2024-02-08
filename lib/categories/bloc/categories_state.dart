part of 'categories_bloc.dart';

enum CategorieStatus { initial, success, failure }

final class CategorieState extends Equatable {
  const CategorieState({
    this.status = CategorieStatus.initial,
    this.categories = const <CategorieModel>[],
    this.hasReachedMax = false,
  });

  final CategorieStatus status;
  final List<CategorieModel> categories;
  final bool hasReachedMax;

  CategorieState copyWith({
    CategorieStatus? status,
    List<CategorieModel>? categories,
    bool? hasReachedMax,
  }) {
    return CategorieState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${categories.length} }''';
  }

  @override
  List<Object> get props => [status, categories, hasReachedMax];
}
