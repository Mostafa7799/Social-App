import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:sotial_app/AppCubit/home_cubit.dart';
import 'package:sotial_app/AppState/home_states.dart';
import 'package:sotial_app/models/post_model.dart';
import 'package:sotial_app/styles.dart';


// ignore: must_be_immutable
class FeedsScreen extends StatelessWidget {


  var textComController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        return Conditional.single(
            context: context,
            conditionBuilder: (context)=> HomeCubit.get(context).posts.length >0 &&  HomeCubit.get(context).userModel != null ,
            widgetBuilder: (context) =>  SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
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
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context ,index) => buildPostItem(HomeCubit.get(context).posts[index],context, index),
                    itemCount: HomeCubit.get(context).posts.length,
                    separatorBuilder: (BuildContext context, int index)=> SizedBox(height: 8,),
                  ),
                  SizedBox(height: 8,)
                ],
              ),
            ),
            fallbackBuilder: (context) => Center(child: CircularProgressIndicator(),)
        );
      },
    );
  }

  Widget buildPostItem(PostModel model , BuildContext context, index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(width: 20.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${model.name}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                height: 1.8
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0,),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16.0,
                        )
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          height: 1.4
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.0,),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.more_horiz)
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              color: Colors.grey[300],
              height: 1.0,
            ),
          ),
          Text(
            '${model.text}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.5,
                height: 1.7
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0,bottom: 10),
            width: double.infinity,
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 6),
                  height: 20.0,
                  child: MaterialButton(
                    onPressed: (){},
                    height: 20.0,
                    padding: EdgeInsets.zero,
                    minWidth: 1,
                    child: Text(
                      '#MostafaMahmoud',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if(model.postImage != '')
             Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: NetworkImage('${model.postImage}'),
                    fit: BoxFit.cover,
                  ),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 18,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            '${HomeCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.black87,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 18,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            '0k',
                            style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.black87,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){

                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.grey[300],
            height: 1.0,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage('${HomeCubit.get(context).userModel!.image}'),
                      ),
                      SizedBox(width: 20.0,),
                      Expanded(
                        child: Text(
                          'write your comment',
                          style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.w900,fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  onTap: (){
                    //HomeCubit.get(context).commentPost(HomeCubit.get(context).comment[index]);
                  },
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      size: 18,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.black87,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: (){
                  HomeCubit.get(context).likePost(HomeCubit.get(context).postsId[index]);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
