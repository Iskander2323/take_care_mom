part of 'categories_bloc.dart';

sealed class CategorieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class CategorieFetched extends CategorieEvent {}
