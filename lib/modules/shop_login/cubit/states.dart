
abstract class SocialLoginState{}
class SocialLogininitialState extends SocialLoginState{}
class SocialLoginLoadingState extends SocialLoginState{}
class SocialLoginSuccessState extends SocialLoginState{}
class SocialLoginErrorState extends SocialLoginState{
  final String error;
  SocialLoginErrorState(this.error);
}
class SocialLoginChangePasswordVisibilityState extends SocialLoginState{}