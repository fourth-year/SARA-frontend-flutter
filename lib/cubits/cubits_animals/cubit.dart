import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/models/AllAnimalmodel.dart';
import 'package:sara_front/models/GetFeeding.dart';
import 'package:sara_front/models/getAnimal_id.dart';
import 'package:sara_front/network/dio_helper.dart';
import 'package:sara_front/network/end_point.dart';
import 'package:sara_front/screen/update_animal.dart';

import '../../models/GetAnimalByType.dart';
import '../../models/GetVaccination.dart';
import '../../screen/Jops.dart';
import '../../screen/add_animals.dart';
import '../../screen/home.dart';
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

  String selectHealth = "";
  void selecthealth(dynamic s_health) {
    selectHealth = s_health;
    emit(HealthAnimalState());
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
    DioHelper.postData(url: baseurl + '/animal/update/${id}', data: {
      'name': name,
      'age': age,
      'entry_date': date,
      'animaltype_id': type,
      'department_id': Dep,
      'photo': photo,
      'health': health,
    }).then((value) {
      print("ok");
      print(value.data);
      emit(UpdateAnimalSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(UpdateAnimalErrorState());
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
      emit(DeleteAnimalSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(DeleteAnimalErrorState());
    });
  }

//////////////////////////////////////////////////////////  get_Animal
  GetAnimal_byid_Model? get_Animal_By_id;

  Future<void> getanimal_Byid(int id) async {
    emit(AnimalLoadingState());
    DioHelper.getData(
      url: baseurl + "/animal/get/$id",
    ).then((value) {
      get_Animal_By_id = GetAnimal_byid_Model.fromJson(value.data);
      print(get_animal_type?.status);
      emit(GetAnimalByIdSuccessState());
    }).catchError((erroe) {
      print(erroe.toString());
      emit(GetAnimalByIdErrorState());
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
    Home(),
    AddAnimal(),
    Jops(),
  ];

  void changBottom(int index) {
    curentindex = index;
  }

  ///////////////////////// Feeding
  Get_Feeding? feeding_modle;
  Future<void>feedingAnimal()async{
  emit(AnimalLoadingState());
  DioHelper.getData(
    url: baseurl + "/user/unfed-departments",
  ).then((value) {
    feeding_modle = Get_Feeding.fromJson(value.data);
    print(feeding_modle!.data);
    emit( FeedingSuccessState());
  }).catchError((erroe) {
    print(erroe.toString());

    emit( FeedingErrorState());
  });

}
  // List<bool> _isChecked=[];
  //
  // void check(int index, bool value) {
  //   _isChecked[index] = value;
  //   emit(CheckState()); // notify the UI to rebuild
  // }
  //
  // bool getIsChecked(int index) => _isChecked[index];


  bool ischeck=false;
  void check (dynamic is_check){
    ischeck=is_check;
    emit(CheckState());

  }

  void Can_Feeding(
    {required id_dep,
    required id}
      ){

    emit(AnimalLoadingState());
    DioHelper.postData(url: baseurl + '/user/employee/feeding/add', data: {
      'user_id': id,
      'department_id': id_dep,
    }).then((value) {
      print("ok");
      print(value.data);
      emit(CanFeedingSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(CanFeedingErrorState());
    });
  }

  ///////////////////////////// vaccination
  Vaccination? vaccination_modle;
  Future<void>vaccinationAnimal()async{
    emit(AnimalLoadingState());
    DioHelper.getData(
      url: baseurl + "/user/unVac-departments",
    ).then((value) {
      vaccination_modle = Vaccination.fromJson(value.data);
      print(vaccination_modle!.data);
      emit( vaccinationSuccessState());
    }).catchError((erroe) {
      print(erroe.toString());
      emit( vaccinationErrorState());
    });

  }


  void Can_vaccination(
      {required id_dep}
      ){

    emit(AnimalLoadingState());
    DioHelper.postData(url: baseurl + '/user/employee/vaccination/add', data: {
      'department_id': id_dep,
    }).then((value) {
      print(value.data);
      emit(CanvaccinationSuccessState());
    }).catchError((error) {
      print(error.toString());
      print(" kkkkkkkkkkkkkkkkkkkkkkkkkkkk");
      // print(s);
      emit(CanvaccinationErrorState());
    });
  }

//////////////////////////////// adoptions
void adoptions({
    required animal_id
}){
  emit(adoptionsLoadingState());
  DioHelper.postData(url: baseurl + '/user/adoption/Req', data: {
    'animal_id': animal_id,
  }).then((value) {
    print(value.data);
    emit(adoptionsSuccessState());
  }).catchError((error) {
    print(error.toString());

    emit(adoptionsErrorState());

  });
  }

  //////////////////////////////// sponcership
  void sponcership({
    required animal_id,
    required balance
  }){
    emit(sponcershipLoadingState());
    DioHelper.postData(url: baseurl + '/user/sponcership/req', data: {
      'animal_id': animal_id,
      'balance':balance
    }).then((value) {
      print(value.data);
      emit(sponcershipSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(sponcershipErrorState(error.hashCode));
    });


  }

}
