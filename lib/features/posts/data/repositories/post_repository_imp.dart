import 'package:flutter_clean_architecture_posts/core/error/exception.dart';
import 'package:flutter_clean_architecture_posts/core/network/network_info.dart';
import 'package:flutter_clean_architecture_posts/features/posts/data/models/posts_model.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/entities/post.dart';
import 'package:flutter_clean_architecture_posts/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/repositories/post_repository.dart';

import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';

typedef DeleteOrUpdateOrAddPosts = Future<Unit> Function();

class PostRepositoryImp implements PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  PostRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachedPosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPosts(Post posts) async {
    final PostModel postModel =
        PostModel(id: posts.id, title: posts.title, body: posts.body);
    return _getMessage(() {
      return remoteDataSource.addPosts(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePosts(int id) async {
    return _getMessage(() {
      return remoteDataSource.deletePosts(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePosts(Post posts) async {
    final PostModel postModel =
        PostModel(id: posts.id, title: posts.title, body: posts.body);
    return _getMessage(() {
      return remoteDataSource.updatePosts(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPosts deleteOrUpdateOrAddPosts) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPosts();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
