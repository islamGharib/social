import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/component/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit() : super(SocialGetUserInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUsersModel? model;

  void getUserData(){
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = SocialUsersModel.fromJson(value.data()!);
      print(model!.email);
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
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
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
        icon: Icon(IconBroken.Location),
        label: 'Users'
    ),
    BottomNavigationBarItem(
        icon: Icon(IconBroken.Setting),
        label: 'Settings'
    ),
  ];
  void changeShopBottomNavigationIndex(int index){
    currentIndex = index;
    emit(SocialChangeNavigationBarState());
  }

}