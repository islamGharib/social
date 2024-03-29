import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
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

import '../../models/comment_model.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialGetUserInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUsersModel? userModel;

  void getUserData({String? userId }) {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(userId??uId).get().then((value) {
      userModel = SocialUsersModel.fromJson(value.data()!);
      print(userModel!.email);
      print(userModel!.cover);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
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

  void changeShopBottomNavigationIndex(int index) {
    if(index == 1)
      getAllUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeNavigationBarState());
    }
  }

  final ImagePicker picker = ImagePicker();

  File? profileImage;

  Future<void> getProfileImage() async {
    // Pick an image
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else
      emit(SocialProfileImagePickedErrorState());
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    // Pick an image
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else
      emit(SocialCoverImagePickedErrorState());
  }

  // void uploadProfileImage({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUpdateUserLoadingState());
  //   FirebaseStorage.instance.ref()
  //       .child('users/${Uri
  //       .file(profileImage!.path)
  //       .pathSegments
  //       .last}')
  //       .putFile(profileImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       //emit(SocialUploadProfileImageSuccessState());
  //       updateUserData(
  //           name: name,
  //           phone: phone,
  //           bio: bio,
  //         image: value
  //       );
  //     }).catchError((error) {
  //       emit(SocialUploadProfileImageErrorState());
  //     });
  //   }).catchError((error) {
  //     emit(SocialUploadProfileImageErrorState());
  //   });
  // }

  void uploadProfileImage() {
    emit(SocialUpdateUserLoadingState());
    FirebaseStorage.instance.ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        // updateUserData(
        //     name: name,
        //     phone: phone,
        //     bio: bio,
        //     image: value
        // );
        updateUserImages(image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  // void uploadCoverImage({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUpdateUserLoadingState());
  //   FirebaseStorage.instance.ref()
  //       .child('users/${Uri
  //       .file(coverImage!.path)
  //       .pathSegments
  //       .last}')
  //       .putFile(coverImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       //emit(SocialUploadCoverImageSuccessState());
  //       updateUserData(
  //           name: name,
  //           phone: phone,
  //           bio: bio,
  //           cover: value
  //       );
  //     }).catchError((error) {
  //       emit(SocialUploadCoverImageErrorState());
  //     });
  //   }).catchError((error) {
  //     emit(SocialUploadCoverImageErrorState());
  //   });
  // }

  void uploadCoverImage(){
    emit(SocialUpdateUserLoadingState());
    FirebaseStorage.instance.ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        // updateUserData(
        //     name: name,
        //     phone: phone,
        //     bio: bio,
        //     image: value
        // );
        updateUserImages(cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUpdateUserLoadingState());
  //   if(coverImage != null){
  //     uploadCoverImage();
  //   }else if(profileImage != null){
  //     uploadProfileImage();
  //   }else if(coverImage != null && profileImage != null){
  //
  //   } else{
  //     updateUserData(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUserImages({
    String? image,
    String? cover,
  }
      ) {
    SocialUsersModel model = SocialUsersModel(
        userModel!.uId,
        userModel!.name,
        userModel!.email,
        userModel!.phone,
        image ?? userModel!.image,
        cover ?? userModel!.cover,
        userModel!.bio,
    );

    FirebaseFirestore.instance.collection('users').doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateUserErrorState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }){
    SocialUsersModel model = SocialUsersModel(
        userModel!.uId,
        name,
        userModel!.email,
        phone,
        image??userModel!.image,
        cover??userModel!.cover,
        bio
    );

    FirebaseFirestore.instance.collection('users').doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateUserErrorState());
    });

  }



                        // posts
  File? postImage;

  Future<void> getPostImage() async {
    // Pick an image
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else
      emit(SocialPostImagePickedErrorState());
  }

  void removePostImage(){
    postImage = null;
    emit(SocialRemovePostImageState());

  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatingPostLoadingState());
    FirebaseStorage.instance.ref()
        .child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
            dateTime: dateTime,
            text: text,
            postImage: value
        );
      }).catchError((error) {
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadPostImageErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }){
    emit(SocialCreatingPostLoadingState());
    PostModel model = PostModel(
        userModel!.uId,
        userModel!.name,
        userModel!.image,
        text,
        postImage??'',
        dateTime
    );

    FirebaseFirestore.instance.collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatingPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatingPostErrorState());
    });

  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts(){
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime',descending: true)
        .get()
        .then((value) {
        //posts = [];
          value.docs.forEach((element) {
            element.reference
            .collection('Likes')
            .get()
            .then((value) {
              //print(element.data().toString());
              // posts.add(PostModel.fromJson(element.data()));
              // postsId.add(element.id);
              likes.add(value.docs.length);
            }).catchError((error){
              print(error.toString());
            });
          });
          //print(posts[0].text);
          emit(SocialGetPostsSuccessState());
        }).catchError((error){
          emit(SocialGetPostsErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime',descending: true)
        .get()
        .then((value) {
      //posts = [];
      value.docs.forEach((element) {
        element.reference
            .collection('comments')
            .get()
            .then((value) {
          posts.add(PostModel.fromJson(element.data()));
          postsId.add(element.id);
          commentNumbers.add(value.docs.length);
        }).catchError((error){
          print(error.toString());
        });
      });
      //print(posts[0].text);
      emit(SocialGetPostsSuccessState());
    }).catchError((error){
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModel!.uId)
        .set({'like' : true})
        .then((value) {
          emit(SocialLikePostSuccessState());
        }).catchError((error){
          emit(SocialLikePostErrorState(error));
    });
  }

  List<SocialUsersModel> users = [];
  void getAllUsers(){
    if (users.length == 0)
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if(element.data()['uId'] != userModel!.uId)
            users.add(SocialUsersModel.fromJson(element.data()));
        });
        //print(posts[0].text);
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error){
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }){
    MessageModel model = MessageModel(
        userModel!.uId,
        receiverId,
        dateTime,
        text,
    );

    // set my chats
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(model.toMap())
    .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });

    // set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });
  }

  // get all chat messages
  List<MessageModel> messages = [];
  void getMessages({
    required String receiverId,
  }){
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(SocialGetMessagesSuccessState());
    });
  }

  // login
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
      getUserData(userId: value.user!.uid);
      currentIndex = 0;
      users = [];
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

  void sendComment({
    required String postId,
    required String dateTime,
    required String text,
  }){
    CommentModel model = CommentModel(
      postId,
      userModel!.uId,
      userModel!.name,
      userModel!.image,
      dateTime,
      text,
    );

    // set my comments
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendCommentSuccessState());
    }).catchError((error){
      emit(SocialSendCommentErrorState());
    });
  }

  // get all comments for each post
  List<CommentModel> comments = [];
  List<int> commentNumbers = [];
  void getComments({
    required String postsId,
  }){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postsId)
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      comments = [];

      event.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data()));
      });
      print(comments.length);

      emit(SocialGetCommentsSuccessState());
    });
  }





}