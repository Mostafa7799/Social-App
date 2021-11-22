import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotial_app/AppCubit/logincubit.dart';
import 'package:sotial_app/AppState/loginstates.dart';
import 'package:sotial_app/layout/home.dart';
import 'package:sotial_app/screens/register.dart';


// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, Object? state) {
          if(state is LoginErrorStates){
            return print("Some error");
          }else{
            print("Success");
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
             HomeScreen()), (Route<dynamic> route) => false);
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          "Login Now To communicate with people",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
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
                                borderSide: BorderSide(
                                    color: Colors.grey, width: 1.5)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    color: Colors.red, width: 0.5)),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field required';
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefix: Icon(Icons.lock_open_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    color: Colors.grey, width: 1.5)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    color: Colors.red, width: 0.5)),
                            suffix: IconButton(
                              icon: Icon(LoginCubit
                                  .get(context)
                                  .suffix),
                              onPressed: () {
                                LoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                            ),
                          ),
                          obscureText: LoginCubit
                              .get(context)
                              .isPasswordShow,
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
                            onPressed: () {
                               LoginCubit.get(context).userLogin(
                                   email: emailController.text,
                                   password: passwordController.text
                               );
                              //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              //     ShopHomeScreen()), (Route<dynamic> route) => false);
                            },
                            child: Text("Login"),
                            elevation: 0,
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Don\' have any account"
                            ),
                            SizedBox(width: 8.0,),
                            InkWell(
                              child: Text("register".toUpperCase(),
                                style: TextStyle(color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                    RegisterScreen()), (Route<dynamic> route) => true);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
