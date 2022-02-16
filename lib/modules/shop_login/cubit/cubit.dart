import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/shop_login/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SocialLoginCubit extends Cubit<SocialLoginState>{
  SocialLoginCubit() : super(SocialLogininitialState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin(
      {
        required String email,
        required String password,
      }){
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error){
      print(error.code);
      emit(SocialLoginErrorState(error));
    });


  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(SocialLoginChangePasswordVisibilityState());
  }

}