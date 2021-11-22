abstract class HomeStates{}


class HomeInitialState extends HomeStates{}

class GetUserLoadingState extends HomeStates{}

class GetUserSuccessState extends HomeStates{}

class GetUserErrorState extends HomeStates{
  final String error;

  GetUserErrorState(this.error);

}

class GetAllUserLoadingState extends HomeStates{}

class GetAllUserSuccessState extends HomeStates{}

class GetAllUserErrorState extends HomeStates{
  final String error;

  GetAllUserErrorState(this.error);

}

class GetPostLoadingState extends HomeStates{}

class GetPostSuccessState extends HomeStates{}

class GetPostErrorState extends HomeStates{
  final String error;

  GetPostErrorState(this.error);

}

class LikePostSuccessState extends HomeStates{}

class LikePostErrorState extends HomeStates{
  final String error;

  LikePostErrorState(this.error);

}


class CommentPostSuccessState extends HomeStates{}

class CommentPostErrorState extends HomeStates{
  final String error;

 CommentPostErrorState(this.error);

}

class ChangeBottomNavBarState extends HomeStates{}

class NewPostState extends HomeStates{}

class ProfileImageSuccessState extends HomeStates{}

class ProfileImageErrorState extends HomeStates{}

class UploadProfileImageSuccessState extends HomeStates{}

class UploadProfileImageErrorState extends HomeStates{}

class CoverImageSuccessState extends HomeStates{}

class CoverImageErrorState extends HomeStates{}

class UploadCoverImageSuccessState extends HomeStates{}

class UploadCoverImageErrorState extends HomeStates{}

class UserUpdateErrorState extends HomeStates{}

class UserUpdateLoadingState extends HomeStates{}

class PostCreateErrorState extends HomeStates{}

class PostCreateSuccessState extends HomeStates{}

class PostUploadLoadingState extends HomeStates{}

class PostImageSuccessState extends HomeStates{}

class PostImageErrorState extends HomeStates{}

class PostImageRemoveState extends HomeStates{}

class SendMessageSuccessState extends HomeStates{}

class SendMessageErrorState extends HomeStates{}

class GetMessagesSuccessState extends HomeStates{}

class GetMessagesErrorState extends HomeStates{}
