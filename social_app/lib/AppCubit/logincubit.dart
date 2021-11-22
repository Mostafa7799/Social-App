import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotial_app/AppState/loginstates.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);



   void userLogin(
       {required String email , required String password})
   {
     FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: password
     ).then((value) {
       print(value.user);
       emit(LoginSuccessStates(value.user!.uid));
     }).catchError((error){
       emit(LoginErrorStates(error.toString()));
     });
   }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShow = true;

  void changePasswordVisibility(){

    isPasswordShow =! isPasswordShow;
    suffix =isPasswordShow? Icons.visibility_outlined: Icons.visibility_off_outlined ;
    emit(LoginChangePasswordStates());
  }
// no used
//   void checkEmailPassword(context){
//     if(loginModel.status==true){
//       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
//           ShopHomeScreen()), (Route<dynamic> route) => true);
//     }else{
//       showToast(loginModel.message);
//     }
//     emit(LoginCheckEmailPasswordStates());
//   }


}