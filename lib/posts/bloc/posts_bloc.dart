import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/posts/model/post.dart';
import 'package:flutter_application_1/repository/remote_service.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState(status: PostStatus.initial)) {
    on<PostFetched>(
      _onPostFetched,
    );
  }

  Future<void> _onPostFetched(
      PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;
    emit(const PostState(status: PostStatus.initial));
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts(event.slug);
        return emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      }
      final posts = await _fetchPosts(event.slug);
      emit(posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts(String slug) async {
    List<Post> listPost = await RemoteService().getPosts(slug);
    return listPost;
  }
}
