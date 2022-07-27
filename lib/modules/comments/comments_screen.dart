import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/styles/icon_broken.dart';

class CommentsScreen extends StatelessWidget {
  var commentTextController = TextEditingController();
  bool showCamera = false;
  final formKey = GlobalKey<FormState>();
  final String postId;
  final String userId;
  final String userImage;
  CommentsScreen(
      this.postId,
      this.userId,
      this.userImage
      );
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black.withOpacity(0),
    ));
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          // backgroundColor: Colors.black,
          // body: Container(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Form(
          //         key: formKey,
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             Padding(
          //               padding: EdgeInsets.only(top: 50),
          //               child: TextFormField(
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                   ),
          //                   decoration: InputDecoration(
          //                       labelText: "Leave a Comment..",
          //                       labelStyle: TextStyle(
          //                         color: Colors.white,
          //                       )
          //                   ),
          //                   onSaved: (value) {
          //
          //                   }
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       ElevatedButton.icon(
          //           onPressed: (){},
          //           icon: Icon(Icons.send,
          //             color: Colors.white,
          //           ),
          //           label: Text(
          //               "Send"
          //           ))
          //
          //     ],
          //   ),
          // ),
          body: Container(
            color: Colors.black.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  top: 20,
                  bottom: 5,
                  start: 5,
                  end: 5
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0,),
                                  child: Row(
                                    children: [
                                      Icon(
                                        IconBroken.Heart,
                                        size: 16.0,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 5.0,),
                                      Text(
                                        '0',
                                        style: Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: (){},
                              ),
                            ),
                            InkWell(
                              child: Row(
                                children: [
                                  Icon(
                                    IconBroken.Heart,
                                    size: 16.0,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 5.0,),
                                  Text(
                                    'Like',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              onTap: (){

                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0,),
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => buildCommentItem(context, userImage),
                              separatorBuilder: (context, index) => SizedBox(height: 8.0,),
                              itemCount: 10,
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        // ElevatedButton.icon(
                        //     onPressed: (){},
                        //     icon: Icon(Icons.send,
                        //       color: Colors.white,
                        //     ),
                        //     label: Text(
                        //         "Send"
                        //     )),
                        Container(
                          width: double.infinity,
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 5.0,),
                        Form(
                          key: formKey,
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(15),
                              color: Colors.black.withOpacity(0.1),
                            ),
                            child: TextFormField(
                              controller: commentTextController,
                              decoration: InputDecoration(
                                  hintText: "Write a comment ...",
                                  border: InputBorder.none
                              ),
                              validator: (value){
                                if (value == null || value.isEmpty){
                                  return 'Post must not to be empty';
                                }
                                return null;
                              },
                              onTap: (){
                                showCamera = true;
                              },
                            ),
                          ),
                          // child: ListTile(
                          //   title: Container(
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadiusDirectional.circular(10),
                          //       color: Colors.black.withOpacity(0.1),
                          //     ),
                          //     child: TextFormField(
                          //       controller: commentTextController,
                          //       decoration: InputDecoration(
                          //         labelText: "Write a comment ...",
                          //           border: InputBorder.none
                          //       ),
                          //       validator: (value){
                          //         if (value == null || value.isEmpty){
                          //           return 'Post must not to be empty';
                          //         }
                          //         return null;
                          //       },
                          //       onTap: (){
                          //         showCamera = true;
                          //       },
                          //     ),
                          //   ),
                          //   trailing: OutlinedButton(
                          //     onPressed: (){
                          //       if(formKey.currentState!.validate()){
                          //         print('add comment');
                          //       }
                          //       },
                          //     child: Icon(Icons.send),
                          //   ),
                          // ),
                        ),
                        if (showCamera)
                          SizedBox(height: 5.0,),
                        if(showCamera)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(IconBroken.Camera),
                              Spacer(),
                              OutlinedButton(
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    print('add comment');
                                  }
                                },
                                child: Icon(
                                  Icons.send,
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCommentItem(context, userImage) => Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('$userImage'),
          ),
          SizedBox(width: 15.0,),
          Expanded(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Islam Gharib',
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: 6,
                          ),
                          SizedBox(height: 5,),
                          Text(
                            'Hi everyone Hello World, I\'m Islam Ahmed Ibrahim Gharib, Iam 29 years old' ,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 15.0,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: NetworkImage('https://img.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg?t=st=1648470843~exp=1648471443~hmac=e627e64a2eec9d1abe3d9db23ecb082fc29cadb26da7ab313811130fb0bf4169&w=900'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),

        ],
      ),
    ],
  );
}
