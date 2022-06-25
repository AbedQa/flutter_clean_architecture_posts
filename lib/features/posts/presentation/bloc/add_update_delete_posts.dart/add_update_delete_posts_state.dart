part of 'add_update_delete_posts_bloc.dart';

abstract class AddUpdateDeletePostsState extends Equatable {
  const AddUpdateDeletePostsState();

  @override
  List<Object> get props => [];
}

class AddUpdateDeletePostsInitial extends AddUpdateDeletePostsState {}

class AddUpdateDeletePostsLoading extends AddUpdateDeletePostsState {}

class AddUpdateDeletePostsLoaded extends AddUpdateDeletePostsState {
  final String message;

  const AddUpdateDeletePostsLoaded({required this.message});

  @override
  List<Object> get props => [message];
}

class AddUpdateDeletePostsFailure extends AddUpdateDeletePostsState {
  final String message;

  const AddUpdateDeletePostsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
