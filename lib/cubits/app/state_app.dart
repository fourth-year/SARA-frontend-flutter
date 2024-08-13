
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/network/end_point.dart';

import '../../network/cach_helper.dart';
import 'cubit_app.dart';

class AppCubit extends Cubit<AppSates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
/////////////////////////////////////////////////

bool  isdark=dark;
  void changthem (bool value){
    isdark=value;
    CachHelper.saveData(key:"isdark", value: isdark);
emit(AppChangeThem());


  }





}
enum ThemeState{intial,dark,light}
