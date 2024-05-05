import 'package:dio/dio.dart';
import 'package:sara_front/network/end_point.dart';

class DioHelper{

 static late  Dio  dio;
  static init(){
    dio=Dio(BaseOptions(
               baseUrl:baseurl ,
      receiveDataWhenStatusError: true,
       ));

        }


 static Future<Response> postData({
   required String url,
   required Map<String,dynamic> data,

 })async{
    dio.options.headers={
     'Accept':'application/json',
   };

   return  await dio.post(url,data: data);

 }









}