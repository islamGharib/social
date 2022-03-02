import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/component/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


class SocialLayoutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        SocialCubit socialCubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              socialCubit.titles[socialCubit.currentIndex],
            ),
          ),
          body: socialCubit.screens[socialCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: socialCubit.currentIndex,
            onTap: (index){
              socialCubit.changeShopBottomNavigationIndex(index);
            },
            items: socialCubit.bottomNavItems,
          ),

          // body: Column(
          //   children: [
          //     // if(!FirebaseAuth.instance.currentUser!.emailVerified)
          //     //   Container(
          //     //     color: Colors.amber.withOpacity(.6),
          //     //     child: Padding(
          //     //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //     //       child: Row(
          //     //         children: [
          //     //           Icon(Icons.info_outline),
          //     //           SizedBox(width: 15.0,),
          //     //           Text('Please verify your email'),
          //     //           Spacer(),
          //     //           defaultTextButton(
          //     //               func: (){
          //     //                 FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
          //     //                   showFlutterToast(message: 'Check your mail', state: ToastStates.SUCCESS);
          //     //                 }).catchError((error){});
          //     //               },
          //     //               text: 'SEND'
          //     //           ),
          //     //         ],
          //     //       ),
          //     //     ),
          //     //   ),
          //   ],
          // ),

        );
      },
    );
  }
}
