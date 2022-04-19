
abstract class SocialLoginState{}
class SocialLogininitialState extends SocialLoginState{}
class SocialLoginLoadingState extends SocialLoginState{}
class SocialLoginSuccessState extends SocialLoginState{
  final String uId;
  SocialLoginSuccessState(this.uId);
}
class SocialLoginErrorState extends SocialLoginState{
  final dynamic error;
  SocialLoginErrorState(this.error);
}
class SocialLoginChangePasswordVisibilityState extends SocialLoginState{}