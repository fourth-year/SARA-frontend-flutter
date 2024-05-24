import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/models/LoginModel.dart';
import 'package:sara_front/models/SignupModel.dart';
import 'package:sara_front/network/dio_helper.dart';
import '../../../network/end_point.dart';
import '../../network/cach_helper.dart';
import 'states.dart';

class registerCubit extends Cubit<registerSates>{

  registerCubit():super(LoginInitialState());
  static registerCubit get(context)=>BlocProvider.of(context);
  late  LoginModels loginModels;
  late  SignupModel signupModels;

///////////////////////// sign up
  void SignUp({
    required  email,
    required  password,
    required  c_password,
    required  address,
    required  name,
    required  phone,
    required String? photo,
    required  gender,

  }){
    emit(SignupLoadingState());
    DioHelper.postData(
        url: baseurl+'/user/signup',
        data: {
          'email':email,
          'password':password,
          'c_password':c_password,
          'address':address,
          'name':name,
          'phone':phone,
          'gender':gender,
          'photo':photo,
        }
    ).then((value) {
      print(value.data);
      signupModels=SignupModel.fromJson(value.data);
      emit(SignupSuccessState(signupModels));
    }).catchError((error){
      print(error.toString());
      emit(SignupErrorState());
    });
  }

///////////////////////// sign in
  void userlogin({
    required String email,
    required String password
  }){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: baseurl+'/user/signin',
        data: {
          'email':email,
          'password':password,
        }
    ).then((value) {
      print(value.data);

      loginModels=LoginModels.fromJson(value.data);
      emit(LoginSuccessState(loginModels));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState());
    });
  }

///////////////////////// forget password
  void forgetpaassword({
    required String email,
  }){
    emit(ForgetLoadingState());
    DioHelper.postData(
        url: baseurl+'/password/email',
        data: {
          'email':email,
        }
    ).then((value) {
      print(value.data);
      emit(ForgetSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ForgetErrorState());
    });
  }

///////////////////////// code
  void codecheke({
    required String code,
}){
    emit(CodeLoadingState());
    DioHelper.postData(
        url: baseurl+"/password/code/check",
        data:{"code": code}
    ).then((value){
      emit(CodeSuccessState());
    }).catchError((error){
      emit(CodeErrorState());
      print(error.toString());

    });
  }


  /////////////////////// reset password
  void resetpassword({
    required String code,
    required String password,
    required String c_password,
  }){
    emit(ResetLoadingState());
    DioHelper.postData(
        url: baseurl+"/password/reset",
        data:{"code": code,
          "password": password,
          "c_password":c_password
        }
    ).then((value){
      emit(ResetSuccessState());
    }).catchError((error){
      emit(ResetErrorState());
      print(error.toString());

    });
  }
  //////////////////////////update profile

  void UpDate({
    required  email,
    required  address,
    required  name,
    required  phone,
    required  photo,
    required  gender,
    required id

  }){
    emit(UpdateLoadingState());
    DioHelper.postData(
        url: baseurl+'/user/update/${id}',
        data: {
          'email':email,
          'address':address,
          'name':name,
          'phone':phone,
          'gender':gender,
          'photo':photo,
        }
    ).then((value) {
      print(value.data);
      emit(UpdateSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(UpdateErrorState());
    });
  }


///////////////////////// log out
  void Log_out (){
    emit(LoginLoadingState());
    DioHelper.postData(url: baseurl+"/user/logout" ).then((value) {
      CachHelper.removeData(key: "token");
      print(value.data);
      emit(LogoutSuccessState());
    }).catchError((error){
      emit(LogoutErrorState());});





  }



///////////////////////// show password
  IconData suffix = Icons.visibility_off_outlined;
  bool ispassword = true;
  void changpassword(){
    ispassword=!ispassword;
    suffix =ispassword? Icons.visibility_off_outlined:Icons.visibility_outlined;
   emit(ChangeIsPasswordd());
  }


  IconData suffix_c = Icons.visibility_off_outlined;
  bool ispassword_c = true;
  void changpassword_c(){
    ispassword_c=!ispassword_c;
    suffix_c =ispassword_c? Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(ChangeIsPasswordd_c());
  }


///////////////////////// select gender
String gender= "male";
 Color m_gender=Colors.black38;
 Color f_gender=Colors.black38;
  void type_gender (String tgender){
    gender=tgender;
    if(gender=="male"){
    m_gender=Colors.black87;
    f_gender=Colors.black38;
    }
    else{
      m_gender=Colors.black38;
      f_gender=Colors.black87;
    }
    print(gender);
    emit(ChangeGender());

  }


}