import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/posts/model/post.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_application_1/categories/model/remote_service.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient})
      : super(const PostState(status: PostStatus.initial)) {
    on<PostFetched>(
      _onPostFetched,
    );
  }

  Future<void> _onPostFetched(
      PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;
    emit(PostState(status: PostStatus.initial));
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts(event.slug);
        print("Lebd: ${posts.length}");
        print(posts);
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

  final http.Client httpClient;

  Future<List<Post>> _fetchPosts(String slug) async {
    List<Post> listPost = await RemoteService().getPosts(slug);
    print(listPost.length);
    return listPost;
  }
}
