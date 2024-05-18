import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/models/AllAnimalmodel.dart';
import 'package:sara_front/network/dio_helper.dart';
import 'package:sara_front/network/end_point.dart';
import 'package:sara_front/screen/update_animal.dart';

import '../../models/GetAnimalByType.dart';
import '../../screen/add_animals.dart';
import '../../screen/show_animals.dart';
import 'states.dart';

class AnimalCubit extends Cubit<AnimalStates> {
  AnimalCubit() : super(AnimalInitialState());
  static AnimalCubit get(context) => BlocProvider.of(context);

/////////////////////// add animals
  void addAnimal({
    required name,
    required age,
    required date,
    required type,
    required Dep,
    required photo,
    required health,
  }) {
    emit(AnimalLoadingState());
    DioHelper.postData(url: baseurl + '/animal/add', data: {
      'name': name,
      'age': age,
      'entry_date': date,
      'animaltype_id': type,
      'department_id': Dep,
      'photo': photo,
      'health': health,
    }).then((value) {
      print(value.data);
      emit(AddAnimalSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(AddAnimalErrorState());
    });
  }

//////////////////// select Dep ,Type ,Date.
  int type_num = 1;
  void Select_type(dynamic type) {
    type_num = type;
    emit(TypeAnimalState());
  }

  int Dep_num = 1;
  void Select_Dep(dynamic dep) {
    Dep_num = dep;
    emit(DepAnimalState());
  }

  String selectDate = "";
  void selectdate(dynamic s_date) {
    selectDate = s_date;
    emit(DateAnimalState());
  }

  ////////////////////////////////////update/3
  //update

  void UpdateAnimal({
    required id,
    required name,
    required age,
    required date,
    required type,
    required Dep,
    required photo,
    required health,
  }) {
    emit(AnimalLoadingState());
    DioHelper.postData(url: baseurl + '/animal/update/2', data: {
      'name': name,
      'age': age,
      'entry_date': date,
      'animaltype_id': type,
      'department_id': Dep,
      'photo': photo,
      'health': health,
    }).then((value) {
      print(value.data);
      emit(AddAnimalSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(AddAnimalErrorState());
    });
  }

//////////////////////////////////////////delete /animal/delete/2
  void DeleteAnimal({
    required id,
  }) {
    emit(AnimalLoadingState());
    DioHelper.DeleteData(
      url: baseurl + '/animal/delete/${id}',
    ).then((value) {
      print(value.statusMessage);
      emit(DeleteAnimalSuccessState(message: value.statusMessage));
    }).catchError((error) {
      print(error.toString());

      emit(DeleteAnimalErrorState(message: error.toString()));
    });
  }

  /////////////// gat all animal
  AllAnimals? allanimals;

  Future<void> getAllAnimal() async {
    emit(AnimalLoadingState());
    DioHelper.getData(
      url: baseurl + "/animals/getall",
    ).then((value) {
      allanimals = AllAnimals.fromJson(value.data);
      print(allanimals?.success);
      emit(GetAnimalSuccessState());
    }).catchError((erroe) {
      print(erroe.toString());

      emit(GetAnimalErrorState());
    });
  }

////////////////////// get animal by type

  GetAnimal_Type? get_animal_type;

  Future<void> getanimal_Type(int type) async {
    emit(AnimalLoadingState());
    DioHelper.getData(
      url: baseurl + "/animal-types/getType/$type",
    ).then((value) {
      get_animal_type = GetAnimal_Type.fromJson(value.data);
      print(get_animal_type?.status);
      emit(GetCatsSuccessState());
    }).catchError((erroe) {
      print(erroe.toString());
      emit(GetCatsErrorState());
    });
  }

///////////////////// masege error
  bool error = false;
  void m_error(bool merror) {
    error = merror;
  }

  bool errorD = false;
  void m_errorD(bool merror) {
    errorD = merror;
  }

///////////////////// Layout.
  int curentindex = 0;
  List<Widget> screen = [
    Show_Animals(),
    AddAnimal(),
    Update_Animal(),
    AddAnimal(),
  ];

  void changBottom(int index) {
    curentindex = index;
  }
}
