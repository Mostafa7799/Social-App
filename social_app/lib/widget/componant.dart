


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sotial_app/styles.dart';

void toast(String txt){
  Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}



void verification ()=>  Column(
  children: [
    if(FirebaseAuth.instance.currentUser!.emailVerified ==false)
      Container(
        color: Colors.amber.withOpacity(.6),
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Icon(Icons.info_outline),
              Spacer(),
              Text(
                'please verifying your email',
                style: TextStyle(color: Colors.black87,fontSize: 20.0),
              ),
              Spacer(),
              TextButton(
                onPressed: (){
                  FirebaseAuth.instance.currentUser!.sendEmailVerification(

                  ).then((value) {
                    print('success');
                  }).catchError((e){
                    print('error');
                  });
                },
                child: Text("Send Email",
                  style: TextStyle(color: Colors.white,fontSize: 20.0),),
              ),
            ],
          ),
        ),
      )
    else
      Center(child: Text('hello'),)
  ],
);


Widget buildAppBar({required BuildContext context ,String txt ='', List<Widget>? action}){
  return  AppBar(
    leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon: Icon(
        IconBroken.Arrow___Left_2
      ),
    ),
    title: Text(
      txt,
      style: TextStyle(color: Colors.black87),
    ),
    backgroundColor: Colors.white,
    elevation: 0,
  );
}