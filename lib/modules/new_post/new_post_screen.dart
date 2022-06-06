import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/component/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        var userModel = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Create Post',
              actions: [
                defaultTextButton(
                  func: (){},
                  text: 'post'
                ),
              ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
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
                    decoration: InputDecoration(
                        hintText: 'what is in your mind...',
                        border: InputBorder.none
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
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
