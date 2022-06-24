import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/entities/post.dart';

import '../../../../core/error/failures.dart';
import '../repositories/post_repository.dart';

class UpdatePostsUsecase {
  final PostsRepository repository;

  UpdatePostsUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePosts(post);
  }
}
