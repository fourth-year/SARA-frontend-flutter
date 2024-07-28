import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/cubits/User/state.dart';
import 'package:sara_front/models/Walletmodel.dart';
import 'package:sara_front/network/cach_helper.dart';
import 'package:sara_front/network/dio_helper.dart';
import 'package:sara_front/network/end_point.dart';

import '../../models/adoption_Model.dart';
import '../../models/sessionModel.dart';
import '../../models/session_userModel.dart';
import '../../models/sponcershipmodel.dart';

class UserCubit extends Cubit<UserSates> {
  UserCubit() : super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);
  WalletModel? walletmodel;
  void user_Wallet() {
    String user_id = CachHelper.getData(key: "id").toString();
    emit(WalletLoadingState());
    DioHelper.getData(url: baseurl + "/user/wallet/get/$user_id").then((value) {
      walletmodel = WalletModel.fromJson(value.data);
      emit(WalletSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(WalletErrorState());
    });
  }

  void post_donation({required balance}) {
    emit(DonationLoadingState());
    DioHelper.postData(url: baseurl + '/user/donation/add', data: {
      'balance': balance,
    }).then((value) {
      print(value.data);

      emit(DonationSuccessState());
    }).catchError((error) {
      print(error.toString());
      String errorMessage = error.toString();
      if (errorMessage.contains('400')) {

        emit(DonationErrorState(mes: "You don't have enough balance"));
      } else {
        emit(DonationErrorState(mes: "An error occurred, try agian"));
      }
    });
  }
  AdoptionModel? adoptionmodel;
  void adoptionuser() {
    String user_id = CachHelper.getData(key: "id").toString();
    emit(adoptionLoadingState());
    DioHelper.getData(url: baseurl + "/user/adoptions/user/$user_id").then((value) {
      adoptionmodel = AdoptionModel.fromJson(value.data);
      emit(adoptionSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(adoptionErrorState());
    });
  }

  SponcershipModel? sponcershipmodel;
  void sponcershipsuser() {
    String user_id = CachHelper.getData(key: "id").toString();
    emit(sponcershipsLoadingState());
    DioHelper.getData(url: baseurl + "/user/sponcerships/user/$user_id").then((value) {
      sponcershipmodel = SponcershipModel.fromJson(value.data);
      emit(sponcershipsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(sponcershipsErrorState());
    });
  }

///////////////////////////////////
  SessionModel? sessionmodel;
  void all_session() {
    String user_id = CachHelper.getData(key: "id").toString();
    emit(sessionLoadingState());
    DioHelper.getData(url: baseurl + "/user/sessions").then((value) {
      sessionmodel = SessionModel.fromJson(value.data);
      emit(sessionSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(sessionErrorState());
    });
  }
///////////////////////////////////////
  void session_P({required session_id}) {
    emit(sessionLoadingState());
    DioHelper.postData(url: baseurl + '/user/user_session/add', data: {
      'session_id': session_id,
    }).then((value) {
      print(value.data);

      emit(session_PSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(session_PErrorState());
    });
  }
///////////////////////////////////////
  SessionUserModel? session_user;


  void user_session() {
    String user_id = CachHelper.getData(key: "id").toString();
    emit(sessionLoadingState());
    DioHelper.getData(url: baseurl + "/user/user_sessions").then((value) {
      session_user = SessionUserModel.fromJson(value.data);
      emit(session_UserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(session_UserErrorState());
    });
  }





  ///////////////////////////////////////
  String select= "all";
  Color m_gender=Colors.black38;
  Color f_gender=Colors.black38;
  void type_select (String tselect){
    select=tselect;
    if(select=="your"){
      m_gender=Colors.black87;
      f_gender=Colors.black38;
    }
    else{
      m_gender=Colors.black38;
      f_gender=Colors.black87;
    }
    print(select);
    emit(Changeselect());

  }


}
