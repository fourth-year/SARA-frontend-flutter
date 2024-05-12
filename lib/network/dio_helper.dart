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
      'Authorization':'Bearer 1|pUmfNO3HwzZhWcIJR7AqKwJRoCU04eydIhGTfBLPc4c67943'

    };

   return  await dio.post(url,data: data);

 }


 static  Future<Response> getData({
   required String url,
   // required Map<String,dynamic> query,
 })async{
   dio.options.headers={
     'Accept':'application/json',
     'Authorization':'Bearer 1|pUmfNO3HwzZhWcIJR7AqKwJRoCU04eydIhGTfBLPc4c67943'
   };
   return await dio.get(url);
 }






}