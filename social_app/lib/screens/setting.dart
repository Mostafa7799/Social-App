import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotial_app/AppCubit/home_cubit.dart';
import 'package:sotial_app/AppState/home_states.dart';
import 'package:sotial_app/screens/edit_profile.dart';
import 'package:sotial_app/screens/login_screen.dart';
import 'package:sotial_app/styles.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel = HomeCubit.get(context).userModel;


        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage('${userModel!.cover}'),
                              fit: BoxFit.cover,
                            ),
                          )
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0,),
              Text(
                "${userModel.name}",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
              ),
              SizedBox(height: 10.0,),
              Text(
                "${userModel.bio}",
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "Posts",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "Photos",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "400k",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "Follower",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "20",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "Following",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      child: Text(
                        'Add Photos',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  OutlinedButton(
                    onPressed: (){
                      Navigator.push(context,  MaterialPageRoute(builder: (context) =>  EditProfile()));
                    },
                    child: Icon(
                      IconBroken.Edit,
                      size: 15,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // OutlineButton(
                  //     onPressed: (){},
                  //   child: Text(
                  //     'Subscribe',
                  //     style: TextStyle(color: Colors.blue),
                  //   ),
                  // ),
                  // SizedBox(width: 20,),
                  // OutlineButton(
                  //     onPressed: (){},
                  //   child: Text(
                  //     'UnSubscribe',
                  //     style: TextStyle(color: Colors.blue),
                  //   ),
                  // ),
                  // SizedBox(width: 20,),
                  Expanded(
                    child: OutlineButton(
                        onPressed: (){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              LoginScreen()), (Route<dynamic> route) => false);
                        },
                      child: Text(
                        'Log Out',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10.0,
                margin: EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Image(
                      image: NetworkImage('https://image.freepik.com/free-photo/boy-bright-yellow-jacket-with-lemon-his-hand-blue-background_105538-1038.jpg'),
                      fit: BoxFit.cover,
                      height: 200.0,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Communicate With Friends",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
