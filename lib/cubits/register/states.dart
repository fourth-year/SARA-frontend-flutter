

import 'package:sara_front/models/LoginModel.dart';
import 'package:sara_front/models/SignupModel.dart';

abstract class registerSates{}
class LoginInitialState extends registerSates{}

class LoginLoadingState extends registerSates{}
class LoginSuccessState extends registerSates{
 late final LoginModels loginModel;
 LoginSuccessState(this.loginModel);}
class LoginErrorState extends registerSates{}

class ForgetLoadingState extends registerSates{}
class ForgetSuccessState extends registerSates{}
class ForgetErrorState extends registerSates{}

class CodeLoadingState extends registerSates{}
class CodeSuccessState extends registerSates{}
class CodeErrorState extends registerSates{}

class ResetLoadingState extends registerSates{}
class ResetSuccessState extends registerSates{}
class ResetErrorState extends registerSates{}


class SignupLoadingState extends registerSates{}
class SignupSuccessState extends registerSates{
 late final SignupModel signupModel;
 SignupSuccessState(this.signupModel);
}
class SignupErrorState extends registerSates{}


 class ChangeIsPasswordd extends registerSates{}
class ChangeGender extends registerSates{}