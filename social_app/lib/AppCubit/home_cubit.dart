import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sotial_app/AppState/home_states.dart';
import 'package:sotial_app/models/message_model.dart';
import 'package:sotial_app/models/post_model.dart';
import 'package:sotial_app/models/user_model.dart';
import 'package:sotial_app/network/dio_helper.dart';
import 'package:sotial_app/screens/chats.dart';
import 'package:sotial_app/screens/feeds.dart';
import 'package:sotial_app/screens/new_post.dart';
import 'package:sotial_app/screens/setting.dart';
import 'package:sotial_app/screens/users.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sotial_app/var.dart';

class HomeCubit extends Cubit<HomeStates>{

  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  //dynamic uId = DioHelper.getData(token:'uId');

  UserModel? userModel;



  void getUserData(){
    emit(GetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc('wZLkt61YDkMOF90Yfz83AXpMCDJ3')
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data());
          emit(GetUserSuccessState());
    })
        .catchError((error){
          emit(GetUserErrorState(error.toString()));
    });
  }

  int currentIndex =0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  List<String> title = [
    'Home',
    'Chats',
    'New Post',
    'Users',
    'Settings'
  ];

  void changeBottomNav(int index){

    if(index==1)
      getAllUsers();
    if(index ==2)
      emit(NewPostState());
    else{
      currentIndex = index;
      emit(ChangeBottomNavBarState());
    }

  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null){
      profileImage = File(pickedFile.path);
      emit(ProfileImageSuccessState());
    }else{
      print('No Image Selected');
      emit(ProfileImageErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null){
      coverImage = File(pickedFile.path);
      emit(CoverImageSuccessState());
    }else{
      print('No Image Selected');
      emit(CoverImageErrorState());
    }
  }


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value) {
          value.ref.getDownloadURL().then((value) {

            updateUserData(name: name, phone: phone, bio: bio,profile: value);
            emit(UploadProfileImageSuccessState());
            print(value);
          }).catchError((error){
            emit(UploadProfileImageErrorState());
          });
    })
        .catchError((error){
      emit(UploadProfileImageErrorState());
    });
  }


  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value) {
          value.ref.getDownloadURL().then((value) {
            emit(UploadCoverImageSuccessState());

            updateUserData(name: name, phone: phone, bio: bio,cover: value);

          }).catchError((error){
            emit(UploadCoverImageErrorState());
          });
    })
        .catchError((error){
      emit(UploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //  required String name,
  //  required String phone,
  //   required String bio,
  // }){
  //   emit(UserUpdateLoadingState());
  //   if(coverImage != null)
  //     {
  //       uploadCoverImage();
  //     }else if(profileImage != null){
  //        uploadProfileImage();
  //   }else if(coverImage != null && profileImage != null){
  //
  //   }else{
  //     updateUserData(
  //       name: name,
  //       phone: phone,
  //       bio: bio
  //     );
  //   }
  // }


  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? profile,
    String? cover,
  }){
    UserModel model = UserModel(
      name: name,
      phone: phone,
      email: userModel!.email,
      cover: cover??userModel!.cover,
      image: profile??userModel!.image,
      uId: userModel!.uId,
      bio: bio,
      isEmailVerified: false
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error){
      emit(UserUpdateErrorState());
    });
  }



  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null){
      postImage = File(pickedFile.path);
      emit(PostImageSuccessState());
    }else{
      print('No Image Selected');
      emit(PostImageErrorState());
    }
  }

  void removePostImage(){
    postImage = null;
    emit(PostImageRemoveState());
  }


  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(PostUploadLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(postImage!.path).pathSegments.last}')
        .putFile(postImage!).then((value) {
      value.ref.getDownloadURL().then((value) {

        emit(PostImageSuccessState());
        createPost(dateTime: dateTime, text: text,postImage: value);
      }).catchError((error){
        emit(PostImageErrorState());
      });
    })
        .catchError((error){
      emit(PostImageErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }){
    emit(PostUploadLoadingState());
    PostModel model = PostModel(
        name: userModel!.name,
        image: userModel!.image,
        uId: userModel!.uId,
        dateTime: dateTime,
        text: text,
        postImage: postImage??''
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
          emit(PostCreateSuccessState());
    })
        .catchError((error){
      emit(PostCreateErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<String> comment = [];
  List<int> comments = [];

  void getPost(){
    FirebaseFirestore.instance.collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference
            .collection('likes')
            .get()
            .then((value) {
              likes.add(value.docs.length);
              postsId.add(element.id);
              posts.add(PostModel.fromJson(element.data()));
            })
            .catchError((error){});
          });
          emit(GetPostSuccessState());
    })
        .catchError((error) {
          emit(GetPostErrorState(error.toString()));
    });
  }

  void likePost(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like':true})
        .then((value) {
          emit(LikePostSuccessState());
    })
        .catchError((error) {
          emit(LikePostErrorState(error.toString()));
    });
  }

  // //commentPo(String postId){
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postId)
  //       .collection('comment')
  //       .doc(userModel!.uId)
  //       .set({'comment': true})
  //       .then((value) {
  //     emit(CommentPostSuccessState());
  //   });
  //
  // }

  void commentPost(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comment')
        .doc(userModel!.uId)
        .set({'comment':true})
        .then((value) {
      emit(CommentPostSuccessState());
    })
        .catchError((error) {
      emit(CommentPostErrorState(error.toString()));
    });
  }


  List<UserModel> users = [];

  void getAllUsers(){
    if (users.length==0)
      FirebaseFirestore.instance.collection('users')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if(element.data()['uId'] != userModel!.uId)
            users.add(UserModel.fromJson(element.data()));
        });
        emit(GetAllUserSuccessState());
      })
          .catchError((error) {
        emit(GetAllUserErrorState(error.toString()));
      });
    }


  void sendMessage({
     required String receiverId,
     required String dateTime,
    required  String text,

}){
    MessageModel model = MessageModel(senderId: userModel!.uId,receiverId: receiverId,dateTime: dateTime,text: text);

    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(model.toMap())
    .then((value) {

      emit(SendMessageSuccessState());
    })
    .catchError((error){

      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {

      emit(SendMessageSuccessState());
    })
        .catchError((error){

      emit(SendMessageErrorState());
    });


  }

  List<MessageModel> messages = [];

  void getMessages({required String? receiverId}){


    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages').
         orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(GetMessagesSuccessState());
    });
  }
}