
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotial_app/AppCubit/home_cubit.dart';
import 'package:sotial_app/AppState/home_states.dart';
import 'package:sotial_app/screens/new_post.dart';
import 'package:sotial_app/styles.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state) {
          if(state is NewPostState){
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostScreen()),);
          }
        },
        builder: (context,state){
          var cubit = HomeCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                cubit.title[cubit.currentIndex],
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              actions: [
                IconButton(
                    onPressed: (){},
                    icon: Icon(IconBroken.Notification)
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(IconBroken.Search),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index){
                  cubit.changeBottomNav(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home),
                    label: "Home"
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat),
                    label: "Chats",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Paper_Upload),
                    label: "Post",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Location),
                    label: "Users"
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting),
                    label: "Settings"
                  ),
                ],
            ),
          );
        },
    );
  }
}
