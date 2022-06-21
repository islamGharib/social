import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/component/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Create Post',
              actions: [
                defaultTextButton(
                  func: (){
                    var now = DateTime.now();
                    if(SocialCubit.get(context).postImage == null)
                      SocialCubit.get(context).createPost(
                          dateTime: now.toString(),
                          text: textController.text
                      );
                    else SocialCubit.get(context).uploadPostImage(
                        dateTime: now.toString(),
                        text: textController.text
                    );
                  },
                  text: 'post'
                ),
              ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatingPostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatingPostLoadingState)
                  SizedBox(height: 10.0,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('https://img.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg?w=900&t=st=1648470621~exp=1648471221~hmac=5d68d8759c15a4f8263dbfd26868d59c79283309e4f5b28b3db7eeb44060414c'),
                    ),
                    SizedBox(width: 15.0,),
                    Expanded(
                      child: Text(
                        'Islam Gharib',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15.0,),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'what is in your mind...',
                        border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(width: 20.0,),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: CircleAvatar(
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(width: 20.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: (){
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(width: 5.0,),
                            Text('add photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed:(){},
                          child: Text('# tags'),
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
