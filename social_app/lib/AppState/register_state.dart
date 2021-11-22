

abstract class RegisterStates {}

class RegisterInitialStates extends RegisterStates{}

class RegisterLoadingStates extends RegisterStates{}

class RegisterSuccessStates extends RegisterStates{
}

class RegisterErrorStates extends RegisterStates{
  final String error;

  RegisterErrorStates(this.error);

}

class RegisterChangePasswordStates extends RegisterStates{}


class RegisterCheckEmailPasswordStates extends RegisterStates{}

class CreateUserSuccessStates extends RegisterStates{
}

class CreateUserErrorStates extends RegisterStates{
  final String error;

  CreateUserErrorStates(this.error);

}