import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sara_front/models/All_posts_model.dart';
import 'package:sara_front/models/all_Comments_for_Post.dart';
import 'package:sara_front/models/get_comment_by_id.dart';
import 'package:sara_front/models/post_model.dart';
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

  ////////////////////////////////////////////////////////////////////
  PostByIdModel? get_post_by_id;

  Future<void> getPostByid({required id}) async {
    emit(Loading());
    DioHelper.getData(
      url: baseurl + "/user/post/get/${id}",
    ).then((value) {
      get_post_by_id = PostByIdModel.fromJson(value.data);
      print(value.data);
      emit(GetPostByIdSuccessfully());
    }).catchError((error) {
      print(error.toString());
      emit(GetPostByIdError());
    });
  }

  //////////////////////////////////////////////////////////////////
  AllCommentsForPostModel? get_allComments;

  Future<void> getComments({
    required id,
  }) async {
    emit(Loading());
    DioHelper.getData(
      url: baseurl + "/user/postcomments/get/${id}",
    ).then((value) {
      get_allComments = AllCommentsForPostModel.fromJson(value.data);
      print(value.data);
      print(get_allComments?.success);
      emit(GetAllCommentsSuccessfully());
    }).catchError((error) {
      print(error.toString());

      emit(GetAllCommentsError());
    });
  }

  //////////////////////////////////////////////////////////////////
  CommentByIdModel? get_comment_by_id;

  Future<void> getCommentByid({required id}) async {
    emit(Loading());
    DioHelper.getData(
      url: baseurl + "/user/comment/get/${id}",
    ).then((value) {
      get_comment_by_id = CommentByIdModel.fromJson(value.data);
      print(value.data);
      emit(GetCommentByIdSuccessfully());
    }).catchError((error) {
      print(error.toString());
      emit(GetCommentByIdError());
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

  //////////////////////////////////////////////////////////////////
  void DeleteComment({
    required id,
  }) {
    emit(Loading());
    DioHelper.DeleteData(url: baseurl + '/user/comment/delete/${id}')
        .then((value) {
      print(value.data);
      emit(CommentdeletedSuccessfully());
    }).catchError((error) {
      print(error.toString());
      emit(CommentdeletedError());
    });
  }

  //////////////////////////////////////////////////////////////////////////
  void addLike({
    required post_id,
  }) {
    DioHelper.postData(url: baseurl + '/user/likes', data: {
      'post_id': post_id,
    }).then((value) {
      print(value.data);
      emit(LikeAddedSuccessfully());
    }).catchError((error) {
      print(error.toString());
      emit(LikeAddedError());
    });
  }
  ///////////////////////////////////////////////////////////////////////////

  void removeLike({
    required post_id,
  }) {
    DioHelper.postData(url: baseurl + '/user/unlikes/${post_id}').then((value) {
      print(value.data);
      emit(LikeDeletedSuccessfully());
    }).catchError((error) {
      print(error.toString());
      emit(LikeDeletedError());
    });
  }

  ///////////////////////////////////////////////////////////////////////////
  // void add_Request_JoinUs({
  //   required age,
  //   required job_title,
  //   required start_time,
  //   required end_time,
  // }) {
  //   var data = FormData.fromMap({
  //     'age': age,
  //     'job_title': job_title,
  //     'start_time': start_time,
  //     'end_time': end_time
  //   });
  //   log(data.fields.toString());
  //   DioHelper.postData(url: baseurl + '/user/empreq', data: data).then((value) {
  //     print(value.data);
  //     emit(JoinUsSuccess());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(JoinUsError());
  //   });
  // }
/////////////////////////////////////////////////////////////////////////////
  void add_Request_JoinUs({
    required age,
    required job_title,
    required start_time,
    required end_time,
  }) {
    // var data = FormData.fromMap({
    //   'age': age,
    //   'job_title': job_title,
    //   'start_time': start_time,
    //   'end_time': end_time
    // });
    // log(data.fields.toString());
    DioHelper.postData(url: baseurl + '/user/empreq', data: {
      'age': age,
      'job_title': job_title,
      'start_time': start_time,
      'end_time': end_time
    }).then((value) {
      print(value.data);
      emit(JoinUsSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(JoinUsError());
    });
  }

///////////////////////////////////////////////////////////////////////////
  String selectstarttime = "";
  void selectstartTime(dynamic s_time) {
    selectstarttime = s_time;
    emit(StartTimeState());
  }

  String selectendtime = "";
  void selectendTime(dynamic e_time) {
    selectendtime = e_time;
    emit(EndTimeState());
  }
}
