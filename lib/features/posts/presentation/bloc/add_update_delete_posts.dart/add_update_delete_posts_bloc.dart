import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/entities/post.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/usecases/add_posts.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/usecases/delete_posts.dart';
import 'package:flutter_clean_architecture_posts/features/posts/domain/usecases/update_posts.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failure.dart';
import '../../../../../core/strings/messages.dart';

part 'add_update_delete_posts_event.dart';
part 'add_update_delete_posts_state.dart';

class AddUpdateDeletePostsBloc
    extends Bloc<AddUpdateDeletePostsEvent, AddUpdateDeletePostsState> {
  final AddPostsUsecase addPosts;
  final UpdatePostsUsecase updatePosts;
  final DeletePostsUsecase deletePosts;

  AddUpdateDeletePostsBloc({
    required this.addPosts,
    required this.updatePosts,
    required this.deletePosts,
  }) : super(AddUpdateDeletePostsInitial()) {
    on<AddUpdateDeletePostsEvent>((event, emit) async {
      if (event is AddPostsEvent) {
        emit(AddUpdateDeletePostsLoading());

        final failureOrDoneMessage = await addPosts.call(event.post);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      } else if (event is UpdatePostsEvent) {
        emit(AddUpdateDeletePostsLoading());
        final failureOrDoneMessage = await updatePosts.call(event.post);

        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      } else if (event is DeletePostsEvent) {
        emit(AddUpdateDeletePostsLoading());
        final failureOrDoneMessage = await deletePosts.call(event.id);

        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddUpdateDeletePostsState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => AddUpdateDeletePostsFailure(
        message: _mapFailureToMessage(failure),
      ),
      (_) => AddUpdateDeletePostsLoaded(message: message),
    );
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
