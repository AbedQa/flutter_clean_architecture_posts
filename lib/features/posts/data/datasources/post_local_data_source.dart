import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts/features/posts/data/models/posts_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachedPosts(List<PostModel> posts);
}

class PostLocalDataSourceImp implements PostLocalDataSource {
  @override
  Future<List<PostModel>> getCachedPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> cachedPosts(List<PostModel> posts) {
    // TODO: implement cachedPosts
    throw UnimplementedError();
  }
}
