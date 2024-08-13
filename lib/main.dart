import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/cubits/Emergencies/cubit/emergency_cubit.dart';
import 'package:sara_front/cubits/Posts_cubit/cubit/posts_cubit.dart';
import 'package:sara_front/cubits/app/cubit_app.dart';
import 'package:sara_front/cubits/app/state_app.dart';
import 'package:sara_front/network/cach_helper.dart';
import 'package:sara_front/network/dio_helper.dart';
import 'package:sara_front/network/end_point.dart';
import 'package:sara_front/register/reset_password.dart';
import 'package:sara_front/register/signin.dart';
import 'package:sara_front/register/signup.dart';
import 'package:sara_front/screen/Emergencies.dart';
import 'package:sara_front/screen/Settings.dart';
import 'package:sara_front/screen/add_animals.dart';
import 'package:sara_front/screen/add_emergency.dart';
import 'package:sara_front/screen/animal_details.dart';
import 'package:sara_front/screen/home.dart';
import 'package:sara_front/screen/join_us_page.dart';

import 'package:sara_front/screen/layout.dart';
import 'package:sara_front/screen/show_animals.dart';

import 'bloc_observer.dart';
import 'package:sara_front/cubits/register/cubit.dart';
import 'cubits/User/cubit.dart';
import 'cubits/cubits_animals/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  Widget widget;
  if (CachHelper.gettoken(key: "token") == null) {
    widget = JoinUsPage();
  } else {
    token = CachHelper.gettoken(key: "token");
    role_id = CachHelper.getData(key: "role_id");
    print(token);
    print(role_id);

    widget = JoinUsPage();
  }
  if(CachHelper.getData(key: "isdark")!=null){
    dark=CachHelper.getData(key: "isdark");
  }
  else
    dark=false;
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en')],
        path: 'assets/translation',
        fallbackLocale: Locale('en'),
        child: MyApp(startwidget: widget)),
  );
}

class MyApp extends StatelessWidget {
  MyApp({required this.startwidget});
  Widget startwidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => registerCubit()),
        BlocProvider(create: (BuildContext context) => AnimalCubit()),
        BlocProvider(create: (BuildContext context) => PostsCubit()),
        BlocProvider(create: (BuildContext context) => UserCubit()),
        BlocProvider(create: (BuildContext context) => EmergencyCubit()),
        BlocProvider(create: (BuildContext context) => AppCubit()..changthem(dark),
        ),
      ],
      child: BlocConsumer<AppCubit, AppSates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: ' S.A.R.A',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: ColorApp.color2),

              // colorSchemeSeed:ColorApp.color2 ,
                brightness: Brightness.light,
                tabBarTheme: TabBarTheme(
                  unselectedLabelColor: Colors.grey[400],
                  labelColor: ColorApp.color2,
                    dividerHeight: 0.5,
                    indicatorColor:ColorApp.color2,
                ),
                cardTheme: CardTheme(shadowColor:ColorApp.colorback ,color:ColorApp.colorback ),
                canvasColor: Colors.grey[700],
                scaffoldBackgroundColor: ColorApp.colorback,

                appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  titleTextStyle: TextStyle(color: ColorApp.color2),
                ),

                textTheme: TextTheme(

                  subtitle1: TextStyle(color: Colors.black ,
                    fontSize: 14,fontFamily: 'text normal',
                    fontWeight: FontWeight.w100,),
                  subtitle2: TextStyle(color: Colors.white ,
                    fontSize: 14,
                    fontWeight: FontWeight.w100,fontFamily: 'text normal'),
                  headline2: TextStyle(color: ColorApp.color1 ,
                    fontSize: 25,fontFamily: 'text normal',
                    fontWeight: FontWeight.w100,),
                  headline4: TextStyle(color: ColorApp.color2 ,
                    fontSize: 18,fontFamily: 'text normal',
                    fontWeight: FontWeight.w100,),
                  headline1: TextStyle(fontSize: 18,
                      color: ColorApp.color2, fontFamily: 'text normal'),
                  headline5: TextStyle(
                      color: ColorApp.color2, fontFamily: 'text normal'),
                  headline6: TextStyle(color: Colors.black ,
                    fontSize: 18,fontFamily: 'text normal',
                    fontWeight: FontWeight.w100,),
                  headline3: TextStyle(
                      color: ColorApp.color2, fontFamily: "title",fontSize: 35),


                ),


            ),

            ////////////////////////dark
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              tabBarTheme: TabBarTheme(
                  unselectedLabelColor: Colors.grey[600],
                  labelColor: ColorApp.colorback,
                  dividerHeight: 0.5,
                  indicatorColor:ColorApp.color2
              ),

              cardTheme: CardTheme(shadowColor: Colors.grey[700],color:Colors.grey[600] ),
              canvasColor: Colors.grey[700],
              scaffoldBackgroundColor: Colors.grey[850],
              dialogBackgroundColor: Colors.grey,

              textTheme: TextTheme(
                headline4: TextStyle(color: Colors.black ,
                fontSize: 18,fontFamily: 'text normal',
                fontWeight: FontWeight.w100,),
          subtitle2: TextStyle(color: Colors.white ,
          fontSize: 14,fontFamily: 'text normal',
          fontWeight: FontWeight.w100,),
                subtitle1: TextStyle(color: Colors.black ,
                  fontSize: 14,fontFamily: 'text normal',
                  fontWeight: FontWeight.w100,),
                headline6: TextStyle(color: Colors.white ,
                  fontSize: 18,fontFamily: 'text normal',
                  fontWeight: FontWeight.w100,),
                headline2: TextStyle(color: Colors.white ,
                  fontSize: 20,fontFamily: 'text normal',
                  fontWeight: FontWeight.w100,),


                headline5: TextStyle(color: ColorApp.color, fontFamily: 'text normal'),
              ),



            ),
            themeMode:
                AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: startwidget,
          );
        },
        // child: MaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   title: ' S.A.R.A',
        //   theme: ThemeData(
        //     // appBarTheme: AppBarTheme(
        //     //   titleTextStyle: TextStyle(color: Colors.green),
        //     // )
        //     scaffoldBackgroundColor: ColorApp.colorback,
        //     textTheme: TextTheme(
        //       headline5: TextStyle(
        //           color: ColorApp.color2,fontFamily: 'text normal'),)
        //   ),
        //   darkTheme: ThemeData(scaffoldBackgroundColor:Colors.black45,
        //       textTheme: TextTheme(
        //         headline5: TextStyle( color: ColorApp.color,fontFamily: 'text normal'),)
        //   ),
        //   themeMode: AppCubit.get(context).isdark?ThemeMode.dark:ThemeMode.light,
        //   localizationsDelegates: context.localizationDelegates,
        //   supportedLocales: context.supportedLocales,
        //   locale: context.locale,
        //   home: startwidget,
        // ),
      ),
    );
  }
}
