import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:sotial_app/AppCubit/home_cubit.dart';
import 'package:sotial_app/AppState/home_states.dart';
import 'package:sotial_app/models/message_model.dart';
import 'package:sotial_app/models/user_model.dart';
import 'package:sotial_app/styles.dart';



// ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;
  ChatDetailsScreen({
    required this.userModel
  });

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          HomeCubit.get(context).getMessages(receiverId: userModel.uId);

          return BlocConsumer<HomeCubit,HomeStates>(
            listener: (context,state) => {},
            builder: (context,state){
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          "${userModel.image}",
                        ),
                      ),
                      SizedBox(width: 15,),
                      Text(
                        '${userModel.name}',
                        style:  TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87
                        ),
                      ),
                    ],
                  ),
                ),
                body:  Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index)
                            {
                              var message = HomeCubit.get(context).messages[index];
                              if(HomeCubit.get(context).userModel!.uId == message.senderId)
                                return buildMyMessage (message);

                              return buildMessage (message);
                            },
                            separatorBuilder: (context,index) => SizedBox(height: 10,),
                            itemCount: HomeCubit.get(context).messages.length
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type Your Message Here...'
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(6),
                                color: Colors.blue,
                              ),
                              height: 50,
                              child: MaterialButton(
                                onPressed: (){
                                  HomeCubit.get(context).sendMessage(
                                      receiverId: '${userModel.uId}',
                                      dateTime: DateTime.now().toString(),
                                      text: textController.text
                                  );
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  IconBroken.Send,
                                  size: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }

  Widget buildMessage (MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      child: Text(
          '${model.text}'
          ),
    ),
  );

  Widget buildMyMessage (MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.6),
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      child: Text(
          '${model.text}'
      ),
    ),
  );
}
