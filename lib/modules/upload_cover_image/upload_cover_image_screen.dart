
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/component/components.dart';
import '../edit_profile/edit_profile_screen.dart';

class UploadCoverImageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state){},
        builder: (context, state){
          var userModel = SocialCubit.get(context).userModel;
          var profileCover = SocialCubit.get(context).coverImage;

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
                          SocialCubit.get(context).coverImage = null;
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
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.only(
                            //   topLeft: Radius.circular(4.0),
                            //   topRight: Radius.circular(4.0),
                            // ),
                            image: DecorationImage(
                              image: (profileCover == null) ? NetworkImage('${userModel!.cover}') : FileImage(profileCover) as ImageProvider,
                              fit: BoxFit.cover,
                            ),
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
                            SocialCubit.get(context).getCoverImage();
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
                            SocialCubit.get(context).uploadCoverImage();
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
