import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_users_model.dart';
import 'package:social_app/modules/shop_register/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState>{
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {
        required String name,
        required String email,
        required String password,
        required String phone,
      }){
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(uId: value.user!.uid, name: name, email: email, phone: phone);
      //emit(SocialRegisterSuccessState());
    }).catchError((error){
      print(error.code);
      emit(SocialRegisterErrorState(error));
    });

  }

  void userCreate(
      {
        required String uId,
        required String name,
        required String email,
        required String phone,
      }){
    SocialUsersModel model = SocialUsersModel(uId, name, email, phone);

    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialCreateUserErrorState(error));
    });

  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }

}