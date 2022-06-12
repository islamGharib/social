import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../../models/post_model.dart';

class FeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state){},
      builder: (context, state){
          return Scaffold(
            body: ConditionalBuilder(
              condition: (SocialCubit.get(context).posts.length > 0),
              builder: (context) => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.all(8.0),
                      elevation: 5.0,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Image(
                            image: NetworkImage('https://img.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg?t=st=1648470843~exp=1648471443~hmac=e627e64a2eec9d1abe3d9db23ecb082fc29cadb26da7ab313811130fb0bf4169&w=900'),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Communicate with friends',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(context, SocialCubit.get(context).posts[index]),
                      separatorBuilder: (context, index) => SizedBox(height: 8.0,),
                      itemCount: (SocialCubit.get(context).posts.length),
                    ),
                    SizedBox(height: 8.0,)


                  ],
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator(),),
            ),
          );
      },
    );

    
  }

  Widget buildPostItem(context, PostModel model) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    elevation: 5.0,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(width: 15.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                        SizedBox(width: 5.0,),
                        Icon(
                          Icons.check_circle,
                          size: 16.0,
                          color: defaultColor,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15.0,),
              IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.more_horiz,
                  size: 16,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     bottom: 10,
          //     top: 5,
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(right: 6),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               onPressed: (){},
          //               child: Text(
          //                 '#software',
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                     color: defaultColor
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 6),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               onPressed: (){},
          //               child: Text(
          //                 '#flutter',
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                     color: defaultColor
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 6),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               onPressed: (){},
          //               child: Text(
          //                 '#software',
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                     color: defaultColor
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 6),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               onPressed: (){},
          //               child: Text(
          //                 '#flutter',
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                     color: defaultColor
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 6),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               onPressed: (){},
          //               child: Text(
          //                 '#software',
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                     color: defaultColor
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 6),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               onPressed: (){},
          //               child: Text(
          //                 '#flutter',
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                     color: defaultColor
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 6),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               onPressed: (){},
          //               child: Text(
          //                 '#software',
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                     color: defaultColor
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 6),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               onPressed: (){},
          //               child: Text(
          //                 '#flutter',
          //                 style: Theme.of(context).textTheme.caption!.copyWith(
          //                     color: defaultColor
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if (model.postImage != '')
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
                  image: NetworkImage('${model.postImage}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,),
            child: Row(
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
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 16.0,
                            color: Colors.amber,
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
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.image}'),
                      ),
                      SizedBox(width: 15.0,),
                      Text(
                        'write a comment ...',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
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
                onTap: (){},
              ),
            ],
          )

        ],
      ),
    ),
  );
  
}
