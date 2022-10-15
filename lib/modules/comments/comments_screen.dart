import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/comment_model.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/post_model.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class CommentsScreen extends StatelessWidget {
  var commentTextController = TextEditingController();
  PostModel model ;
  String postId;
  bool showCamera = false;
  final formKey = GlobalKey<FormState>();
  CommentsScreen(
        this.model,
        this.postId,
      );
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black.withOpacity(0),
    ));
    return Builder(
      builder: (context){
        SocialCubit.get(context).getComments(postsId: postId);
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
                            ConditionalBuilder(
                                condition: SocialCubit.get(context).comments.length > 0,
                                builder: (context) => Expanded(
                                  child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var comment = SocialCubit.get(context).comments[index];
                                      return buildCommentItem(context, comment);
                                    },
                                    separatorBuilder: (context, index) => SizedBox(height: 8.0,),
                                    itemCount: SocialCubit.get(context).comments.length,
                                  ),
                                ),
                                fallback: (context) => Expanded(child: Center(child: Text('No Comments exist'),))
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: TextFormField(
                                        controller: commentTextController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Type your message here ...'
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: defaultColor,
                                    height: 50,
                                    child: MaterialButton(
                                      onPressed: (){
                                        SocialCubit.get(context).sendComment(postId: postId, dateTime: DateTime.now().toString(), text: commentTextController.text);
                                      },
                                      minWidth: 1,
                                      child: Icon(
                                        IconBroken.Send,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
      },
    );
  }

  Widget buildCommentItem(context, CommentModel model) => Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage(model.image),
          ),
          SizedBox(width: 15.0,),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            model.name,
                            style: TextStyle(
                              height: 1.4,
                            ),
                            maxLines: 6,
                          ),
                          Text(
                            model.text ,
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsetsDirectional.only(
                  //     top: 15.0,
                  //   ),
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: 140,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(4.0),
                  //       image: DecorationImage(
                  //         image: NetworkImage('https://img.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg?t=st=1648470843~exp=1648471443~hmac=e627e64a2eec9d1abe3d9db23ecb082fc29cadb26da7ab313811130fb0bf4169&w=900'),
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              )
          ),

        ],
      ),
    ],
  );
}
