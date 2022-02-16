import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/shared/component/constants.dart';

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

}