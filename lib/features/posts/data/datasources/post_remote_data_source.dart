import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts/core/error/exception.dart';
import 'package:flutter_clean_architecture_posts/features/posts/data/models/posts_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePosts(int id);
  Future<Unit> updatePosts(PostModel postModel);
  Future<Unit> addPosts(PostModel postModel);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImp implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImp({
    required this.client,
  });

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse("$BASE_URL/posts"));
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body);
      final List<PostModel> listOfPostModel =
          decodedJson.map((e) => PostModel.fromJson(e)).toList();
      return Future.value(listOfPostModel);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPosts(PostModel postModel) async {
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response =
        await client.post(Uri.parse("$BASE_URL/posts"), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePosts(int id) async {
    final response =
        await client.delete(Uri.parse("$BASE_URL/posts/${id.toString()}"));
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePosts(PostModel postModel) async {
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response = await client.patch(
        Uri.parse("$BASE_URL/posts/${postModel.id.toString()}"),
        body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
