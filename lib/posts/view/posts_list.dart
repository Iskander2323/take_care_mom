import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/posts/bloc/posts_bloc.dart';
import 'package:flutter_application_1/posts/widgets/post_list_item.dart';
import 'package:flutter_application_1/categories/widgets/bottom_loader.dart';

class PostsList extends StatefulWidget {
  const PostsList({super.key, required this.slug});
  final String slug;
  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      switch (state.status) {
        case PostStatus.failure:
          return const Center(child: Text('failed to fetch posts'));
        case PostStatus.success:
          if (state.posts.isEmpty) {
            return const Center(child: Text('no posts'));
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.posts.length
                  ? const BottomLoader()
                  : PostsListItem(post: state.posts[index]);
            },
            itemCount:
                state.hasReachedMax ? state.posts.length : state.posts.length,
            controller: _scrollController,
          );
        case PostStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostFetched(widget.slug));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
