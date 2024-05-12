import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/models/AllAnimalmodel.dart';
import 'package:sara_front/network/dio_helper.dart';
import 'package:sara_front/network/end_point.dart';

import '../../models/GetCat.dart';
import '../../screen/add_animals.dart';
import '../../screen/show_animals.dart';
import 'states.dart';


class AnimalCubit extends Cubit<AnimalStates> {
  AnimalCubit() :super(AnimalInitialState());
  static AnimalCubit get(context) => BlocProvider.of(context);


  void addAnimal({
    required name,
    required age,
    required date,
    required type,
     required Dep,
  }){
    emit(AnimalLoadingState());
    DioHelper.postData(
        url: baseurl+'/animal/add',
        data: {
          'name':name,
          'age':age,
          'entry_date':date,
          'animaltype_id':type,
          'department_id':Dep,
          'photo':"zxcvbnm,jhgfdsdfghj",
        }
    ).then((value) {
      print(value.data);
      emit(AddAnimalSuccessState());
    }).catchError((error){
      print(error.toString());

      emit(AddAnimalErrorState());
    });
  }

  int type_num=1;
  void Select_type (dynamic type){
    type_num=type;
    emit(TypeAnimalState());

  }

  int Dep_num=1;
  void Select_Dep (dynamic dep) {
    Dep_num = dep;
    emit(DepAnimalState());
  }

  String selectDate="";
  void selectdate (dynamic s_date){
    selectDate=s_date;
    emit(DateAnimalState());

  }


  /////////////// gat all animal
  AllAnimals? allanimals;


  Future<void> getAllAnimal()async
  {
    emit(AnimalLoadingState());
    DioHelper.getData(
      url: baseurl+"/animal/getall",
    ).then((value){
      allanimals = AllAnimals.fromJson(value.data);
      print(allanimals?.success);
      emit(GetAnimalSuccessState());

    }).catchError((erroe){
      print(erroe.toString());

      emit(GetAnimalErrorState());
    });

  }

////////////////////// get animal by type

  GetCats? catsanimals;

  Future<void> getAllCats()async
  {
    emit(AnimalLoadingState());
    DioHelper.getData(
      url: baseurl+"/animal-types/getType/1",
    ).then((value){
      catsanimals = GetCats.fromJson(value.data);
      print(catsanimals?.status);
      emit(GetCatsSuccessState());

    }).catchError((erroe){
      print(erroe.toString());
      emit(GetCatsErrorState());
    });

  }





/////////////////////
  int curentindex=0;



  List<Widget> screen = [
    Show_Animals(),

    AddAnimal(),
    Show_Animals(),
    AddAnimal(),

  ];


  void changBottom(int index) {
    curentindex = index;
  }




}