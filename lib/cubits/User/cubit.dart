import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/cubits/User/state.dart';
import 'package:sara_front/models/Walletmodel.dart';
import 'package:sara_front/network/cach_helper.dart';
import 'package:sara_front/network/dio_helper.dart';
import 'package:sara_front/network/end_point.dart';

class UserCubit extends Cubit<UserSates> {

  UserCubit() :super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);
  WalletModel? walletmodel;
  void user_Wallet(){
    String user_id=CachHelper.getData(key: "id").toString();
emit(WalletLoadingState());
DioHelper.getData(url: baseurl+"/user/wallet/get/$user_id").then((value) {
  walletmodel = WalletModel.fromJson(value.data);
  emit(WalletSuccessState());
}).catchError((error){
  print(error.toString());
  emit(WalletErrorState());
    });
  }


  void post_donation({
  required balance})
  {
    emit(DonationLoadingState());
    DioHelper.postData(
        url: baseurl+'/user/donation/add',
        data: {
          'balance':balance,
        }
    ).then((value) {
      print(value.data);

      emit(DonationSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(DonationErrorState());
    });


  }


}