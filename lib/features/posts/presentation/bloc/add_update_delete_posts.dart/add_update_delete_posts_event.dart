part of 'add_update_delete_posts_bloc.dart';

abstract class AddUpdateDeletePostsEvent extends Equatable {
  const AddUpdateDeletePostsEvent();

  @override
  List<Object> get props => [];
}

class AddPostsEvent extends AddUpdateDeletePostsEvent {
  final Post post;

  const AddPostsEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePostsEvent extends AddUpdateDeletePostsEvent {
  final Post post;

  const UpdatePostsEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostsEvent extends AddUpdateDeletePostsEvent {
  final int id;

  const DeletePostsEvent({required this.id});

  @override
  List<Object> get props => [id];
}
