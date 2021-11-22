import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotial_app/AppCubit/home_cubit.dart';
import 'package:sotial_app/AppState/home_states.dart';
import 'package:sotial_app/styles.dart';


// ignore: must_be_immutable
class NewPostScreen extends StatelessWidget {

  var textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        var postImage = HomeCubit.get(context).postImage;
        return  Scaffold(
          appBar: AppBar(
            title: Text(
              "Create Post",
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              TextButton(
                onPressed: (){
                  var now = DateTime.now();
                  if(HomeCubit.get(context).postImage == null){
                    HomeCubit.get(context).createPost(dateTime: now.toString(), text: textController.text);
                  }else{
                    HomeCubit.get(context).uploadPostImage(dateTime: now.toString(), text: textController.text);
                  }
                },
                child: Text(
                  "Post",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                if(state is PostUploadLoadingState)
                 LinearProgressIndicator(),
                if(state is PostUploadLoadingState)
                  SizedBox(height: 10.0,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('https://image.freepik.com/free-photo/photo-thoughtful-handsome-adult-european-man-holds-chin-looks-pensively-away-tries-solve-problem_273609-45891.jpg'),
                    ),
                    SizedBox(width: 20.0,),
                    Expanded(
                      child: Text(
                        'Mostafa Mahmoud',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1.8
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: "What is your mind....",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                if(HomeCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: FileImage(postImage!),
                                fit: BoxFit.fill
                            ),
                          ),
                      ),
                      IconButton(
                        onPressed: (){
                          HomeCubit.get(context).removePostImage();
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 20,
                          child: Icon(
                            Icons.close,
                            size: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: (){
                          HomeCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image,size: 24,),
                            SizedBox(width: 5,),
                            Text(
                              "Add Photo",
                              style: TextStyle(color: Colors.blue,fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){

                        },
                        child:  Text(
                          "# Tags",
                          style: TextStyle(color: Colors.blue,fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
     },
    );
  }
}
