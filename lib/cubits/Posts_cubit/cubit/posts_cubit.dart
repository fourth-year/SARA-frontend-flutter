import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sara_front/models/All_posts_model.dart';
import 'package:sara_front/network/dio_helper.dart';
import 'package:sara_front/network/end_point.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());
  static PostsCubit get(context) => BlocProvider.of(context);
  //////////////////////////////////////////////////////////////////

  AllPosts? get_allPosts;

  Future<void> getAllPosts() async {
    emit(Loading());
    DioHelper.getData(
      url: baseurl + "/user/posts",
    ).then((value) {
      get_allPosts = AllPosts.fromJson(value.data);
      print(value.data);
      print(get_allPosts?.success);
      emit(GetAllPostsSuccessfully());
    }).catchError((error) {
      print(error.toString());

      emit(GetAllPostsError());
    });
  }
  //////////////////////////////////////////////////////////////////
  void addComment({
    required comment,
    required post_id,
  }) {
    emit(Loading());
    DioHelper.postData(url: baseurl + '/user/comment/add', data: {
      'comment': comment,
      'post_id': post_id,
    }).then((value) {
      print(value.data);
      emit(CommentAddedSuccessfully());
    }).catchError((error) {
      print(error.toString());
      emit(CommentAddedError());
    });
  }
  ///////////////////////////////////////////////////////////////////
   void updateComment({
    required comment,
    required id,
  }) {
    emit(Loading());
    DioHelper.postData(url: baseurl + '/user/comment/update/${id}', data: {
      'comment': comment,
    }).then((value) {
      print(value.data);
      emit(CommentUpdatedSuccessfully());
    }).catchError((error) {
      print(error.toString());
      emit(CommentUpdatedError());
    });
  }
  //////////////////////////////////////////////////////////////////////////
  void addLike({
    required post_id,
    required user_id,
  }){
  DioHelper.postData(url: baseurl + '/user/likes',data: {
    'post_id':post_id,
    'user_id':user_id,
  }).then((value){
     print(value.data);
      emit(LikeAddedSuccessfully());
  }).catchError((error) {
      print(error.toString());
      emit(LikeAddedError());
    });
  }
  ///////////////////////////////////////////////////////////////////////////

void removeLike({
    required id,
    required user_id,
    required post_id,
  }){
  DioHelper.postData(url: baseurl + '/user/unlikes/${id}',data: {
    'post_id':post_id,
    'user_id':user_id,
  }).then((value){
     print(value.data);
      emit(LikeDeletedSuccessfully());
  }).catchError((error) {
      print(error.toString());
      emit(LikeDeletedError());
    });
  }
  ///////////////////////////////////////////////////////////////////////////






}


