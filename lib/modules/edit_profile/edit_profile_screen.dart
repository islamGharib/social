import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/component/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();

  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        var userModel = SocialCubit.get(context).model;
        var profileImage = SocialCubit.get(context).profileImage;
        var profileCover = SocialCubit.get(context).profileCover;
        nameController.text = userModel!.name;
        bioController.text = userModel.bio;

        return Scaffold(
            appBar: defaultAppBar(
                context: context,
                title: 'Edit Profile',
              actions: [
                defaultTextButton(func: (){}, text: 'update'),
                SizedBox(width: 15,),
              ]
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
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
                                      image: (profileCover == null) ? NetworkImage('${userModel.cover}') : FileImage(profileCover) as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: (){
                                      SocialCubit.get(context).getProfileCover();
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
                                  backgroundImage: (profileImage == null) ? NetworkImage('${userModel.image}') : FileImage(profileImage) as ImageProvider,
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  SocialCubit.get(context).getProfileImage();
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
                  ],
                ),
              ),
            ),
        );
      },
    );
  }
}
