import 'dart:js';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/cubits/Posts_cubit/cubit/posts_cubit.dart';
import 'package:sara_front/cubits/cubit/app_cubit.dart';
import 'package:sara_front/network/cach_helper.dart';
import 'package:sara_front/network/dio_helper.dart';
import 'package:sara_front/network/end_point.dart';
import 'package:sara_front/register/reset_password.dart';
import 'package:sara_front/register/signin.dart';
import 'package:sara_front/register/signup.dart';
import 'package:sara_front/screen/Settings.dart';
import 'package:sara_front/screen/add_animals.dart';
import 'package:sara_front/screen/animal_details.dart';
import 'package:sara_front/screen/home.dart';

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
    widget = signin();
  } else {
    token = CachHelper.gettoken(key: "token");
    role_id = CachHelper.getData(key: "role_id");
    print(token);
    print(role_id);

    widget = Layout();
  }
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
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(create: (BuildContext context) => PostsCubit()),
        BlocProvider(create: (BuildContext context) => UserCubit()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ' S.A.R.A',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorApp.color2),
          useMaterial3: true,
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: startwidget,
      ),
    );
  }
}
