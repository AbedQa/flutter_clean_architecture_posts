import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/entities/post.dart';
import 'package:flutter_clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';

import '../widgets/loading_widget.dart';
import '../widgets/messages_widget.dart';
import '../widgets/pasts_widget.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is ErrorPostsState) {
            return MessagesWidget(
              message: state.message,
            );
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PostsWidget(
                posts: state.posts,
              ),
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: const Text(
        "Posts",
      ),
    );
  }
}
