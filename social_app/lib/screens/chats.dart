import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:sotial_app/AppCubit/home_cubit.dart';
import 'package:sotial_app/AppState/home_states.dart';
import 'package:sotial_app/models/user_model.dart';
import 'package:sotial_app/screens/chat_details.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state) {HomeCubit.get(context).getAllUsers();},
        builder: (context, state) {
          return Conditional.single(
              context: context,
              conditionBuilder: (context) => HomeCubit.get(context).users.length >0,
              widgetBuilder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index) => buildChatItem(HomeCubit.get(context).users[index],context),
                  separatorBuilder: (context,index) => Container(height: 1,width: double.infinity,color: Colors.grey[300],),
                  itemCount: HomeCubit.get(context).users.length
              ),
              fallbackBuilder: (context) => Center(child: CircularProgressIndicator())
          );
        },
    );
  }

  Widget buildChatItem(UserModel model,context) => InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsScreen(userModel: model)),);
    },
    child: Padding(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(width: 15.0,),
              Text(
                '${model.name}',
                style:  TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
