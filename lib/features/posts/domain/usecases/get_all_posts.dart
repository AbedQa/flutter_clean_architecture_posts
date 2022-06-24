import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/repositories/post_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class GetAllPostsUsecase {
  final PostsRepository repository;

  GetAllPostsUsecase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
