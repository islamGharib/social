import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/upload_profile_image/upload_profile_image_screen.dart';
import 'package:social_app/shared/component/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../upload_cover_image/upload_cover_image_screen.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        var userModel = SocialCubit.get(context).userModel;
        nameController.text = userModel!.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;

        return Scaffold(
            appBar: defaultAppBar(
                context: context,
                title: 'Edit Profile',
              actions: [
                defaultTextButton(
                    func: (){
                      SocialCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text
                      );
                    },
                    text: 'update',
                ),
                SizedBox(width: 15,),
              ]
            ),
            body: SingleChildScrollView(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if(state is SocialUpdateUserLoadingState)
                      LinearProgressIndicator(),
                      if(state is SocialUpdateUserLoadingState)
                      SizedBox(height: 10.0,),
                      Container(
                        height: 190,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                      image: DecorationImage(
                                        //image: (profileCover == null) ? NetworkImage('${userModel.cover}') : FileImage(profileCover) as ImageProvider,
                                        image: NetworkImage('${userModel.cover}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        //SocialCubit.get(context).getCoverImage();
                                        navigateTo(context, UploadCoverImageScreen());
                                      },
                                      icon: CircleAvatar(
                                        radius: 20.0,
                                        child: Icon(
                                          IconBroken.Camera,
                                          size: 16.0,
                                        ),
                                      ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 64.0,
                                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: NetworkImage('${userModel.image}'),
                                  ),
                                ),
                                IconButton(
                                  onPressed: (){
                                    //SocialCubit.get(context).getProfileImage();
                                    navigateTo(context, UploadProfileImageScreen());
                                  },
                                  icon: CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      // if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                      // Row(
                      //   children: [
                      //     if(SocialCubit.get(context).profileImage != null)
                      //     Expanded(
                      //       child: Column(
                      //         children: [
                      //           defaultButton(
                      //             buttonPressed: (){
                      //               //SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                      //               //SocialCubit.get(context).profileImage = null;
                      //             },
                      //             text: 'upload profile',
                      //           ),
                      //           if(state is SocialUpdateUserLoadingState)
                      //           SizedBox(height: 5.0,),
                      //           if(state is SocialUpdateUserLoadingState)
                      //           LinearProgressIndicator(),
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(width: 5.0,),
                      //     if(SocialCubit.get(context).coverImage != null)
                      //     Expanded(
                      //       child: Column(
                      //         children: [
                      //           defaultButton(
                      //             buttonPressed: (){
                      //               SocialCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                      //               SocialCubit.get(context).coverImage = null;
                      //             },
                      //             text: 'upload cover',
                      //           ),
                      //           if(state is SocialUpdateUserLoadingState)
                      //           SizedBox(height: 5.0,),
                      //           if(state is SocialUpdateUserLoadingState)
                      //           LinearProgressIndicator(),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                      // SizedBox(height: 20.0,),
                      defaultTextFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value){
                          if (value == null || value.isEmpty){
                            return 'Name must not to be empty';
                          }
                          return null;
                        },
                        label: 'Name',
                        prefix: IconBroken.User,
                      ),
                      SizedBox(height: 10,),
                      defaultTextFormField(
                        controller: bioController,
                        type: TextInputType.text,
                        validate: (value){
                          if (value == null || value.isEmpty){
                            return 'Bio must not to be empty';
                          }
                          return null;
                        },
                        label: 'Bio',
                        prefix: IconBroken.Info_Circle,
                      ),
                      SizedBox(height: 10,),
                      defaultTextFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value){
                          if (value == null || value.isEmpty){
                            return 'Phone number must not to be empty';
                          }
                          return null;
                        },
                        label: 'Phone Number',
                        prefix: IconBroken.Call,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        );
      },
    );
  }
}
