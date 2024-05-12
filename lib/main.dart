import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sara_front/components/colors.dart';
import 'package:sara_front/network/cach_helper.dart';
import 'package:sara_front/network/dio_helper.dart';
import 'package:sara_front/register/reset_password.dart';
import 'package:sara_front/register/signup.dart';
import 'package:sara_front/screen/add_animals.dart';
import 'package:sara_front/screen/layout.dart';

import 'bloc_observer.dart';
import 'package:sara_front/cubits/register/cubit.dart';

import 'cubits/cubits_animals/cubit.dart';
void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) =>registerCubit()),
        BlocProvider(create: (BuildContext context) =>AnimalCubit()),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: ColorApp.color1),
          useMaterial3: true,
        ),
        home: AddAnimal(),
      ),
    );
  }
}

