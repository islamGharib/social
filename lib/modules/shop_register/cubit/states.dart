
abstract class SocialRegisterState{}
class SocialRegisterInitialState extends SocialRegisterState{}
class SocialRegisterLoadingState extends SocialRegisterState{}
class SocialRegisterSuccessState extends SocialRegisterState{}
class SocialRegisterErrorState extends SocialRegisterState{
  final String error;
  SocialRegisterErrorState(this.error);
}
class SocialRegisterChangePasswordVisibilityState extends SocialRegisterState{}
class SocialCreateUserLoadingState extends SocialRegisterState{}
class SocialCreateUserSuccessState extends SocialRegisterState{}
class SocialCreateUserErrorState extends SocialRegisterState{
  final String error;
  SocialCreateUserErrorState(this.error);
}