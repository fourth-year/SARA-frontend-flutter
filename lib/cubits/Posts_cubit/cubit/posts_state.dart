part of 'posts_cubit.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

class Loading extends PostsState {}

class GetAllPostsSuccessfully extends PostsState {}
class GetAllPostsError extends PostsState {}

class CommentAddedSuccessfully extends PostsState {}
class CommentAddedError extends PostsState {}

class CommentUpdatedSuccessfully extends PostsState {}
class CommentUpdatedError extends PostsState {}

class LikeAddedSuccessfully extends PostsState {}
class LikeAddedError extends PostsState {}

class LikeDeletedSuccessfully extends PostsState {}
class LikeDeletedError extends PostsState {}