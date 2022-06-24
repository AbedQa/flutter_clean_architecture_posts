import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/entities/post.dart';

import '../../../../core/error/failures.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePosts(int id);
  Future<Either<Failure, Unit>> updatePosts(Post posts);
  Future<Either<Failure, Unit>> addPosts(Post posts);
}

//Either => when we need to return left & right left for error right for real data
//Unit => no need return anything
