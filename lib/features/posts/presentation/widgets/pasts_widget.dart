import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';

class PostsWidget extends StatelessWidget {
  final List<Post> posts;
  const PostsWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: ((context, index) {
          return ListTile(
            leading: Text(
              posts.elementAt(index).id.toString(),
            ),
            title: Text(
              posts.elementAt(index).title,
            ),
            subtitle: Text(
              posts.elementAt(index).body,
            ),
            onTap: () {},
          );
        }),
        separatorBuilder: (context, index) {
          return index != posts.length - 1 ? const Divider() : Container();
        },
        itemCount: posts.length);
  }
}
