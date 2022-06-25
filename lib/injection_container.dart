import 'package:flutter_clean_architecture_posts/core/network/network_info.dart';
import 'package:flutter_clean_architecture_posts/features/posts/data/datasources/post_local_data_source.dart';
import 'package:flutter_clean_architecture_posts/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:flutter_clean_architecture_posts/features/posts/data/repositories/post_repository_imp.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/repositories/post_repository.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/usecases/add_posts.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/usecases/delete_posts.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/usecases/get_all_posts.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/usecases/update_posts.dart';
import 'package:flutter_clean_architecture_posts/features/posts/presentation/bloc/add_update_delete_posts.dart/add_update_delete_posts_bloc.dart';
import 'package:flutter_clean_architecture_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddUpdateDeletePostsBloc(
      addPosts: sl(), updatePosts: sl(), deletePosts: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));
  sl.registerLazySingleton(() => AddPostsUsecase(sl()));
  sl.registerLazySingleton(() => DeletePostsUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePostsUsecase(sl()));

// Repository

  sl.registerLazySingleton<PostsRepository>(() => PostRepositoryImp(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImp(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImp(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
