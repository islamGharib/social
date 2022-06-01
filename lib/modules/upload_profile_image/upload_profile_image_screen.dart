
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/component/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class UploadProfileImageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              top: 40.0,
              bottom: 8.0,
              left: 8.0,
              right: 8.0,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          SocialCubit.get(context).profileImage = null;
                          navigateAndFinish(context, EditProfileScreen());
                        },
                        icon: Icon(Icons.close),
                    ),
                    Text(
                      'Profile Photo',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: (profileImage == null) ? Image.network(
                          '${userModel!.image}',
                          width: double.infinity,
                          height: 400,
                          fit: BoxFit.cover,
                        ) : Image.file(
                            profileImage,
                          width: double.infinity,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if(state is SocialUpdateUserLoadingState)
                        SizedBox(height: 5.0,),
                      if(state is SocialUpdateUserLoadingState)
                        LinearProgressIndicator(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: (){
                          SocialCubit.get(context).getProfileImage();
                        },
                        child: Text(
                            'Change photo'
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: (){
                          SocialCubit.get(context).uploadProfileImage();
                          //SocialCubit.get(context).profileImage = null;
                        },
                        child: Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
