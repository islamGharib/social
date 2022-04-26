import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/modules/social_register/cubit/states.dart';

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
    SocialUsersModel model = SocialUsersModel(
        uId,
        name,
        email,
        phone,
        'https://www.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_10421377.htm#query=photo%20attractive%20bearded%20young%20with%20cherful%20expression&position=0&from_view=search',
        'https://img.freepik.com/free-photo/top-view-delicious-fried-chicken-with-seasonings-vegetables-dark-space_140725-75663.jpg?t=st=1650441415~exp=1650442015~hmac=72a60a663bbe759eb6b1dcd61e4d7b435c3ec4c94bc3e85972487861d27aa842&w=900',
        'write your bio ...'
    );

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