import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_posts/core/error/failures.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/entities/post.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/usecases/get_all_posts.dart';

import '../../../../../core/strings/failure.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final failureOfPosts = await getAllPosts.call();
        failureOfPosts.fold(
          (failure) {
            emit(ErrorPostsState(message: _mapFailureToMessage(failure)));
          },
          (posts) {
            emit(LoadedPostsState(posts: posts));
          },
        );
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error Please try again later!";
    }
  }
}
