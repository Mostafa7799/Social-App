import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotial_app/AppCubit/register_cubit.dart';
import 'package:sotial_app/AppState/register_state.dart';

import 'package:sotial_app/screens/login_screen.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
           if(state is CreateUserSuccessStates){
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                 LoginScreen()), (Route<dynamic> route) => false);
             print("Success");
           }
        },
        builder: (context,state){
          return  Scaffold(
            body: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.black),
                      ),
                      Text(
                        "Register Now To communicate with people",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        controller: nameController,
                        validator: ( value){
                          if (value!.isEmpty) {
                            return 'This field required';
                          }
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Name",
                          prefix: Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: Colors.red, width: 0.5)),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        controller: emailController,
                        validator: ( value){
                          if (value!.isEmpty) {
                            return 'This field required';
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          prefix: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: Colors.red, width: 0.5)),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        controller: phoneController,
                        validator: ( value){
                          if (value!.isEmpty) {
                            return 'This field required';
                          }
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "phone",
                          prefix: Icon(Icons.phone_android),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: Colors.red, width: 0.5)),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        controller: passwordController,
                        validator: (value){
                          if (value!.isEmpty) {
                            return 'This field required';
                          }
                        },
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "password",
                          prefix: Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: Colors.red, width: 0.5)),
                          suffix: IconButton(
                            icon: Icon(RegisterCubit.get(context).suffix),
                            onPressed: (){
                              RegisterCubit.get(context).changePasswordVisibility();
                            },
                          ),
                        ),
                        obscureText:RegisterCubit.get(context).isPasswordShow,
                      ),
                      SizedBox(height: 30.0,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        width: double.infinity,
                        height: 50.0,
                        child: FloatingActionButton(
                          onPressed: (){
                            RegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                            );
                                  if(state is! RegisterLoadingStates){
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  LoginScreen()), (Route<dynamic> route) => false);
                              // ignore: unnecessary_statements
                            }else(
                               print("error")
                               );
                          },
                          child: Text("Register"),
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
