import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotial_app/AppCubit/bloc_ops.dart';
import 'package:sotial_app/AppCubit/home_cubit.dart';
import 'package:sotial_app/AppState/home_states.dart';
import 'package:sotial_app/network/dio_helper.dart';

import 'package:sotial_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sotial_app/var.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());

  });
  print(token);
  Bloc.observer = MyBlocObserver();

  //uId = DioHelper.getData(token:'uId');

  // late Widget widget;
  //
  // if(uId != null){
  //   widget  = HomeScreen();
  // }else{
  //   widget  = LoginScreen();
  // }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => HomeCubit()..getUserData()..getPost(),
        ),
      ],
      child:BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black87,
                )
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.black,
                elevation: 20.0,
                backgroundColor: Colors.white
              )
            ),
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}


