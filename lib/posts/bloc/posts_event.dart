part of 'posts_bloc.dart';

sealed class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PostFetched extends PostEvent {
  PostFetched(this.slug);
  final String slug;
}
