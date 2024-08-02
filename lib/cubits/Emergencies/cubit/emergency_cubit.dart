import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sara_front/models/all_emergencies_model.dart';
import 'package:sara_front/network/dio_helper.dart';
import 'package:sara_front/network/end_point.dart';

part 'emergency_state.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  EmergencyCubit() : super(EmergencyInitial());
  static EmergencyCubit get(context) => BlocProvider.of(context);

/////////////////////////////////////////////////////////////////////////////
  // EmergencyResponseModel? get_emergency_response;

  void addEmergency({
    required address,
    required description,
    required contact,
    required photo,
  }) {
    emit(Loading());
    DioHelper.postData(url: baseurl + '/user/emergency/req', data: {
      'address': address,
      'description': description,
      'contact': contact,
      'photo': photo,
    }).then((value) {
      print(value.data);
      emit(EmergencyAddedSuccessfully());
    }).catchError((error) {
      print(error.toString());
      emit(EmergencyAddedError());
    });
  }

/////////////////////////////////////////////////////////////////////////////
  AllEmergencyModel? get_all_emergencies;

  Future<void> getAll_Emergencies({
    required int status,
  }) async {
    emit(Loading());
    DioHelper.getData(
      url: baseurl + "/user/emergency/getall?status=${status}",
    ).then((value) {
      get_all_emergencies = AllEmergencyModel.fromJson(value.data);
      print(value.data);
      print(get_all_emergencies?.success);
      emit(GetAllEmergenciesSuccessfully());
    }).catchError((error) {
      print(error.toString());

      emit(GetAllEmergenciesError());
    });
  }

  ////////////////////////////////////////////////////////////////////////////
 void DeleteEmergency({required id}) {
    emit(Loading());
    DioHelper.postData(url: baseurl + '/user/emergency/delete/${id}')
        .then((value) {
      print(value.data);
      emit(DeleteEmergencySuccessfully());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteEmergencyError());
    });
  }

  /////////////////////////////////////////////////////////////////////////////

  void AcceptEmergency({required id}) {
    emit(Loading());
    DioHelper.postData(url: baseurl + '/user/emergency/accept/${id}')
        .then((value) {
      print(value.data);
      emit(AcceptEmergencySuccessfully());
    }).catchError((error) {
      print(error.toString());
      emit(AcceptEmergencyError());
    });
  }
}
