
abstract class SocialStates{}
class SocialGetUserInitialState extends SocialStates{}
class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final String error;
  SocialGetUserErrorState(this.error);
}
class SocialChangeNavigationBarState extends SocialStates{}
class SocialNewPostState extends SocialStates{}
class SocialProfileImagePickedSuccessState extends SocialStates{}
class SocialProfileImagePickedErrorState extends SocialStates{}