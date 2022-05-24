import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/component/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit() : super(SocialGetUserInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUsersModel? model;

  void getUserData(){
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = SocialUsersModel.fromJson(value.data()!);
      print(model!.email);
      print(model!.cover);
      emit(SocialGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialGetUserErrorState(error));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings'
  ];

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
        icon: Icon(IconBroken.Home),
        label: 'Home'
    ),
    BottomNavigationBarItem(
        icon: Icon(IconBroken.Chat),
        label: 'Chats'
    ),
    BottomNavigationBarItem(
        icon: Icon(IconBroken.Paper_Upload),
        label: 'Post'
    ),
    BottomNavigationBarItem(
        icon: Icon(IconBroken.Location),
        label: 'Users'
    ),
    BottomNavigationBarItem(
        icon: Icon(IconBroken.Setting),
        label: 'Settings'
    ),
  ];
  void changeShopBottomNavigationIndex(int index){
    if(index == 2)
      emit(SocialNewPostState());
    else{
      currentIndex = index;
      emit(SocialChangeNavigationBarState());
    }
  }

  final ImagePicker picker = ImagePicker();

  File? profileImage;
  Future<void> getProfileImage() async{
    // Pick an image
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else emit(SocialProfileImagePickedErrorState());
  }

  File? coverImage;
  Future<void> getProfileCover() async{
    // Pick an image
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }else emit(SocialCoverImagePickedErrorState());
  }

  String profileImageUrl = '';
  void uploadProfileImage(){
    FirebaseStorage.instance.ref()
        .child('users/${Uri.file(profileImage!.path)
        .pathSegments.last}')
        .putFile(profileImage!)
    .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImageSuccessState());
        profileImageUrl = value;
      }).catchError((error){
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error){
      emit(SocialUploadProfileImageErrorState());
    });
  }

  String coverImageUrl = '';
  void uploadCoverImage(){
    FirebaseStorage.instance.ref()
        .child('users/${Uri.file(coverImage!.path)
        .pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImageSuccessState());
        coverImageUrl = value;
      }).catchError((error){
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error){
      emit(SocialUploadCoverImageErrorState());
    });
  }

}