
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sotial_app/AppCubit/home_cubit.dart';
import 'package:sotial_app/AppState/home_states.dart';
import 'package:sotial_app/styles.dart';

class EditProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state) {},
        builder: (context,state) {
          var userModel = HomeCubit.get(context).userModel;
          var profileImage = HomeCubit.get(context).profileImage;
          var coverImage = HomeCubit.get(context).coverImage;

          var nameController = TextEditingController();
          var bioController = TextEditingController();
          var phoneController = TextEditingController();

          nameController.text= userModel!.name!;
          bioController.text= userModel.bio!;
          phoneController.text= userModel.phone!;


          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Edit Profile",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              actions: [
                TextButton(
                  onPressed: (){
                    HomeCubit.get(context).updateUserData(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
                SizedBox(width: 15,)
              ],
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if(state is UserUpdateLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    Container(
                      height: 190.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                    width: double.infinity,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0),
                                      ),
                                      image: coverImage == null ?  DecorationImage(
                                        image: NetworkImage('${userModel.cover}'),
                                        fit: BoxFit.cover,
                                      ): DecorationImage(
                                          image: FileImage(coverImage,scale: 1.0),
                                          fit: BoxFit.fill
                                      ),
                                    )
                                ),
                                IconButton(
                                  onPressed: (){
                                    HomeCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 20,
                                      child: Icon(
                                          IconBroken.Camera,
                                        size: 17,
                                        color: Colors.white,
                                      ),
                                  ),
                                ),
                              ],
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  //backgroundImage: profileImage != null ? NetworkImage('${userModel.image}') : FileImage(profileImage!),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                        image: profileImage == null ?  DecorationImage(
                                            image: NetworkImage('${userModel.image}'),
                                            fit: BoxFit.fill
                                        ) : DecorationImage(
                                            image: FileImage(profileImage,scale: 1.0),
                                            fit: BoxFit.fill
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  HomeCubit.get(context).getImage();
                                },
                                icon: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 20,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    if(HomeCubit.get(context).profileImage != null || HomeCubit.get(context).coverImage != null)
                      Row(
                       children: [
                          if(HomeCubit.get(context).coverImage != null)
                             Expanded(
                               child: Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               color: Colors.deepOrange,
                             ),
                                child: MaterialButton(
                               onPressed: (){
                                 HomeCubit.get(context).uploadCoverImage(
                                   name: nameController.text,
                                   phone: phoneController.text,
                                   bio: bioController.text,

                                 );
                               },
                               child: Text(
                                 'Upload Cover',
                                 style: TextStyle(
                                     color: Colors.white,
                                     fontWeight: FontWeight.bold
                                 ),
                               ),
                             ),
                           ),
                         ),
                           SizedBox(width: 7,),
                         if(HomeCubit.get(context).profileImage != null)
                             Expanded(
                               child: Container(
                                decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               color: Colors.deepOrange,
                             ),
                                 child: MaterialButton(
                               onPressed: (){
                                 HomeCubit.get(context).uploadProfileImage(
                                   name: nameController.text,
                                   phone: phoneController.text,
                                   bio: bioController.text,
                                 );
                               },
                               child: Text(
                                 'Upload Profile',
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold
                                 ),
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                    if(HomeCubit.get(context).profileImage != null || HomeCubit.get(context).coverImage != null)
                      SizedBox(height: 20,),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (String? value){
                        if(value!.isEmpty) return 'Name must be enter';
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        prefix: Icon(IconBroken.User),
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
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: bioController,
                      keyboardType: TextInputType.text,
                      validator: (String? value){
                        if(value!.isEmpty) return 'bio must be enter';
                      },
                      decoration: InputDecoration(
                        labelText: 'Bio',
                        prefix: Icon(IconBroken.Info_Circle),
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
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (String? value){
                        if(value!.isEmpty) return 'phone must be enter';
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        prefix: Icon(IconBroken.Call),
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
                  ],
                ),
              ),
            ),
          );
        },
    );
  }
}
