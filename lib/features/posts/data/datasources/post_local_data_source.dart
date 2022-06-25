import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts/core/error/exception.dart';
import 'package:flutter_clean_architecture_posts/features/posts/data/models/posts_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachedPosts(List<PostModel> posts);
}

const cachedPostsKey = "CACHED_POSTS";

class PostLocalDataSourceImp implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImp({
    required this.sharedPreferences,
  });
  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(cachedPostsKey);
    if (jsonString?.isEmpty ?? false) {
      throw EmptyCacheException();
    }
    List<Map> listOfPostToJson = json.decode(jsonString!);
    List<PostModel> jsonToPostModel =
        listOfPostToJson.map((e) => PostModel.fromJson(e)).toList();
    return Future.value(jsonToPostModel);
  }

  @override
  Future<Unit> cachedPosts(List<PostModel> posts) {
    List<Map> listOfPostToJson = posts.map((e) => e.toJson()).toList();
    sharedPreferences.setString(cachedPostsKey, json.encode(listOfPostToJson));

    return Future.value(unit);
  }
}
