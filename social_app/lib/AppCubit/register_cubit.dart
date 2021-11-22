import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotial_app/AppState/register_state.dart';
import 'package:sotial_app/models/user_model.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialStates());

  static RegisterCubit get(context) => BlocProvider.of(context);


   void userRegister({
     required String email ,
     required String password,
     required String name,
     required String phone,
   }){
     emit(RegisterLoadingStates());

     FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: email,
         password: password
     ).then((value) {
       userCreate(
         uId:  value.user!.uid,
         name: name,
         email: email,
         phone: phone,
       );
       print(value.user!.email);
     }).catchError((error){
       print(error.toString());
       emit(RegisterErrorStates(error.toString()));
     });
   }

   void userCreate({
     required String email ,
     required String name,
     required String phone,
     required String uId,
     }){

     UserModel userModel = UserModel(
         name: name,
         email: email,
         phone: phone,
         uId: uId,
         image: 'https://img.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?size=338&ext=jpg',
         cover: 'https://img.freepik.com/free-photo/young-man-playing-football_23-2148867408.jpg?size=338&ext=jpg',
         bio: 'write your bio....',
         isEmailVerified: false
     );

     FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap()).then((value) {

       emit(CreateUserSuccessStates());
     }).catchError((error){
       emit(CreateUserErrorStates(error.toString()));
       print(error.toString());
     });
   }


   
  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShow = true;

  void changePasswordVisibility(){

    isPasswordShow =! isPasswordShow;
    suffix =isPasswordShow? Icons.visibility_outlined: Icons.visibility_off_outlined ;
    emit(RegisterChangePasswordStates());
  }

   // void checkEmailPassword(context){
   //   if(loginModel.status==true){
   //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
   //         ShopHomeScreen()), (Route<dynamic> route) => true);
   //   }else{
   //     showToast(loginModel.message);
   //   }
   //   emit(RegisterCheckEmailPasswordStates());
   // }


}